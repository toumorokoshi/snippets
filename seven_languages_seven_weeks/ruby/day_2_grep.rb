string_regex, file_regex = ARGV

def print_matches(file_name, text, match) 
  i = 0
  text.each_line do |line|
    i += 1
    puts "#{file_name}, #{i}: #{line}" if /#{match}/.match(line)
  end
end

Dir.glob(file_regex) do |f|
  File.open(f) { |text| print_matches(f, text, string_regex) }
end

# example: rb day_2_grep.rb put **/*
