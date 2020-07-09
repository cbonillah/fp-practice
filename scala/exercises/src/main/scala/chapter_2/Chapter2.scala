package chapter_2

object Factorial {

  def factorial(n: Int): Int = {
    @annotation.tailrec
    def go(n: Int, acc: Int): Int =
      if (n <= 0) acc
      else go(n - 1, n * acc)
    go(n, 1)
  }

  def main(args: Array[String]): Unit = {
    var n = 5

    print("Factorial(" + n + ") = ")
    println(factorial(n))
  }

}

object Fibonacci {
  def fib(n: Int): Int = {
    @annotation.tailrec
    def loop(n: Int, prev: Int, cur: Int): Int =
      if (n == 0) prev
      else loop(n - 1, cur, prev + cur)
    loop(n, 0, 1)
  }

  def main(args: Array[String]): Unit = {
    var n = 9

    print("Fib(" + n + ") = ")
    println(fib(n))
  }
}

object Arrays {
  def isSorted[A](array: Array[A], f: (A, A) => Boolean): Boolean = {
    @annotation.tailrec
    def loop(n: Int): Boolean =
      if (n >= array.length) true
      else if (f(array(n - 1), array(n))) loop(n + 1)
      else false

    loop(1)
  }

  def lessOrEqual(a: Int, b: Int): Boolean = a <= b

  def main(args: Array[String]): Unit = {
    var n = Array(0, 1, 4, 3, 4, 5)
    var result = isSorted(n, lessOrEqual)

    if (result) {
      println("The array is sorted")
    } else {
      println("The array is not sorted")
    }
  }
}

object Currying {

  def curry[A, B, C](f: (A, B) => C): A => (B => C) =
    a => b => f(a, b)

  def uncurry[A, B, C](f: A => B => C): (A, B) => C =
    (a, b) => f(a)(b)

  def mod(a: Int, b: Int): Boolean = a % b == 0

  def main(args: Array[String]): Unit = {
    var isDivisible = curry(mod)
    var twelveIsDivisibleBy = isDivisible(12)
    println("Twelve is divisible by 3: " + twelveIsDivisibleBy(3))
    println("Twelve is divisible by 5: " + twelveIsDivisibleBy(5))

    var uncurried = uncurry(isDivisible)
    println("Uncurried test: " + uncurried(12, 3))
    println("Uncurried test: " + uncurried(12, 5))
  }

}

object Composing {
  def sumTwo(a: Int): Int = a + 2
  def multiplyByTwo(a: Int): Int = a * 2
  def compose[A, B, C](f: B => C, g: A => B): A => C =
    a => f(g(a))

  def main(args: Array[String]): Unit = {
    var n = 5
    var multiplyThenSum = compose(sumTwo, multiplyByTwo)
    var result = multiplyThenSum(n)

    println(n + " * 2 + 2 = " + result)
  }
}
