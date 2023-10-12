program compute_pi_openmp
  use, intrinsic :: iso_fortran_env, only: dp => real64, i8 => int64, real128
  implicit none
  integer(kind=i8) :: i, n_iterations
  real(kind=dp) :: delta, x, pi
  real(kind=dp) :: start, end

  pi = 0.0_dp
  n_iterations = get_iterations(10000_i8)
  delta = 1.0_dp / n_iterations
  x = 0.0_dp

  call cpu_time(start)
  !$omp parallel do default(none) private(x) shared(delta, n_iterations) reduction(+:pi)
  do i = 1, n_iterations
    x = i * delta
    pi = pi + sqrt(1.0_dp - x**2)
  end do
  !$omp end parallel do
  call cpu_time(end)

  pi = 4.0_dp * pi / n_iterations
  print "(A, I16, A, F25.15)", "Iterations: ", n_iterations, ", PI: ", pi
  print "(A, F8.3, A, ES8.1)", "Took: ", end - start, "s, with absolute error: ", acos(-1.0_real128) - pi

contains

  integer(i8) function get_iterations(default_iterations)
    integer(kind=i8), intent(in) :: default_iterations
    character(len=100) :: buffer, msg
    integer :: stat

    get_iterations = default_iterations
    if (command_argument_count() >= 1) then
      call get_command_argument(1, buffer)
      read (buffer, fmt=*, iostat=stat, iomsg=msg) get_iterations
      if (stat /= 0) stop msg
    end if
  end function get_iterations

end program compute_pi_openmp
