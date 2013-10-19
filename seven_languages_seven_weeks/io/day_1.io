// Io is strongly typed, since loose casting isn't enacted

1 + 1

// 1 + "one" breaks

// 0 is true
x := if(0, 1, 0)

// nil is false
x := if(nil, 1, 0)


// to find the methods of a prototype:
Car := Object clone
Car vroom := "Vroom!"
ferrari := Car clone
(ferrari proto) slotNames

// An equals (=) is a direct assignment, and doesn't allow slot creation
// Car koko = "yes"

// colon equals (:=) is assignment + creation of slot if it doesn't exist.
Car koko := "yes"

// double-colon equals (::=) creates a setter along with the slot
Car koko := "yes"
// Car setKoko("no")
Car koko ::= "yes"
Car setKoko("no")
