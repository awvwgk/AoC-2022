#!/usr/bin/env ruby

input = ARGF.readlines.map{|x|x.chomp}
idx = input.index("") - 1
nstack = input[idx].split.size
stacks1 = Array.new(nstack){[]}

(0 ... idx).reverse_each do |row|
  (0 ... nstack).each do |column|
    item = input[row][1+4*column]
    stacks1[column] << item unless item == " "
  end
end

stacks2 = stacks1.map{|x|x.clone}

input.drop(idx + 2).each do |instruction|
  repeat, source, target = instruction.split.map{|x|x.to_i - 1}.select{|x|x>=0}
  stacks1[target] += stacks1[source].pop(repeat + 1).reverse
  stacks2[target] += stacks2[source].pop(repeat + 1)
end

puts "Part 1: #{stacks1.map{|x|x.last}.join}"
puts "Part 2: #{stacks2.map{|x|x.last}.join}"
