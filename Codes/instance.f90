module instance

  implicit none

  logical, parameter :: debug = .false.
  
  ! nclients is the number of clients
  ! npmax is the maximum number of points or vertices per client
  ! np(k) is the number of points of client k
  ! p(1:2,i,k) Cartesian coordinates of point i of client k
  ! maxlen is the maximum allowed length of a route in a solution
  ! dist(i1,k1,i2,k2) corresponds to the distance from point i1 of client k1 to the point i2 of client k2
  ! depot(1:2) Cartesian coordinates of the depot in the instance file (original depot)
  ! scalefactor is the factor by which the coordinates were divided

  ! The coordinates are translated and scaled when the instance is read.
  ! First, they are translated so that the depot is at the origin.
  ! Then, if the largest absolute value of a translated coordinate is larger than one,
  ! all the coordinates are divided by it, so that all the polygons are contained in the square [-1,1]^2;
  ! otherwise, scalefactor is equal to one and the coordinates are not divided.
  ! This is the same transformation applied by the program that solves the CPLEX model
  ! (routine scaleVertices, file cvrpninstance.hpp).
  !
  ! p and dist are in the transformed coordinates. A length in the
  ! units of the instance file is scalefactor times the corresponding
  ! length computed from p, and a point q(1:2) in the transformed
  ! coordinates corresponds to depot(1:2) + scalefactor * q(1:2) in
  ! the coordinates of the instance file.

  ! By definition client k=0 corresponds to the depot, np(0) = 1, and
  ! p(1:2,1,0) corresponds to the Cartesian coordinates of the depot.
  
  type instance_type
     integer :: nclients,npmax
     real(kind=8) :: maxlen,maxcap,scalefactor,depot(2)
     integer, allocatable :: np(:)
     real(kind=8), allocatable :: p(:,:,:),dist(:,:,:,:),dem(:)
  end type instance_type

  public :: instance_type,CreateInstance,DeleteInstance

contains

  ! *****************************************************************
  ! *****************************************************************

  subroutine CreateInstance(inst,filename)

    implicit none

    ! SCALAR ARGUMENTS
    type(instance_type), intent(inout) :: inst

    ! ARRAY ARGUMENTS
    character(len=256), intent(in) :: filename
    
    ! LOCAL SCALARS
    integer :: allocerr,i1,i2,j,k,k1,k2

    inst%maxlen = huge(1.0d0)
        
    open(10,file=trim(adjustl(filename)))

    read(10,*) inst%maxcap
    read(10,*) inst%nclients
    read(10,*) inst%npmax

    allocate(inst%dem(1:inst%nclients), &
         inst%np(0:inst%nclients), &
         inst%p(2,inst%npmax,0:inst%nclients), &
         inst%dist(1:inst%npmax,0:inst%nclients,1:inst%npmax,0:inst%nclients), &
         stat=allocerr)

    if ( allocerr .ne. 0 ) then
       write(*,*) 'Allocation error.'
       stop
    end if

    ! Demand of each client
    do k = 1,inst%nclients
       read(10,*) inst%dem(k)
    end do
    
    ! Points or vertices of each client
    do k = 0,inst%nclients
       read(10,*) inst%np(k)
       do j = 1,inst%np(k)
          read(10,*) inst%p(1:2,j,k)
       end do
    end do

    ! Translation: the depot is moved to the origin
    inst%depot(1:2) = inst%p(1:2,1,0)
    do k = 0,inst%nclients
       do j = 1,inst%np(k)
          inst%p(1:2,j,k) = inst%p(1:2,j,k) - inst%depot(1:2)
       end do
    end do

    ! Scale factor: the largest absolute value of a translated coordinate.
    ! If it is larger than one, the coordinates are divided by it.
    inst%scalefactor = 0.0d0
    do k = 0,inst%nclients
       inst%scalefactor = max( inst%scalefactor, maxval( abs( inst%p(1:2,1:inst%np(k),k) ) ) )
    end do

    if ( inst%scalefactor .gt. 1.0d0 ) then
       do k = 0,inst%nclients
          inst%p(1:2,1:inst%np(k),k) = inst%p(1:2,1:inst%np(k),k) / inst%scalefactor
       end do
    else
       inst%scalefactor = 1.0d0
    end if

    ! Distance matrix between all pairs of points    
    do k1 = 0,inst%nclients
       do i1 = 1,inst%np(k1)
          do k2 = k1 + 1,inst%nclients
             do i2 = 1,inst%np(k2)
                inst%dist(i2,k2,i1,k1) = norm2( inst%p(1:2,i2,k2) - inst%p(1:2,i1,k1) )
                inst%dist(i1,k1,i2,k2) = inst%dist(i2,k2,i1,k1)
             end do
          end do
       end do
    end do
    
    close(10)

    if ( debug ) then
       write(*,*) 'maxlen = ',inst%maxlen
       write(*,*) 'maxcap = ',inst%maxcap
       write(*,*) 'scalefactor = ',inst%scalefactor
       write(*,*) 'depot = ',inst%depot(1:2)
       write(*,*) 'nclients = ',inst%nclients
       write(*,*) 'Demand of each client: '
       do k = 1,inst%nclients
          write(*,*) inst%dem(k)
       end do
       write(*,*) 'npmax = ',inst%npmax
       write(*,*) 'Points or vertices of each client: '
       do k = 0,inst%nclients
          write(*,*) 'client: ',k
          write(*,*) 'number of points: ',inst%np(k)
          do j = 1,inst%np(k)
             write(*,*) 'point ',j,' coordinates = ',inst%p(1:2,j,k)
          end do
       end do
       write(*,*) 'Distance matrix between all pairs of points: '
       do k1 = 0,inst%nclients
          do i1 = 1,inst%np(k1)
             do k2 = k1 + 1,inst%nclients
                do i2 = 1,inst%np(k2)
                   write(*,*) 'k1, i1, k2, i2: ',k1,i1,k2,i2,' dist = ',inst%dist(i1,k1,i2,k2)
                   write(*,*) 'k2, i2, k1, i1: ',k2,i2,k1,i1,' dist = ',inst%dist(i2,k2,i1,k1)
                end do
             end do
          end do
       end do
    end if
       
    end subroutine CreateInstance
  
  ! *****************************************************************
  ! *****************************************************************

  subroutine DeleteInstance(inst)

    implicit none

    ! SCALAR ARGUMENTS
    type(instance_type), intent(inout) :: inst

    ! LOCAL SCALARS
    integer :: allocerr

    deallocate(inst%dem,inst%np,inst%p,inst%dist,stat=allocerr)
    
    if ( allocerr .ne. 0 ) then
       write(*,*) 'Deallocation error.'
       stop
    end if

  end subroutine DeleteInstance
  
end module instance
