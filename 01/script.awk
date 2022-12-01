BEGIN { elf = 1 }
NF == 0 { elf++ }
NF == 1 { supply[elf] += $1 }
END {
   asort(supply)
   print "Part 1:", supply[elf]
   print "Part 2:", supply[elf--] + supply[elf--] + supply[elf--]
}
