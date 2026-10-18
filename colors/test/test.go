package main

import (
	"errors"
	"fmt"
)

const Max = 10

type Shape interface {
	Area() float64
}

type Circle struct {
	Radius float64
	name   string
}

func (c Circle) Area() float64 {
	return 3.14159 * c.Radius * c.Radius
}

func divide(a, b int) (int, error) {
	if b == 0 {
		return 0, errors.New("divide by zero")
	}
	return a / b, nil
}

func main() {
	var s Shape = Circle{Radius: 2, name: "c1"}
	nums := []int{1, 2, 3}
	ch := make(chan int, 1)

	go func() {
		ch <- len(nums)
	}()

	for i, n := range nums {
		fmt.Printf("%d: %d\n", i, n)
	}

	switch v := <-ch; {
	case v > 2:
		fmt.Println("big", s.Area())
	default:
		fmt.Println("small")
	}

	// handle error
	if _, err := divide(1, 0); err != nil {
		fmt.Println(err)
	}
}
