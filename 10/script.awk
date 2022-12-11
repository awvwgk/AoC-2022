BEGIN { cycle = 0; register = 1; signal = 0 }
{ cycle++ }
{
   diff = register - cycle % 40
   output = output (diff >= -1 && diff <= 1 ? "#" : ".")
   if (cycle%40 == 0) output = output "\n"
}
(cycle + 20) % 40 == 0 { signal += cycle * register}
NF == 2 { 
   cycle++
   if ((cycle + 20) % 40 == 0) { signal += cycle * register}
   register += $2

   diff = register - cycle % 40
   output = output (diff >= -1 && diff <= 1 ? "#" : ".")
   if (cycle%40 == 0) output = output "\n"
}
END { print "Part 1:", signal }
END { printf "Part 2:\n%s", output }
