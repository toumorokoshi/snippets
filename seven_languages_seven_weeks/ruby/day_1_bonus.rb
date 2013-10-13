max = 10

random_number = rand(max)
guessed = false

while not guessed
  puts "Guess a random number between 0 and #{max - 1}, inclusive"
  guess = gets()
  guessed = (guess.to_i == random_number)
  puts "Wrong!" unless guessed
end

puts "Good job!"
