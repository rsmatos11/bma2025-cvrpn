module cvrpncplexinitsol

  use, intrinsic :: iso_c_binding, only: c_char,c_double,c_int,c_null_char
  use instance, only: instance_type,CreateInstance,DeleteInstance
  use solution, only: solution_type,CreateSolution,DeleteSolution,CopySolution
  use statistics, only: statistics_type,CreateStatistics
  use constructiveheuristics, only: CW,NN,Barycenters

  implicit none

  ! This module is the interface between the CPLEX model written in
  ! C++ (cvrpncplexmodels.cpp) and the constructive heuristics of the
  ! method. It computes the initial solution that is given to CPLEX,
  ! which is the best one between the solutions of the Clarke and
  ! Wright (CW) and the Nearest Neighbor (NN) heuristics, exactly as
  ! it is done in master.f90.
  !
  ! The instance is read from the same file that is read by the C++
  ! code. The solution is returned to the C++ code in arrays; no file
  ! is written.

  public :: cvrpn_initial_solution

contains

  ! *****************************************************************
  ! *****************************************************************

  subroutine cvrpn_initial_solution(cfilename,nclients,heur,fbest,fbar,nroutes,rnc,route,pathcoo) &
       bind(C,name='cvrpn_initial_solution')

    ! On entry:
    !
    ! cfilename is the name of the instance file (C string, i.e.
    !    terminated by a null character)
    ! nclients is the number of clients of the instance (it is used to
    !    dimension the output arrays and it must coincide with the
    !    number of clients read from the file)
    !
    ! On return:
    !
    ! heur indicates the heuristic that computed the solution (1 = CW, 2 = NN)
    ! fbest is the sum of the lengths of the routes of the solution
    ! fbar is the sum of the lengths of the same routes when the
    !    barycenters of the polygons are used as visit points (the
    !    visit points of the solution are computed by BCD starting
    !    from the barycenters)
    ! nroutes is the number of (non-empty) routes of the solution
    ! rnc(r) is the number of clients of route r
    ! route(1:nclients) is the list of clients of route 1, followed by
    !    the list of clients of route 2, and so on
    ! pathcoo(1:2,j) Cartesian coordinates of the visit point of
    !    client route(j)

    implicit none

    ! SCALAR ARGUMENTS
    integer(kind=c_int), value, intent(in) :: nclients
    integer(kind=c_int), intent(out) :: heur,nroutes
    real(kind=c_double), intent(out) :: fbest,fbar

    ! ARRAY ARGUMENTS
    character(kind=c_char), intent(in) :: cfilename(*)
    integer(kind=c_int), intent(out) :: rnc(nclients),route(nclients)
    real(kind=c_double), intent(out) :: pathcoo(2,nclients)

    ! PARAMETERS
    real(kind=8), parameter :: seedbase = 123456.0d0

    ! LOCAL SCALARS
    character :: ptype
    integer :: allocerr,i,j,pos,rsize
    real(kind=8) :: fcw,fnn,seed
    type(instance_type) :: inst
    type(solution_type) :: solbest,solcw,solnn
    type(statistics_type), save :: stat

    ! LOCAL ARRAYS
    real(kind=8), allocatable :: c(:,:),lbar(:)
    character(len=256) :: filename

    ! Convert the C string into a Fortran string
    filename = ' '
    i = 1
    do while ( cfilename(i) .ne. c_null_char )
       if ( i .gt. len( filename ) ) then
          write(*,*) 'ERROR: The name of the instance file is too long.'
          stop
       end if
       filename(i:i) = cfilename(i)
       i = i + 1
    end do

    call CreateInstance(inst,filename)

    if ( inst%nclients .ne. nclients ) then
       write(*,*) 'ERROR: Unexpected number of clients in the instance file.'
       stop
    end if

    call CreateSolution(inst,solbest)
    call CreateSolution(inst,solcw)
    call CreateSolution(inst,solnn)
    call CreateStatistics(stat)

    ! =============================================
    ! CONSTRUCTIVE HEURISTICS
    ! =============================================

    ! The heuristics are called with the same parameters and the same
    ! seed used in master.f90. Visit points are computed by BCD.

    ptype = 'N'
    seed = seedbase

    ! Execute Clarke and Wright (CW) Savings heuristic
    call CW(stat,inst,solcw,seed,ptype,-1.0d0)
    fcw = sum( solcw%length(1:solcw%nroutes) )

    ! Execute Nearest Neighbor (NN) heuristic
    call NN(stat,inst,solnn,seed,ptype,1,0.0d0)
    fnn = sum( solnn%length(1:solnn%nroutes) )

    ! Select the best solution
    if ( fcw .le. fnn ) then
       call CopySolution(inst,solcw,solbest)
       heur = 1
       fbest = inst%scalefactor * fcw
    else
       call CopySolution(inst,solnn,solbest)
       heur = 2
       fbest = inst%scalefactor * fnn
    end if

    ! =============================================
    ! ROUTES WITH THE BARYCENTERS AS VISIT POINTS
    ! =============================================

    ! The lengths are computed route by route and then added, in the
    ! same way it is done in master.f90, so that the value returned
    ! coincides with the one reported by the Fortran method.

    allocate(c(2,0:inst%nclients),lbar(inst%nclients),stat=allocerr)
    if ( allocerr .ne. 0 ) then
       write(*,*) 'Allocation error.'
       stop
    end if

    call Barycenters(inst,c)

    ! lbar(i) is the length of route i with the barycenters as visit points
    lbar(1:solbest%nroutes) = 0.0d0
    do i = 1,solbest%nroutes
       rsize = solbest%nclients(i)
       if ( rsize .gt. 0 ) then
          lbar(i) = norm2( c(1:2,solbest%route(1,i)) - c(1:2,0) )
          do j = 2,rsize
             lbar(i) = lbar(i) + norm2( c(1:2,solbest%route(j,i)) - c(1:2,solbest%route(j-1,i)) )
          end do
          lbar(i) = lbar(i) + norm2( c(1:2,0) - c(1:2,solbest%route(rsize,i)) )
       end if
    end do

    fbar = inst%scalefactor * sum( lbar(1:solbest%nroutes) )

    deallocate(c,lbar)

    ! =============================================
    ! RETURN THE BEST SOLUTION
    ! =============================================

    ! The instance is solved with the coordinates translated, so that
    ! the depot is at the origin, and divided by inst%scalefactor (see
    ! module instance). The values returned are multiplied by
    ! inst%scalefactor and the visit points are transformed back, i.e.,
    ! they are in the units and in the coordinates of the instance file.

    ! Empty routes are discarded
    nroutes = 0
    pos = 0
    do i = 1,solbest%nroutes
       rsize = solbest%nclients(i)
       if ( rsize .gt. 0 ) then
          nroutes = nroutes + 1
          rnc(nroutes) = rsize
          do j = 1,rsize
             route(pos+j) = solbest%route(j,i)
             pathcoo(1:2,pos+j) = inst%depot(1:2) + inst%scalefactor * solbest%pathcoo(1:2,j,i)
          end do
          pos = pos + rsize
       end if
    end do

    if ( pos .ne. nclients ) then
       write(*,*) 'ERROR: The initial solution does not visit every client exactly once.'
       stop
    end if

    call DeleteSolution(solbest)
    call DeleteSolution(solcw)
    call DeleteSolution(solnn)
    call DeleteInstance(inst)

  end subroutine cvrpn_initial_solution

end module cvrpncplexinitsol
