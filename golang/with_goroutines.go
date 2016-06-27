package main

import "fmt"
import "runtime/debug"

func fib(n int, c chan int) {
	if n == 0 {
		c <- 0
	} else if n == 1 {
		c <- 1
	} else {
		fib_result := make(chan int)
		go fib(n - 1, fib_result)
		go fib(n - 2, fib_result)
		l, r := <- fib_result, <- fib_result
		c <- l + r
	}
}

func main() {
	debug.SetMaxThreads(4)
	c := make(chan int)
	go fib(30, c)
	result := <- c
	fmt.Println(result)
}
