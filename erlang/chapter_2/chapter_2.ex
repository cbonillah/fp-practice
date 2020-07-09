defmodule Chapter2 do

    # Fibonacci sequence

    # Body recursive form
    def bodyRecFib(0), do: 0
    def bodyRecFib(1), do: 1
    def bodyRecFib(n), do: bodyRecFib(n - 1) + bodyRecFib(n - 2)

    # Tail recursive form
    def fib(n) do
        fib(n, 0, 1)
    end
    def fib(n, prev, _cur) when n <= 0 do
        prev
    end
    def fib(n, prev, cur) do
        fib(n - 1, cur, prev + cur)
    end

    # Factorial
    def fac(n), do: fac(n, 1)
    def fac(n, acc) when n <= 0, do: acc
    def fac(n, acc), do: fac(n - 1, n * acc)

    # Tell if an array is sorted
    def isSorted([head | tail], f), do: isSorted(head, tail, f)

    def isSorted(_current, [], _array), do: true
    def isSorted(current, [head | tail], f) do
        if f.(current, head) do
            isSorted(head, tail, f)
        else
            false
        end
    end

    # Currying
    
    def curry(f) do
        fn(a) ->
            fn(b) -> f.(a, b) end
        end
    end

    # Uncurrying

    def uncurry(f) do
        fn(a,b) -> f.(a).(b) end
    end

    # Composing

    def compose(f ,g) do
        fn(a) ->
            f.(g.(a))
        end
    end

end
