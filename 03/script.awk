BEGIN {
  priority = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  FS = ""
}
function items (str, comp) {
  split(str, comp)
  for(idx in comp) {
    comp[comp[idx]]++
    delete comp[idx]
  }
}
{
  items(substr($0, 1, NF/2), item1)
  items(substr($0, 1+NF/2, NF), item2)
  for(item in item1) {
    if (item in item2) misplaced += index(priority, item)
  }
}
{ items($0, triple[NR % 3]) }
NR % 3 == 0 {
  for(item in triple[0]) {
    if (item in triple[1] && item in triple[2]) {
      identifier += index(priority, item)
    }
  }
}
END {
  print "Part 1:", misplaced
  print "Part 2:", identifier
}
