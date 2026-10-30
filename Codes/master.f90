program master

  use instance, only: instance_type,CreateInstance,DeleteInstance
  use solution, only: solution_type,CreateSolution,DeleteSolution,CopySolution,drawsol
  use statistics, only: statistics_type,CreateStatistics,CleanStatistics
  use dijkstra, only: DijkstraRoute
  use constructiveheuristcs, only: CW,NN,Barycenters
  use blockcoordinatedescent, only: BCD
  use neighborhoods, only: Neighbor,Shake
  use metaheuristics, only: GVNS

  implicit none

  ! EXTERNAL FUNCTIONS
  real(kind=8), external :: drand 

  ! PARAMETERS
  logical, parameter :: debug = .false.
  logical, parameter :: saverecords = .true.
  logical, parameter :: savefigure = .true.
  real(kind=8), parameter :: seedbase = 123456.0d0,macheps12 = sqrt( epsilon( 1.0d0 ) )

  ! LOCAL SCALARS
  logical :: recomp,flip,randroutes
  integer :: allocerr,bestrun,i,j,k,nb,nbcd,ncycles,nneighs,norder,nrungvns,nshakes,qmax,rmax,rnc,st
  real(kind=8) :: bcdmean,bestgvns,fbar,fbcd,fbest,fcw,fgvns,finish,fnn,seed,start,sumgvns,tcw,tlim,tnn,trun,tsol
  type(instance_type) :: inst
  type(solution_type) :: sol,solbest,solcw,solcvrpnbest,solnn,solrep
  type(statistics_type) :: stat,statrep

  ! LOCAL ARRAYS
  real(kind=8), allocatable :: c(:,:)
  character(len=256) :: figdir,figname,filename,instname,recdir
  character(len=32) :: bcdmeanstr,fstr,tbeststr,timestr,tlimstr,trunstr
  character(len=256) :: arg_filename,arg_otype,arg_rmax,arg_norder,arg_qmax,arg_flip,arg_randroutes,arg_tlim,arg_nrungvns
  character(len=2) :: inisol,otype,ptype
  character(len=14) :: nbname(9)
  character(len=5) :: stname(3)

  ! ------------------------------------------------------------
  ! Read command line arguments
  ! ------------------------------------------------------------

  ! otype:  Type of operation: 'B' = Best Improvement, 'F' = First Improvement
  ! rmax:   Maximum number of removed arcs or elements in the method
  ! norder: Order of neighborhoods when applying the GVNS algorithm
  ! qmax:   Maximum value for Q parameter (used in the method, e.g., shaking size)
  ! flip:   Boolean flag to activate the "flip" mechanism in the algorithm
  ! randroutes: Boolean flag to consider the routes in random order in the neighborhoods
  ! tlim:   Time limit in seconds for solving each instance
  ! nrungvns: Number of independent GVNS algorithm executions. If
  !         nrungvns = 0, GVNS is not executed: the initial solution is
  !         computed and, then, its routes are evaluated with the
  !         barycenters of the polygons as visit points and with the
  !         visit points computed by BCD starting from the barycenters.

  if ( command_argument_count() .lt. 9 ) then
     write(*,*) 'ERROR: 9 arguments are required!'
     write(*,*) 'Usage: ./master instance.dat otype rmax norder qmax flip randroutes tlim nrungvns'
     stop
  endif

  call get_command_argument(1,arg_filename)
  call get_command_argument(2,arg_otype)
  call get_command_argument(3,arg_rmax)
  call get_command_argument(4,arg_norder)
  call get_command_argument(5,arg_qmax)
  call get_command_argument(6,arg_flip)
  call get_command_argument(7,arg_randroutes)
  call get_command_argument(8,arg_tlim)
  call get_command_argument(9,arg_nrungvns)

  filename = trim(arg_filename)
  otype    = trim(arg_otype)

  if ( ( arg_flip .ne. 'true' .and. arg_flip .ne. 'false' ) .or. &
       ( arg_randroutes .ne. 'true' .and. arg_randroutes .ne. 'false' ) ) then
     write(*,*) 'ERROR: flip and randroutes must be true or false'
     stop
  end if

  read(arg_rmax,*) rmax
  read(arg_norder,*) norder
  read(arg_qmax,*) qmax
  read(arg_flip,*) flip
  read(arg_randroutes,*) randroutes
  read(arg_tlim,*) tlim
  read(arg_nrungvns,*) nrungvns

  if ( rmax .lt. 2 ) then
     write(*,*) 'ERROR: rmax must be greater than or equal to 2'
     stop
  end if

  if (debug) write(*,*) 'Instance: ',trim(filename)

  !----------------------------------------------------
  ptype  = 'N'        
  recomp = .true.
  seed   = seedbase
  !----------------------------------------------------

  ! Folders of the records of the runs (.csv files) and of the figures of the solutions (.mp files)
  recdir = 'records_method'
  figdir = 'figures_method'

  ! Names of the neighborhoods and of the stages of the local search, used in the records
  nbname(1:9) = (/ '2-Opt         ','3-Opt         ','Or-Opt        ','1-0-Exchange  ','1-1-Exchange  ', &
       '1-2-Exchange  ','Relocate      ','2-Opt*        ','Cross-Exchange' /)
  stname(1:3) = (/ 'N    ','G    ','N_BCD' /)

  ! Name of the instance (without the path and the extension), used in the
  ! names of the files with the records of the runs and with the figures
  instname = filename(index(filename,'/',back=.true.)+1:)
  i = index(instname,'.',back=.true.)
  if ( i .gt. 1 ) instname = instname(1:i-1)

  if ( savefigure ) call execute_command_line('mkdir -p ' // trim(figdir))

  call CreateInstance(inst,filename)  
  call CreateSolution(inst,solbest)
  call CreateSolution(inst,solcw)
  call CreateSolution(inst,solnn)
  call CreateSolution(inst,sol)
  call CreateSolution(inst,solcvrpnbest)
  call CreateStatistics(stat)

  write(*,*) 'Instance: ',trim(filename)
  write(*,'(1X,A,I0)') 'Number of clients = ',inst%nclients
  write(*,'(1X,A,I0)') 'Maximum vehicle capacity: ',int(inst%maxcap)
  write(*,*) 'Scale factor of the coordinates = ',inst%scalefactor
  write(*,*)

  ! The instance is solved with the coordinates translated, so that the
  ! depot is at the origin, and divided by inst%scalefactor (see module
  ! instance). All the lengths printed or saved by this program are
  ! multiplied by inst%scalefactor and all the visit points are
  ! transformed back (routine VisitPoints), i.e., they are in the units
  ! and in the coordinates of the instance file.

  write(*,*) '--------------------------------------------------------------------------------------------'
  if ( nrungvns .gt. 0 ) then
     write(*,*) 'Solving the CVRPN with GVNS (visit points computed by BCD):'
     write(*,*) 'Initial solution: Best candidate from CW or NN constructive heuristics.'
     write(*,'(1X,A,I0)') 'Number of independent runs = ',nrungvns
     write(*,'(1X,A,I0)') 'Time limit per run (in seconds) = ',int(tlim)
     write(*,'(1X,3A,I0,A,I0,A,I0,4A)') 'Parameters: otype = ',trim(otype),', rmax = ',rmax,', norder = ',norder, &
          ', qmax = ',qmax,', flip = ',trim(merge('true ','false',flip)), &
          ', randroutes = ',trim(merge('true ','false',randroutes))
     if ( randroutes .and. otype .eq. 'B' ) write(*,*) 'Note: randroutes is ignored when otype = B.'
     if ( saverecords ) write(*,*) 'Records of the runs saved in: ',trim(recdir)
     if ( savefigure ) write(*,*) 'Figures of the solutions saved in: ',trim(figdir)
  else
     write(*,*) 'GVNS is not executed (nrungvns = 0).'
     write(*,*) 'Initial solution: Best candidate from CW or NN constructive heuristics.'
     write(*,*) 'Its routes are evaluated with the barycenters of the polygons as visit points'
     write(*,*) 'and with the visit points computed by BCD starting from the barycenters.'
     if ( savefigure ) write(*,*) 'Figures of the solutions saved in: ',trim(figdir)
  end if
  write(*,*) '--------------------------------------------------------------------------------------------'
  write(*,*)
 
  !-------------------------------------------------------------------------------
  ! INITIAL SOLUTION: Best candidate between CW and NN
  !-------------------------------------------------------------------------------
  write(*,*) '----------------------------------------------------'
  write(*,*) '          CONSTRUCTIVE HEURISTICS PHASE             '
  write(*,*) '----------------------------------------------------'
  write(*,*)

  if ( nrungvns .gt. 0 ) write(*,*) '------------------------------'
  ! Execute Clarke and Wright (CW) Savings heuristic
  call cpu_time(start)
  call CW(stat,inst,solcw,seed,ptype,-1.0d0)
  call cpu_time(finish)
  fcw = inst%scalefactor * sum( solcw%length(1:solcw%nroutes) )
  tcw = finish - start

  ! Execute Nearest Neighbor (NN) heuristic
  call cpu_time(start)
  call NN(stat,inst,solnn,seed,ptype,1,0.0d0)
  call cpu_time(finish)
  fnn = inst%scalefactor * sum( solnn%length(1:solnn%nroutes) )
  tnn = finish - start
  
  ! Display objective function values f for both constructive methods
  if ( nrungvns .gt. 0 ) then
     write(*,*) 'f(CW) = ',fcw
     write(*,*) 'f(NN) = ',fnn
  end if

  ! Select the best initial incumbent solution
  if ( fcw .le. fnn ) then
     call CopySolution(inst,solcw,solbest)
     inisol = 'CW'
  else
     call CopySolution(inst,solnn,solbest)
     inisol = 'NN'
  end if

  fbest = inst%scalefactor * sum( solbest%length(1:solbest%nroutes) )

  !-------------------------------------------------------------------------------
  ! BARYCENTERS AND BCD ON THE ROUTES OF THE INITIAL SOLUTION (nrungvns = 0)
  !-------------------------------------------------------------------------------
  ! The routes of the initial solution are evaluated with the barycenters of the polygons
  ! as visit points. Then, BCD is applied to each route starting from the barycenters.
  ! This is what CW and NN do internally, so the solution obtained by BCD coincides with
  ! the initial solution used by GVNS.
  if ( nrungvns .eq. 0 ) then
     allocate(c(2,0:inst%nclients),stat=allocerr)
     if ( allocerr .ne. 0 ) then
        write(*,*) 'Allocation error.'
        stop
     end if

     call Barycenters(inst,c)

     ! Routes with the barycenters as visit points
     call CopySolution(inst,solbest,sol)

     do i = 1,sol%nroutes
        rnc = sol%nclients(i)
        if ( rnc .gt. 0 ) then
           do j = 1,rnc
              sol%pathcoo(1:2,j,i) = c(1:2,sol%route(j,i))
              sol%pathind(j,i) = -1
           end do

           sol%length(i) = norm2( c(1:2,sol%route(1,i)) - c(1:2,0) )
           do j = 2,rnc
              sol%length(i) = sol%length(i) + norm2( c(1:2,sol%route(j,i)) - c(1:2,sol%route(j-1,i)) )
           end do
           sol%length(i) = sol%length(i) + norm2( c(1:2,0) - c(1:2,sol%route(rnc,i)) )
        end if
     end do

     fbar = inst%scalefactor * sum( sol%length(1:sol%nroutes) )

     ! Figure of the initial solution with the barycenters as visit points
     if ( savefigure ) then
        figname = trim(figdir) // '/' // trim(instname) // '_ini_bar.mp'
        call drawsol(inst,sol,figname)
     end if

     write(*,*) '================  Initial Solution Report (barycenters)  ================'
     write(*,*) 'Heuristic: ',inisol
     write(*,*) 'Sum of all routes lengths = ',fbar
     write(*,*) 'Number of routes = ',count( sol%nclients(1:sol%nroutes) .gt. 0 )
     call PrintRoutes(sol)
     write(*,*)

     ! Copy of the routes with the barycenters, used below to measure the CPU time of BCD
     call CopySolution(inst,sol,solrep)

     ! BCD applied to each route, starting from the barycenters
     call CleanStatistics(stat)

     do i = 1,sol%nroutes
        rnc = sol%nclients(i)
        if ( rnc .gt. 0 ) then
           call BCD(stat,inst,rnc,sol%route(1:rnc,i),sol%pathcoo(1:2,1:rnc,i),sol%length(i))
        end if
     end do

     ! CPU time of BCD. A single run is below the resolution of the clock, so BCD is
     ! run again from the barycenters until at least one second has elapsed, and the
     ! CPU time of one run is the total time divided by the number of runs (nbcd)
     call CreateStatistics(statrep)
     nbcd = 0
     call cpu_time(start)
     finish = start
     do while ( finish - start .lt. 1.0d0 )
        do i = 1,solrep%nroutes
           rnc = solrep%nclients(i)
           if ( rnc .gt. 0 ) then
              do j = 1,rnc
                 solrep%pathcoo(1:2,j,i) = c(1:2,solrep%route(j,i))
              end do
              call BCD(statrep,inst,rnc,solrep%route(1:rnc,i),solrep%pathcoo(1:2,1:rnc,i),solrep%length(i))
           end if
        end do
        nbcd = nbcd + 1
        call cpu_time(finish)
     end do

     fbcd = inst%scalefactor * sum( sol%length(1:sol%nroutes) )

     ! Figure of the initial solution with the visit points computed by BCD
     if ( savefigure ) then
        figname = trim(figdir) // '/' // trim(instname) // '_ini_bcd.mp'
        call drawsol(inst,sol,figname)
     end if

     write(*,*) '================  BCD Solution Report  ================'
     write(*,*) 'Sum of all routes lengths = ',fbcd
     write(*,*) 'BCD CPU Time (in seconds) = ',( finish - start ) / nbcd
     write(*,'(1X,A,I0)') 'BCD number of runs used to measure the CPU time = ',nbcd
     write(*,'(1X,A,I0)') 'BCD total number of iterations = ',stat%bcdtotit
     write(*,'(1X,A,I0)') 'BCD maximum number of iterations in a route = ',stat%bcdmaxit
     call PrintRoutes(sol)
     write(*,*)
     write(*,*) '==========================================================='
     write(*,*)

     deallocate(c)

     call DeleteInstance(inst)
     call DeleteSolution(solbest)
     call DeleteSolution(solcw)
     call DeleteSolution(solnn)
     call DeleteSolution(sol)
     call DeleteSolution(solcvrpnbest)
     call DeleteSolution(solrep)

     stop
  end if

  write(*,*) '------------------------------'
  write(*,*)

  !-------------------------------------------------------------------------------
  ! INITIAL SOLUTION DETAILED REPORT
  !-------------------------------------------------------------------------------
  write(*,*) '================  Initial Solution Report  ================'
  write(*,*) 'Heuristic: ',inisol
  write(*,*) 'Sum of all routes lengths = ',fbest
  write(*,*) 'Number of routes = ',count( solbest%nclients(1:solbest%nroutes) .gt. 0 )

  do i = 1,solbest%nroutes
     if ( solbest%nclients(i) .gt. 0 ) then
        write(*,*)
        write(*,*) 'RouteID = ',count( solbest%nclients(1:i) .gt. 0 )
        write(*,*) 'Route number of clients = ',solbest%nclients(i)
        write(*,*) 'Route length = ',inst%scalefactor * solbest%length(i)
        write(*,*) 'Route demand = ',int( solbest%aggdem(i) )
        write(*,*) 'Sequence = ',solbest%route(1:solbest%nclients(i),i)
        write(*,*) 'Visit points = ',VisitPoints(solbest,i)
     end if
  end do
  write(*,*)

  if ( inisol .eq. 'CW' ) then
     write(*,*) 'Constructive heuristic CPU Time (in seconds) = ',tcw
  else
     write(*,*) 'Constructive heuristic CPU Time (in seconds) = ',tnn
  end if
  flush(6)
  
  write(*,*)

  ! Figure of the initial solution (best between CW and NN), which is the starting point of GVNS
  if ( savefigure ) then
     figname = trim(figdir) // '/' // trim(instname) // '_ini_bcd.mp'
     call drawsol(inst,solbest,figname)
  end if

  seed = seedbase
  bestgvns = huge(1.0d0)
  sumgvns = 0.0d0

  !-------------------------------------------------------------------------------
  ! RECORDS OF THE RUNS (.csv files)
  !-------------------------------------------------------------------------------
  ! The records are saved in folder recdir, in files whose names start
  ! with the name of the instance (without the path and the extension).
  if ( saverecords ) then
     call execute_command_line('mkdir -p ' // trim(recdir))

     ! File with one line per run. If it already exists, it is replaced.
     open(20,file=trim(recdir) // '/' // trim(instname) // '_runs.csv',status='replace')
     write(20,'(A)') 'instance,run,seed,f,t_best,t_total,routes,cycles,shakes,moves,' // &
          'cycles_total,shakes_total,moves_total,randroutes,otype,rmax,norder,qmax,flip,tlim,' // &
          'bcd_calls,bcd_cycles_mean,bcd_cycles_max,bcd_stop_noprogress,bcd_stop_maxit,bcd_increase'
     flush(20)

     ! File with the trajectory of the best solution of each run: one line for the initial
     ! solution (at time zero) and one line for each time the best solution of the run is improved.
     ! If it already exists, it is replaced.
     open(21,file=trim(recdir) // '/' // trim(instname) // '_traj.csv',status='replace')
     write(21,'(A)') 'instance,run,time,f'
     flush(21)

     ! File with the statistics of the neighborhoods in each run: for each neighborhood,
     ! one line for each stage of the local search (N, G and N_BCD) and one line for the shake.
     ! If it already exists, it is replaced.
     open(22,file=trim(recdir) // '/' // trim(instname) // '_neigh.csv',status='replace')
     write(22,'(A)') 'instance,run,neighborhood,stage,calls,improvements,total_gain,cpu_time'
     flush(22)
  end if
  
  !-------------------------------------------------------------------------------
  ! GVNS METAHEURISTIC PHASE
  !-------------------------------------------------------------------------------
  write(*,*) '----------------------------------------------------'
  write(*,*) '             GVNS METAHEURISTIC PHASE               '
  write(*,*) '----------------------------------------------------'
  write(*,*)

  do k = 1,nrungvns
     seed = k * seedbase    

     call CopySolution(inst,solbest,sol)   
     call CleanStatistics(stat)

     ! Execute the GVNS metaheuristic
     call cpu_time(start)
     call GVNS(stat,inst,sol,seed,otype,ptype,recomp,rmax,norder,qmax,flip,randroutes,tlim)
     call cpu_time(finish)
     trun = finish - start

     ! Compute the objective function value obtained in this run
     fgvns = inst%scalefactor * sum( sol%length(1:sol%nroutes) )
     sumgvns = sumgvns + fgvns

     ! Results of the current run
     write(*,*) 'Run = ',k,' | Runtime (s) = ',stat%tsol,' | f(GVNS) = ',fgvns
     flush(6)
     
     if ( saverecords ) then
        ! Record of the current run: objective function value, time at
        ! which the best solution was found (t_best), total time of the
        ! run (t_total), number of routes, number of cycles, shakes and
        ! moves at the moment the best solution was found and in the
        ! whole run, the parameters of the method, and the statistics of
        ! BCD in the run: number of calls, mean and maximum number of
        ! iterations (cycles) per call, number of calls that stopped by
        ! lack of progress and by reaching the maximum number of
        ! iterations, and number of times the objective function value
        ! increased from one iteration to the next one.
        if ( stat%bcdncalls .gt. 0 ) then
           bcdmean = real( stat%bcdtotit,kind=8 ) / real( stat%bcdncalls,kind=8 )
        else
           bcdmean = 0.0d0
        end if
        write(fstr,'(ES24.16E3)') fgvns
        write(tbeststr,'(F20.6)') stat%tsol
        write(trunstr,'(F20.6)') trun
        write(tlimstr,'(F20.1)') tlim
        write(bcdmeanstr,'(F20.6)') bcdmean
        write(20,'(A,",",I0,",",I0,3(",",A),7(",",I0),2(",",A),3(",",I0),2(",",A),",",I0,",",A,4(",",I0))') &
             trim(instname),k,int( k * seedbase,kind=8 ),trim(adjustl(fstr)),trim(adjustl(tbeststr)), &
             trim(adjustl(trunstr)),count( sol%nclients(1:sol%nroutes) .gt. 0 ),stat%ncsol,stat%nssol,stat%nnsol, &
             stat%ncycles,stat%nshakes,stat%nneighs,trim(merge('true ','false',randroutes)),trim(otype), &
             rmax,norder,qmax,trim(merge('true ','false',flip)),trim(adjustl(tlimstr)), &
             stat%bcdncalls,trim(adjustl(bcdmeanstr)),stat%bcdmaxit,stat%bcdstp(0),stat%bcdstp(1),stat%bcdinc
        flush(20)

        ! Trajectory of the best solution of the current run. It was
        ! stored in memory by GVNS during the run (see module statistics)
        ! and it is written here, after the end of the run.
        do i = 1,stat%hlen
           write(timestr,'(F20.6)') stat%vtime(i)
           write(fstr,'(ES24.16E3)') inst%scalefactor * stat%vsolval(i)
           write(21,'(A,",",I0,2(",",A))') trim(instname),k,trim(adjustl(timestr)),trim(adjustl(fstr))
        end do
        flush(21)

        ! Statistics of the neighborhoods in the current run. They were
        ! accumulated in memory by GVNS during the run (see module
        ! statistics) and they are written here, after the end of the
        ! run. In the lines of the shake, the number of improvements and
        ! the gain do not apply and are equal to zero.
        do nb = 1,9
           do st = 1,3
              write(fstr,'(ES24.16E3)') inst%scalefactor * stat%nbgain(nb,st)
              write(timestr,'(F20.6)') stat%nbtime(nb,st)
              write(22,'(A,",",I0,2(",",A),2(",",I0),2(",",A))') trim(instname),k,trim(nbname(nb)),trim(stname(st)), &
                   stat%nbcalls(nb,st),stat%nbimp(nb,st),trim(adjustl(fstr)),trim(adjustl(timestr))
           end do

           write(timestr,'(F20.6)') stat%shtime(nb)
           write(22,'(A,",",I0,2(",",A),",",I0,",0,0,",A)') trim(instname),k,trim(nbname(nb)),'shake', &
                stat%shcalls(nb),trim(adjustl(timestr))
        end do
        flush(22)
     end if

     ! Save the best GVNS run
     if ( fgvns .lt. bestgvns - macheps12 * max( 1.0d0, abs( bestgvns ) ) ) then
        call CopySolution(inst,sol,solcvrpnbest)
        bestgvns = fgvns
        bestrun  = k
        ncycles  = stat%ncsol
        nshakes  = stat%nssol
        nneighs  = stat%nnsol
        tsol     = stat%tsol
     end if
  end do

  write(*,*)
  write(*,*) '----------------------------------------------------'
  write(*,*) '             GVNS EXECUTION CONCLUDED               '
  write(*,*) '----------------------------------------------------'
  write(*,*)

  !-------------------------------------------------------------------------------
  ! FINAL REPORT: BEST SOLUTION
  !-------------------------------------------------------------------------------
  write(*,*) '==========================================================='
  write(*,*) '            FINAL EXPERIMENTAL RESULTS (BEST RUN)          '
  write(*,*) '===========================================================' 
  write(*,*) 'Best run = ',bestrun
  write(*,*) 'Best f(GVNS) = ',bestgvns
  write(*,*) 'Mean f(GVNS) = ',sumgvns / nrungvns
  write(*,*) 'Number of routes = ',count( solcvrpnbest%nclients(1:solcvrpnbest%nroutes) .gt. 0 )
  ! Algorithmic metrics recorded at the moment the best solution was found
  write(*,*) 'GVNS cycles = ',ncycles
  write(*,*) 'Shaking steps = ',nshakes
  write(*,*) 'Neighborhood moves = ',nneighs
  write(*,*) 'CPU Time of best run (s) = ',tsol
  write(*,*) '==========================================================='
  write(*,*)
  write(*,*) 'DETAILED ROUTE CONFIGURATION (BEST RUN):'

  ! Print route details ONLY for the best run found
  do i = 1, solcvrpnbest%nroutes
     if ( solcvrpnbest%nclients(i) .gt. 0 ) then
        write(*,*)
        ! Dynamically compute the sequential Route ID bypassing empty slots
        write(*,*) 'RouteID = ',count( solcvrpnbest%nclients(1:i) .gt. 0 )
        write(*,*) 'Route number of clients = ',solcvrpnbest%nclients(i)
        write(*,*) 'Route length = ',inst%scalefactor * solcvrpnbest%length(i)
        write(*,*) 'Route demand = ',int( solcvrpnbest%aggdem(i) )
        write(*,*) 'Sequence = ',solcvrpnbest%route(1:solcvrpnbest%nclients(i),i)
        write(*,*) 'Visit points = ',VisitPoints(solcvrpnbest,i)
     end if
  end do
  write(*,*)
  write(*,*) '==========================================================='
  write(*,*)

  ! Figure of the best solution found by GVNS
  if ( savefigure ) then
     figname = trim(figdir) // '/' // trim(instname) // '_gvns.mp'
     call drawsol(inst,solcvrpnbest,figname)
  end if

  if ( saverecords ) then
     close(20)
     close(21)
     close(22)
  end if

  call DeleteInstance(inst)
  call DeleteSolution(solbest)
  call DeleteSolution(solcw)  
  call DeleteSolution(solnn)
  call DeleteSolution(sol)
  call DeleteSolution(solcvrpnbest)

contains

  ! *****************************************************************
  ! *****************************************************************

  subroutine PrintRoutes(s)

    ! This routine prints the (non-empty) routes of solution s, with the
    ! lengths and the visit points in the units and in the coordinates
    ! of the instance file.

    implicit none

    ! SCALAR ARGUMENTS
    type(solution_type), intent(in) :: s

    ! LOCAL SCALARS
    integer :: r

    do r = 1,s%nroutes
       if ( s%nclients(r) .gt. 0 ) then
          write(*,*)
          write(*,*) 'RouteID = ',count( s%nclients(1:r) .gt. 0 )
          write(*,*) 'Route number of clients = ',s%nclients(r)
          write(*,*) 'Route length = ',inst%scalefactor * s%length(r)
          write(*,*) 'Route demand = ',int( s%aggdem(r) )
          write(*,*) 'Sequence = ',s%route(1:s%nclients(r),r)
          write(*,*) 'Visit points = ',VisitPoints(s,r)
       end if
    end do

  end subroutine PrintRoutes

  ! *****************************************************************
  ! *****************************************************************

  function VisitPoints(s,r)

    ! This function returns the visit points of route r of solution s
    ! in the coordinates of the instance file.

    implicit none

    ! SCALAR ARGUMENTS
    integer, intent(in) :: r
    type(solution_type), intent(in) :: s

    ! FUNCTION RESULT
    real(kind=8) :: VisitPoints(2,s%nclients(r))

    ! LOCAL SCALARS
    integer :: j

    do j = 1,s%nclients(r)
       VisitPoints(1:2,j) = inst%depot(1:2) + inst%scalefactor * s%pathcoo(1:2,j,r)
    end do

  end function VisitPoints

end program master
