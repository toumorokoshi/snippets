// loop fibonacci
lfib := method(iterations, 
    return_value := 1
    previous_value := 1
    while(iterations > 1, 
        temp := return_value
        return_value = return_value + previous_value
        previous_value = temp
        iterations = iterations - 1
    )
    return_value
)

lfib(0) println
lfib(4) println
lfib(5) println
lfib(6) println

// recursive fibonacci
rfib := method(i,
     if(i < 2, 1, rfib(i - 1) + rfib(i - 2))
)

rfib(4) println
rfib(5) println
rfib(6) println

// to change "/", one would have to override the "/" operator
old_div := Number getSlot("/")
Number / := method (i, if(i != 0, old_div(i), 0))
(5 / 0) println

// sum all numbers in a two dimensional array
sum_2d_list := method(l,
            i := 0
            l foreach(index, value, value foreach(index2, value2, i = i + value2))
)

sum_2d_list(list(list(0, 1, 2), list(3, 4, 5))) println


// add a slot to alist that computers the average of all the numbers in a list
List myAverage := method(
     i := 0
     foreach(index, value,
             if(value type != 0 type, 
             Exception raise("value is not a number!"))
         i = i + value
     )
     i / size
)

(list(0, 1, 2) myAverage) println
// this raises an exception
// (list(0, 1, "no") myAverage) println
