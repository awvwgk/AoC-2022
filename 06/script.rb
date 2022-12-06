#!/usr/bin/env ruby

input = ARGF.read.chomp.chars

pkg, msg = nil
(3 ... input.size).each do |idx|
  if input[(idx - 3) .. idx].uniq.size == 4
    pkg = idx + 1
    break
  end
end
puts pkg

(13 ... input.size).each do |idx|
  if input[(idx - 13) .. idx].uniq.size == 14
    msg = idx + 1
    break
  end
end
puts msg
