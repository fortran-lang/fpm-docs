module test_demo
  use demo, only : substitute
  use stdlib_io, only : getline
  use testdrive, only : error_type, unittest_type, new_unittest, check
  implicit none
  private

  public :: collect_demo

contains

  !> Collect all exported unit tests
  subroutine collect_demo(testsuite)
    !> Collection of tests
    type(unittest_type), allocatable, intent(out) :: testsuite(:)

    testsuite = [new_unittest("substitute", test_substitute)]
  end subroutine collect_demo

  !> Check substitution of a single line
  subroutine test_substitute(error)
    !> Error handling
    type(error_type), allocatable, intent(out) :: error
    integer :: input, output, stat
    character(len=:), allocatable :: line
    open(newunit=input, status="scratch")
    write(input, '(a)') "This is a valid test"
    rewind(input)

    open(newunit=output, status="scratch")
    call substitute(input, output, "test", "example")
    close(input)

    rewind(output)
    call getline(output, line, stat)
    close(output)

    call check(error, line, "This is a valid example")
  end subroutine test_substitute
end module test_demo

program tester
  use, intrinsic :: iso_fortran_env, only : error_unit
  use testdrive, only : run_testsuite
  use test_demo, only : collect_demo
  implicit none
  integer :: stat

  stat = 0
  call run_testsuite(collect_demo, error_unit, stat)

  if (stat > 0) then
    write(error_unit, '(i0, 1x, a)') stat, "test(s) failed!"
    error stop
  end if

end program tester
