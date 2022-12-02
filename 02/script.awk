BEGIN {
   code1["X"] = 1; code1["Y"] = 2; code1["Z"] = 3
   code1["A","X"] = 3; code1["A","Y"] = 6; code1["A","Z"] = 0
   code1["B","X"] = 0; code1["B","Y"] = 3; code1["B","Z"] = 6
   code1["C","X"] = 6; code1["C","Y"] = 0; code1["C","Z"] = 3

   code2["X"] = 0; code2["Y"] = 3; code2["Z"] = 6
   code2["A","X"] = 3; code2["A","Y"] = 1; code2["A","Z"] = 2
   code2["B","X"] = 1; code2["B","Y"] = 2; code2["B","Z"] = 3
   code2["C","X"] = 2; code2["C","Y"] = 3; code2["C","Z"] = 1
}
{
   score1 += code1[$2] + code1[$1,$2]
   score2 += code2[$2] + code2[$1,$2]
}
END {
  print "Part 1:", score1
  print "Part 2:", score2
}
