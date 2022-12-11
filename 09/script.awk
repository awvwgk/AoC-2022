BEGIN {
   for(i = 0; i <= 9; i++) {
      x[i] = 0
      y[i] = 0
   }
   visited1[x[1],y[1]]++
   visited2[x[9],y[9]]++
}
function sign(val) { return val == 0 ? 0 : val > 0 ? 1 : -1 }
function abs(val) { return val > 0 ? val : -val }
function step(incx, incy, repeat) {
}
function incx(val) {
   switch (val) {
      case "R": return +1
      case "L": return -1
   }
   return 0
}
function incy(val) {
   switch (val) {
      case "U": return +1
      case "D": return -1
   }
   return 0
}
{
   for(i = 1; i <= $2; i++) {
      x[0] += incx($1)
      y[0] += incy($1)
      for(j = 1; j <= 9; j++) {
         dx = x[j-1] - x[j]
         dy = y[j-1] - y[j]
         if (abs(dx) > 1 || abs(dy) > 1) {
            x[j] += sign(dx)
            y[j] += sign(dy)
         }
      }
      visited1[x[1],y[1]]++
      visited2[x[9],y[9]]++
   }
}
END {
   print "Part 1:", length(visited1)
   print "Part 2:", length(visited2)
}
