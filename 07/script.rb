input = ARGF.readlines.map{|x|x.chomp}

dirs, path = [0], [0]
while input.size > 0
  size, instruction, location = input.shift.split
  if instruction == "cd"
    case location
    when ".."
      path.pop
    when "/"
      path = [0]
    else
      dirs.append(0)
      path.append(dirs.size - 1)
    end
  elsif size.to_i > 0
    size = size.to_i
    path.each {|at| dirs[at] += size}
  end
end

total, required = 70000000, 30000000
free = required - (total - dirs.first)

puts "Part 1: #{dirs.select{|x|x <= 100000}.sum}"
puts "Part 2: #{dirs.select{|x|x >= free}.min}"
