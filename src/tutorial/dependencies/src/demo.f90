module demo
  use stdlib_strings, only : replace_all
  implicit none
  private

  public :: substitute
  public :: getline

contains

  !> Read all lines from input, replace pattern and print it to output
  subroutine substitute(input, output, pattern, replacement)
    !> Formatted input unit
    integer, intent(in) :: input
    !> Formatted output unit
    integer, intent(in) :: output
    !> Pattern to replace in input
    character(len=*), intent(in) :: pattern
    !> Replacement for pattern in output
    character(len=*), intent(in) :: replacement

    character(len=:), allocatable :: line
    integer :: stat

    do
      call getline(input, line, stat)
      if (stat /= 0) exit
      write(output, '(a)') replace_all(line, pattern, replacement)
    end do
  end subroutine substitute

  !> Read a whole line from a formatted unit into a deferred length character variable
  subroutine getline(unit, line, iostat, iomsg)
    !> Formatted IO unit
    integer, intent(in) :: unit
    !> Line to read
    character(len=:), allocatable, intent(out) :: line
    !> Status of operation
    integer, intent(out) :: iostat
    !> Error message
    character(len=:), allocatable, optional :: iomsg

    integer, parameter :: bufsize = 512
    character(len=bufsize) :: buffer, msg
    integer :: chunk, stat

    allocate(character(len=0) :: line)
    do
      read(unit, '(a)', advance='no', iostat=stat, iomsg=msg, size=chunk) buffer
      if (stat > 0) exit
      line = line // buffer(:chunk)
      if (stat < 0) then
        if (is_iostat_eor(stat)) stat = 0
        exit
      end if
    end do

    if (stat /= 0 .and. present(iomsg)) iomsg = trim(msg)
    iostat = stat
  end subroutine getline

end module demo
