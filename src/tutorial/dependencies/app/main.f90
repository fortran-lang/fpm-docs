program main
  use, intrinsic :: iso_fortran_env, only : output_unit
  use demo, only : substitute
  use m_cli2, only : set_args, unnamed, sget
  implicit none
  character(len=:), allocatable :: input_file, output_file, pattern, replacement
  integer :: input, output, i

  call set_args("--output:o ''")

  output_file = trim(sget("output"))
  if (len(output_file) > 0) then
    open(file=output_file, newunit=output)
  else
    output = output_unit
  end if

  pattern = trim(unnamed(1))
  replacement = trim(unnamed(2))

  do i = 3, size(unnamed)
    input_file = trim(unnamed(i))
    open(file=input_file, newunit=input, status='old')
    call substitute(input, output_unit, trim(pattern), trim(replacement))
    close(input)
  end do

  if (output /= output_unit) close(output)
end program main
