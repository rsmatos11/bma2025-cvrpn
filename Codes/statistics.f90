module statistics

  implicit none

  integer, parameter :: hlenmax = 10000

  ! Statistics of a run of the method. All of them are counters or
  ! records; they are not used in the computations.
  !
  ! BCD statistics:
  !
  ! bcdncalls is the number of calls to BCD bcdtotit is the total
  ! number of iterations (cycles) of BCD, added over all calls
  ! bcdmaxit is the maximum number of iterations in a single call to
  ! BCD bcdstp(0) is the number of calls to BCD that stopped by lack
  ! of progress bcdstp(1) is the number of calls to BCD that stopped
  ! by reaching the maximum of iterations bcdinc is the number of
  ! times the objective function value increased from one iteration of
  ! BCD to the next one (it is expected to be zero)
  !
  ! GVNS statistics:
  !
  ! ncycles is the number of cycles of GVNS nshakes is the number of
  ! shakes nneighs is the number of calls to routine Neighbor
  ! (neighborhood moves) tsol is the time at which the best solution
  ! of the run was found ncsol, nssol and nnsol are the values of
  ! ncycles, nshakes and nneighs, respectively, at the moment the best
  ! solution of the run was found
  !
  ! Statistics of the neighborhoods. The neighborhoods are numbered as
  ! in routine GVNS (1: 2-Opt, 2: 3-Opt, 3: Or-Opt, 4: 1-0-Exchange,
  ! 5: 1-1-Exchange, 6: 1-2-Exchange, 7: Relocate, 8: 2-Opt*, 9:
  ! Cross-Exchange). In the local search, the neighborhoods are used
  ! in three stages (1: problem type N without recomputing the visit
  ! points, 2: problem type G, 3: problem type N recomputing the visit
  ! points with BCD):
  !
  ! nbcalls(n,s) is the number of calls to routine Neighbor with
  ! neighborhood n in stage s nbimp(n,s) is the number of those calls
  ! that returned an improved solution nbgain(n,s) is the sum of the
  ! reductions of the objective function value obtained in those calls
  ! (with respect to the solution given to routine Neighbor, which is
  ! not the best solution of the run) nbtime(n,s) is the CPU time
  ! spent in those calls shcalls(n) is the number of calls to routine
  ! Shake with neighborhood n shtime(n) is the CPU time spent in those
  ! calls
  !
  ! History of the best solution of the run:
  !
  ! hlen is the number of records of the history vtime(i) is the time
  ! at which the i-th best solution was found and vsolval(i) is its
  ! objective function value (the first record corresponds to the
  ! initial solution, at time zero) hlenmax is the maximum number of
  ! records of the history
  
  type statistics_type
     integer :: bcdmaxit,ncycles,ncsol,nneighs,nnsol,nshakes,nssol
     integer(kind=8) :: bcdncalls,bcdtotit,bcdstp(0:1),bcdinc
     integer(kind=8) :: nbcalls(9,3),nbimp(9,3),shcalls(9)
     real(kind=8) :: nbgain(9,3),nbtime(9,3),shtime(9)
     real(kind=8) :: tsol

     integer :: hlen
     real(kind=8) :: vtime(hlenmax),vsolval(hlenmax)
  end type statistics_type

  public :: statistics_type,CreateStatistics,CleanStatistics,hlenmax

contains

  ! *****************************************************************
  ! *****************************************************************

  subroutine CreateStatistics(stat)

    implicit none

    ! SCALAR ARGUMENTS
    type(statistics_type), intent(inout) :: stat

    stat%hlen = 0
    
    ! BCD statistics
    stat%bcdncalls = 0
    stat%bcdtotit = 0
    stat%bcdmaxit = 0
    stat%bcdstp(0:1) = 0
    stat%bcdinc = 0

    ! Statistics of the neighborhoods
    stat%nbcalls(1:9,1:3) = 0
    stat%nbimp(1:9,1:3) = 0
    stat%nbgain(1:9,1:3) = 0.0d0
    stat%nbtime(1:9,1:3) = 0.0d0
    stat%shcalls(1:9) = 0
    stat%shtime(1:9) = 0.0d0

    ! GVNS statistics
    stat%ncycles = 0
    stat%nshakes = 0
    stat%nneighs = 0
    
    stat%tsol    = 0.0d0
    stat%ncsol   = 0
    stat%nssol   = 0
    stat%nnsol   = 0
    
  end subroutine CreateStatistics
  
  ! *****************************************************************
  ! *****************************************************************

  subroutine CleanStatistics(stat)

    implicit none

    ! SCALAR ARGUMENTS
    type(statistics_type), intent(inout) :: stat

    stat%hlen = 0
    
    ! BCD statistics
    stat%bcdncalls = 0
    stat%bcdtotit = 0
    stat%bcdmaxit = 0
    stat%bcdstp(0:1) = 0
    stat%bcdinc = 0

    ! Statistics of the neighborhoods
    stat%nbcalls(1:9,1:3) = 0
    stat%nbimp(1:9,1:3) = 0
    stat%nbgain(1:9,1:3) = 0.0d0
    stat%nbtime(1:9,1:3) = 0.0d0
    stat%shcalls(1:9) = 0
    stat%shtime(1:9) = 0.0d0

    ! GVNS statistics
    stat%ncycles = 0
    stat%nshakes = 0
    stat%nneighs = 0
    stat%tsol    = 0.0d0
    stat%ncsol   = 0
    stat%nssol   = 0
    stat%nnsol   = 0
    
  end subroutine CleanStatistics
  
  ! *****************************************************************
  ! *****************************************************************

  ! subroutine DeleteStatistics(stat)

  !   implicit none

  !   ! SCALAR ARGUMENTS
  !   type(statistics_type), intent(inout) :: stat

  ! end subroutine DeleteStatistics
  
end module statistics
