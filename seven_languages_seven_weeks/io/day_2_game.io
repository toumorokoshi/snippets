// random number guessing game
random_number := Random value(100) ceil

guessed := false
distance := 100
while(guessed not,
    "Guess a number between 1 and 100:" println
    guess := Number evalArg(File standardInput readLine) asNumber
    guessed = guess == random_number
    if(guessed not, 
      new_distance := (guess - random_number) abs
      if (new_distance < distance, 
          "getting warmer!" println,
          "getting colder..." println)
      distance = new_distance
    )
)
"Correct! Good job!" println
