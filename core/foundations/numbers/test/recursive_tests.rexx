aResult = .TestSuite~new(.RecursiveTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/numbers.rexx"

::class RecursiveTest subclass TestCase

::method testSumOfFirstNRec
  self~assertEquals(0, .Numbers~sum_of_first_n_rec(0), "sum_of_first_n_rec 1")
  self~assertEquals(6, .Numbers~sum_of_first_n_rec(3), "sum_of_first_n_rec 2")

::method testFactorialRec
  self~assertEquals(1, .Numbers~factorial_rec(0), "factorial_rec 1")
  self~assertEquals(24, .Numbers~factorial_rec(4), "factorial_rec 2")

::method testFibonacciRec
  self~assertEquals(0, .Numbers~fibonacci_rec(0), "fibonacci_rec 1")
  self~assertEquals(1, .Numbers~fibonacci_rec(1), "fibonacci_rec 2")
  self~assertEquals(8, .Numbers~fibonacci_rec(6), "fibonacci_rec 3")

::method testGreatestCommonDivisorRec
  self~assertEquals(4, .Numbers~greatest_common_divisor_rec(12, 8), "greatest_common_divisor_rec 1")
  self~assertEquals(1, .Numbers~greatest_common_divisor_rec(7, 5), "greatest_common_divisor_rec 2")

::method testLeastCommonMultipleRec
  self~assertEquals(12, .Numbers~least_common_multiple_rec(4, 6), "least_common_multiple_rec 1")
  self~assertEquals(24, .Numbers~least_common_multiple_rec(6, 8), "least_common_multiple_rec 2")
