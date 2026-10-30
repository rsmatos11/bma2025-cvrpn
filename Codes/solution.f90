module solution

  use instance, only: instance_type
  
  implicit none

  logical, parameter :: debug = .false.
  
  ! nroutes is the number of routes
  ! nclients(r) is the number of clients of route r
  ! route(1:nclients(r),r) is the list of clients of route r
  ! pathind(1:nclients(r),r) index of the client's point that is visited; -1 if the point isn't a client point
  ! pathcoo(1:2,1:nclients(r),r) Cartesian coordinate of the point associated with each client of the route
  ! clientroute(c) indicates to which route client c belongs (it is set by the
  ! constructive heuristics only; the neighborhood moves do not update it)
  ! length(r) saves the length of route r
  ! aggdem(r) saves the aggregated demand of route r
  
  type solution_type
     integer :: nroutes
     integer, allocatable :: nclients(:),route(:,:),pathind(:,:),clientroute(:)
     real(kind=8), allocatable :: length(:),aggdem(:),pathcoo(:,:,:)
  end type solution_type

  public :: solution_type,CreateSolution,DeleteSolution,CopySolution,drawsol
  
contains
  
  ! *****************************************************************
  ! *****************************************************************

  subroutine CreateSolution(inst,sol)

    implicit none
    
    ! SCALAR ARGUMENTS
    type(instance_type), intent(in) :: inst
    type(solution_type), intent(out) :: sol

    ! LOCAL SCALARS
    integer :: allocerr
    
    allocate(sol%nclients(inst%nclients), &
         sol%route(inst%nclients,inst%nclients), &
         sol%pathind(inst%nclients,inst%nclients), &
         sol%pathcoo(2,inst%nclients,inst%nclients), &
         sol%clientroute(inst%nclients), &
         sol%length(inst%nclients), &
         sol%aggdem(inst%nclients), &
         stat=allocerr)

    if ( allocerr .ne. 0 ) then
       write(*,*) 'Allocation error.'
       stop
    end if

  end subroutine CreateSolution
    
  ! *****************************************************************
  ! *****************************************************************
  
  subroutine DeleteSolution(sol)
    
    implicit none
    
    ! SCALAR ARGUMENTS
    type(solution_type), intent(inout) :: sol
    
    ! LOCAL SCALARS
    integer :: allocerr
    
    deallocate(sol%nclients,sol%route,sol%pathind,sol%pathcoo,sol%clientroute,sol%length,sol%aggdem,stat=allocerr)
    
    if ( allocerr .ne. 0 ) then
       write(*,*) 'Deallocation error.'
       stop
    end if
    
  end subroutine DeleteSolution
  
  ! *****************************************************************
  ! *****************************************************************

  subroutine CopySolution(inst,sol,copy)

    implicit none
    
    ! SCALAR ARGUMENTS
    type(instance_type), intent(in) :: inst
    type(solution_type), intent(in) :: sol
    type(solution_type), intent(out) :: copy
    
    ! LOCAL SCALARS
    integer :: allocerr,i

    allocate(copy%nclients(inst%nclients), &
         copy%route(inst%nclients,inst%nclients), &
         copy%pathind(inst%nclients,inst%nclients), &
         copy%pathcoo(2,inst%nclients,inst%nclients), &
         copy%clientroute(inst%nclients), &
         copy%length(inst%nclients), &
         copy%aggdem(inst%nclients), &
         stat=allocerr)

    if ( allocerr .ne. 0 ) then
       write(*,*) 'Allocation error.'
       stop
    end if
    
    copy%nroutes = sol%nroutes
    
    do i = 1,copy%nroutes
       copy%nclients(i) = sol%nclients(i)
       copy%length(i) = sol%length(i)
       copy%aggdem(i) = sol%aggdem(i)
       copy%route(1:copy%nclients(i),i) = sol%route(1:sol%nclients(i),i)
       copy%pathind(1:copy%nclients(i),i) = sol%pathind(1:sol%nclients(i),i)
       copy%pathcoo(1:2,1:copy%nclients(i),i) = sol%pathcoo(1:2,1:sol%nclients(i),i)
    end do

    copy%clientroute(1:inst%nclients) = sol%clientroute(1:inst%nclients)
    
  end subroutine CopySolution
    
  ! **************************************************************
  ! **************************************************************
  
  subroutine drawsol(inst,sol,filename)

    ! This routine writes a MetaPost file with a figure of solution sol.
    !
    ! Each route has a color. The polygons of the clients of a route are
    ! filled with a light tone of the color of the route, and their
    ! contours and their visit points are drawn with a dark tone of it.
    ! The depot is drawn in black. The routes are sorted by the angle,
    ! around the depot, of the barycenter of their visit points, and the
    ! colors are assigned cyclically in that order, so that routes with
    ! the same color are not neighbors.
    !
    ! The figure is centered and scaled to fit in a square of side 12cm.
    ! Each polygon and each route is written in a single line of the
    ! file. The sizes and the colors are defined at the beginning of the
    ! file, so they can be changed there. The figure is obtained with:
    ! mpost file.mp
    !
    ! The figure is the same that routine drawSolution (file
    ! cvrpninstance.hpp) draws for the solutions of the CPLEX model.

    implicit none

    ! SCALAR ARGUMENTS
    type(instance_type), intent(in) :: inst
    type(solution_type), intent(in) :: sol

    ! ARRAY ARGUMENTS
    character(len=256), intent(in) :: filename

    ! PARAMETERS
    ! Colors of the routes (red, green and blue components, from 0 to 255)
    integer, parameter :: ncolors = 8
    real(kind=8), parameter :: palette(3,ncolors) = reshape( (/ &
          42.0d0, 120.0d0, 214.0d0,   235.0d0, 104.0d0,  52.0d0,    27.0d0, 175.0d0, 122.0d0,   237.0d0, 161.0d0,   0.0d0, &
         232.0d0, 123.0d0, 164.0d0,     0.0d0, 131.0d0,   0.0d0,    74.0d0,  58.0d0, 167.0d0,   227.0d0,  73.0d0,  72.0d0 /), &
         (/ 3, ncolors /) )

    ! Tones of the color of a route: fraction of the color mixed with white (filling of the polygons)
    ! and with black (contours of the polygons and visit points)
    real(kind=8), parameter :: lighttone = 0.30d0,darktone = 0.65d0

    ! LOCAL SCALARS
    integer :: j,k,nr,pos,r,tmp
    real(kind=8) :: cx,cy,half,xmax,xmin,ymax,ymin

    ! LOCAL ARRAYS
    integer :: color(sol%nroutes),order(sol%nroutes),routeof(inst%nclients)
    real(kind=8) :: angle(sol%nroutes),bar(2)

    ! order(1),...,order(nr) are the (non-empty) routes sorted by the angle
    ! of the barycenter of their visit points around the depot
    nr = 0
    do r = 1,sol%nroutes
       if ( sol%nclients(r) .gt. 0 ) then
          bar(1:2) = sum( sol%pathcoo(1:2,1:sol%nclients(r),r), dim=2 ) / sol%nclients(r)
          angle(r) = atan2( bar(2) - inst%p(2,1,0), bar(1) - inst%p(1,1,0) )

          nr = nr + 1
          order(nr) = r
       end if
    end do

    do pos = 2,nr
       tmp = order(pos)
       j = pos - 1
       do while ( j .ge. 1 )
          if ( angle(order(j)) .le. angle(tmp) ) exit
          order(j+1) = order(j)
          j = j - 1
       end do
       order(j+1) = tmp
    end do

    ! color(r) is the color of route r. If the last route in the order would have the same color
    ! of the first one, which is its neighbor, it takes another color.
    do pos = 1,nr
       color(order(pos)) = mod( pos - 1, ncolors ) + 1
    end do
    if ( nr .gt. ncolors .and. mod( nr, ncolors ) .eq. 1 ) then
       color(order(nr)) = ncolors / 2 + 1
    end if

    ! routeof(k) is the route of client k
    routeof(1:inst%nclients) = 0
    do r = 1,sol%nroutes
       do j = 1,sol%nclients(r)
          routeof(sol%route(j,r)) = r
       end do
    end do

    ! Center and half of the side of the smallest square that contains the depot and all the polygons
    xmin = inst%p(1,1,0)
    xmax = inst%p(1,1,0)
    ymin = inst%p(2,1,0)
    ymax = inst%p(2,1,0)
    do k = 1,inst%nclients
       xmin = min( xmin, minval( inst%p(1,1:inst%np(k),k) ) )
       xmax = max( xmax, maxval( inst%p(1,1:inst%np(k),k) ) )
       ymin = min( ymin, minval( inst%p(2,1:inst%np(k),k) ) )
       ymax = max( ymax, maxval( inst%p(2,1:inst%np(k),k) ) )
    end do

    cx = 0.5d0 * ( xmin + xmax )
    cy = 0.5d0 * ( ymin + ymax )
    half = 0.5d0 * max( xmax - xmin, ymax - ymin )
    if ( .not. ( half .gt. 0.0d0 ) ) half = 1.0d0

    open(unit=10,file=trim(filename))

    write(10,'(A)') 'prologues := 3;'
    write(10,'(A)') 'outputtemplate := "%j.mps";'

    ! The sizes and the colors are defined at the beginning of the file, so they can be changed there
    write(10,'(A)') '% Sizes: edges of the polygons, routes, visit points and depot'
    write(10,'(A)') 'edgewidth := 0.3pt;'
    write(10,'(A)') 'routewidth := 0.5pt;'
    write(10,'(A)') 'visitpointsize := 1.5pt;'
    write(10,'(A)') 'depotsize := 2.5pt;'

    write(10,'(A)') '% Colors of the routes and of the depot'
    write(10,'(A)') 'color routecolor[], depotcolor;'
    do k = 1,ncolors
       write(10,'(A,3(F6.4,A))') 'routecolor' // trim(num(k)) // ' := (',palette(1,k) / 255.0d0,',',palette(2,k) / 255.0d0,',', &
            palette(3,k) / 255.0d0,');'
    end do
    write(10,'(A)') 'depotcolor := black;'

    write(10,'(A)') '% Tones: fraction of the color of a route in the filling of the polygons (mixed ' // &
         'with white) and in their edges and visit points (mixed with black)'
    write(10,'(A,F4.2,A)') 'lighttone := ',lighttone,';'
    write(10,'(A,F4.2,A)') 'darktone := ',darktone,';'

    ! The colors of the filling of the polygons, of their edges and of the visit points are tones of the color of the route,
    ! but each of them can be replaced by any other color in the file
    write(10,'(A)') '% Colors of the filling of the polygons, of their edges and of the visit points, for each route'
    write(10,'(A)') 'color polygonfill[], polygonedge[], visitpoint[];'
    write(10,'(A)') 'for k = 1 upto ' // trim(num(ncolors)) // ':'
    write(10,'(A)') '  polygonfill[k] := lighttone[white,routecolor[k]];'
    write(10,'(A)') '  polygonedge[k] := darktone*routecolor[k];'
    write(10,'(A)') '  visitpoint[k] := darktone*routecolor[k];'
    write(10,'(A)') 'endfor'

    write(10,'(A)') 'beginfig(1);'
    write(10,'(A)') 'u = 6.0cm;'

    ! Polygons filled with a light tone of the color of their route
    do k = 1,inst%nclients
       if ( routeof(k) .gt. 0 ) then
          write(10,'(A)',advance='no') 'fill '
          call writepolygon(k)
          write(10,'(A)') ' withcolor polygonfill' // trim(num(color(routeof(k)))) // ';'
       end if
    end do

    ! Edges of the polygons, with a dark tone of the color of their route
    do k = 1,inst%nclients
       write(10,'(A)',advance='no') 'draw '
       call writepolygon(k)
       if ( routeof(k) .gt. 0 ) then
          write(10,'(A)') ' withpen pencircle scaled edgewidth withcolor polygonedge' // trim(num(color(routeof(k)))) // ';'
       else
          write(10,'(A)') ' withpen pencircle scaled edgewidth withcolor black;'
       end if
    end do

    ! Routes
    do r = 1,sol%nroutes
       if ( sol%nclients(r) .gt. 0 ) then
          write(10,'(A)',advance='no') 'draw ' // trim(pt(inst%p(1:2,1,0))) // '--'
          do j = 1,sol%nclients(r)
             write(10,'(A)',advance='no') trim(pt(sol%pathcoo(1:2,j,r))) // '--'
          end do
          write(10,'(A)') trim(pt(inst%p(1:2,1,0))) // ' withpen pencircle scaled routewidth withcolor ' // &
               'routecolor' // trim(num(color(r))) // ';'
       end if
    end do

    ! Visit points, with a dark tone of the color of their route
    do r = 1,sol%nroutes
       do j = 1,sol%nclients(r)
          write(10,'(A)') 'drawdot ' // trim(pt(sol%pathcoo(1:2,j,r))) // ' withpen pencircle scaled visitpointsize withcolor ' // &
               'visitpoint' // trim(num(color(r))) // ';'
       end do
    end do

    ! Depot
    write(10,'(A)') 'drawdot ' // trim(pt(inst%p(1:2,1,0))) // ' withpen pencircle scaled depotsize withcolor depotcolor;'

    ! White margin around the figure
    write(10,'(A)') 'mrg := 0.1cm;'
    write(10,'(A)') 'setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--' // &
         '(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--' // &
         '(ulcorner currentpicture + (-mrg,mrg))--cycle;'

    write(10,'(A)') 'endfig;'
    write(10,'(A)') 'end;'

    close(10)

  contains

    ! *****************************************************************
    ! *****************************************************************

    function pt(p)

      ! Point p in the units of the figure

      implicit none

      ! ARRAY ARGUMENTS
      real(kind=8), intent(in) :: p(2)

      ! FUNCTION RESULT
      character(len=40) :: pt

      ! LOCAL ARRAYS
      character(len=16) :: sx,sy

      write(sx,'(F16.6)') ( p(1) - cx ) / half
      write(sy,'(F16.6)') ( p(2) - cy ) / half

      pt = '(' // trim(adjustl(sx)) // 'u,' // trim(adjustl(sy)) // 'u)'

    end function pt

    ! *****************************************************************
    ! *****************************************************************

    function num(c)

      ! Number c written without blanks

      implicit none

      ! SCALAR ARGUMENTS
      integer, intent(in) :: c

      ! FUNCTION RESULT
      character(len=4) :: num

      write(num,'(I0)') c

    end function num

    ! *****************************************************************
    ! *****************************************************************

    subroutine writepolygon(k)

      ! Writes the closed path with the vertices of the polygon of client k

      implicit none

      ! SCALAR ARGUMENTS
      integer, intent(in) :: k

      ! LOCAL SCALARS
      integer :: j

      do j = 1,inst%np(k)
         write(10,'(A)',advance='no') trim(pt(inst%p(1:2,j,k))) // '--'
      end do
      write(10,'(A)',advance='no') 'cycle'

    end subroutine writepolygon

  end subroutine drawsol
  
end module solution
