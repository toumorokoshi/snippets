# access files with and without code blocks

# with codeblocks 
File.open("test.txt", "w") { |f| f.write("hello") }
# without codeblocks
f = File.new("test.txt", "w")
f.write("hello without codeblocks!")
f.close

# How would you translate a hash to an array? Can you translate array to a hash?


# hash to array
h = {:test => "hash", :a => "b"}
h.to_a

# array to hash
a = h.to_a
puts a.inject(Hash.new) { |hash, i| hash[i[0]] = i[1]; hash }

# can you iterate through a hash?
# yes, creates an array of key-value pairs
h.each { |k| puts k }

# arrays also support queues on top of stacks

a = [1, 2, 3]

a.insert(0, 1)
a.pop

# Print the contents of sixteen numbers, four numbers at a time, using each

i = 0
vals = []
(0..16).each do |v|
  vals << v
  i += 1
  if i % 4 == 0
      p vals
      vals = []
  end
end

# with each_slice

(0..15).each_slice(4) { |k| p k }
