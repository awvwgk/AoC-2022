{ gsub(/[-,]/, " ") }
($1 >= $3 && $4 >= $2) || ($3 >= $1 && $2 >= $4) { count1++ }
END { print "Part 1:", count1 }
function in_range(idx, start, end) { return start <= idx && idx <= end }
in_range($3, $1, $2) || in_range($4, $1, $2) || in_range($1, $3, $4) || in_range($2, $3, $4) { count2++ }
END { print "Part 2:", count2 }
