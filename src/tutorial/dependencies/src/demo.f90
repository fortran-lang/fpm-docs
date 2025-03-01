module demo
  use stdlib_io, only : get_line
  use stdlib_strings, only : replace_all
  implicit none
  private

  public :: substitute

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
      call get_line(input, line, stat)
      if (stat /= 0) exit
      write(output, '(a)') replace_all(line, pattern, replacement)
    end do
  end subroutine substitute

end module demo
