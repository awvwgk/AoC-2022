use, intrinsic :: iso_fortran_env, only : input_unit
implicit none
integer :: width
integer, allocatable :: field(:, :)
block
   integer :: io, stat, line
   character(len=:), allocatable :: arg, input
   call get_argument(1, arg)
   if (.not.allocated(arg)) error stop "Provide input file as argument"

   call read_whole_file(arg, input, stat)
   if (stat /= 0) error stop "Cannot read from file '"//arg//"'"

   width = index(input, new_line('a')) - 1
   allocate(field(width, width))

   do line = 1, width
      read(input((line - 1) * (width + 1) + 1 : line * (width + 1) - 1), '(*(i1))') &
         & field(:, line)
   end do
end block

block
   integer :: i, j
   logical, allocatable :: visible(:, :)

   allocate(visible(width, width), source=.true.)
   do i = 2, width - 1
      do j = 2, width - 1
         visible(j, i) = any([ &
            & all(field(j, i) > field(j, : i - 1)), &
            & all(field(j, i) > field(j, i + 1 :)), &
            & all(field(j, i) > field(: j - 1, i)), &
            & all(field(j, i) > field(j + 1 :, i))])
      end do
   end do

   print '("Part 1:", 1x, i0)', count(visible)
end block

block
   integer :: i, j
   integer, allocatable :: scores(:, :)

   allocate(scores(2:width-1, 2:width-1))
   do i = 2, width - 1
      do j = 2, width - 1
         scores(j, i) = product([&
            i - max(1, findloc(field(j, i) > field(j, : i - 1), .false., dim=1, back=.true.)), &
            merge(width - i, findloc(field(j, i) > field(j, i + 1 :), .false., dim=1), &
            &     all(field(j, i) > field(j, i + 1 :))), &
            j - max(1, findloc(field(j, i) > field(: j - 1, i), .false., dim=1, back=.true.)), &
            merge(width - j, findloc(field(j, i) > field(j + 1 :, i), .false., dim=1), &
            &     all(field(j, i) > field(j + 1 :, i)))])
      end do
   end do

   print '("Part 2:", 1x, i0)', maxval(scores)
end block

contains
   subroutine get_argument(idx, arg)
      integer, intent(in) :: idx
      character(len=:), allocatable, intent(out) :: arg
      integer :: length, stat

      call get_command_argument(idx, length=length, status=stat)
      if (stat /= 0) return

      allocate(character(len=length) :: arg, stat=stat)
      if (stat /= 0) return

      if (length > 0) then
         call get_command_argument(idx, arg, status=stat)
         if (stat /= 0) deallocate(arg)
      end if
   end subroutine get_argument

   subroutine read_whole_file(filename, string, stat)
      character(*), intent(in) :: filename
      character(:), allocatable, intent(out) :: string
      integer, intent(out) :: stat

      integer :: io, length

      open(file=filename, &
         & status="old", &
         & access="stream", & 
         & position="append", &
         & newunit=io, &
         & iostat=stat)
      if (stat == 0) then
         inquire(unit=io, pos=length)
         allocate(character(length-1) :: string, stat=stat)
      end if
      if (stat == 0) then
         read(io, pos=1, iostat=stat) string(:length-1)
      end if
      if (stat == 0) then
         close(io)
      end if
   end subroutine read_whole_file
end
