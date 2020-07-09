-module(chapter_2).

-export([bodyRecFib/1, curryTest/0, fib/1, findMin/1,
	 isSorted/1, reverse/1, uncurryTest/2, sumArray/1]).

% Fibonacci sequence

bodyRecFib(N) when N =< 0 -> 0;
bodyRecFib(N) when N == 1 -> 1;
bodyRecFib(N) -> bodyRecFib(N - 1) + bodyRecFib(N - 2).

fib(N) when N =< 0 -> 0;
fib(N) when N == 1 -> 1;
fib(N) -> fib(N, 1, 0, 1).

fib(Goal, Current, _, N) when Goal == Current -> N;
fib(Goal, Current, M, N) ->
    fib(Goal, Current + 1, N, M + N).

% Array operations

sumArray(Array) -> sumArray(Array, 0).

sumArray([], Sum) -> Sum;
sumArray([Head | Tail], Sum) ->
    sumArray(Tail, Head + Sum).

findMin([]) -> 0;
findMin([Head | Tail]) -> findMin(Tail, Head).

findMin([], Min) -> Min;
findMin([Head | Tail], Min) when Head < Min ->
    findMin(Tail, Head);
findMin([_ | Tail], Min) -> findMin(Tail, Min).

reverse(Array) -> reverse(Array, []).

reverse([], Reverse) -> Reverse;
reverse([Head | Tail], Reverse) ->
    reverse(Tail, [Head | Reverse]).

defaultSort(A, B) -> A =< B.

reverseSort(A, B) -> A >= B.

isSorted([Head | Tail]) ->
    isSorted(Head, Tail, fun reverseSort/2).

isSorted(_, [], _) -> true;
isSorted(Previous, [Head | Tail], F) ->
    Complies = F(Previous, Head),
    if Complies -> isSorted(Head, Tail, F);
       true -> false
    end.

% Currying

curry(F) -> fun (A) -> fun (B) -> F(A, B) end end.

isDivisible(A, B) -> A rem B == 0.

% curryTest() -> ((curry(fun isDivisible/2))(12))(3).
curryTest() ->
    F = curry(fun isDivisible/2),
    G = F(12),
    G(3).

uncurryTest(A, B) ->
    F = curry(fun isDivisible/2),
    G = uncurry(F),
    G(A, B).

uncurry(F) ->
    fun (A, B) ->
      (F(A))(B)
    end.
