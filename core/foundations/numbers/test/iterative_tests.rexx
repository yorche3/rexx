aResult = .TestSuite~new(.IterativeTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/numbers.rexx"

::class IterativeTest subclass TestCase

::method testSumOfFirstNIte
  self~assertEquals(0, .Numbers~sum_of_first_n_ite(0), "sum_of_first_n_ite 1")
  self~assertEquals(6, .Numbers~sum_of_first_n_ite(3), "sum_of_first_n_ite 2")

::method testFactorialIte
  self~assertEquals(1, .Numbers~factorial_ite(0), "factorial_ite 1")
  self~assertEquals(24, .Numbers~factorial_ite(4), "factorial_ite 2")

::method testFibonacciIte
  self~assertEquals(0, .Numbers~fibonacci_ite(0), "fibonacci_ite 1")
  self~assertEquals(1, .Numbers~fibonacci_ite(1), "fibonacci_ite 2")
  self~assertEquals(8, .Numbers~fibonacci_ite(6), "fibonacci_ite 3")

::method testGreatestCommonDivisorIte
  self~assertEquals(4, .Numbers~greatest_common_divisor_ite(12, 8), "greatest_common_divisor_ite 1")
  self~assertEquals(1, .Numbers~greatest_common_divisor_ite(7, 5), "greatest_common_divisor_ite 2")

::method testLeastCommonMultipleIte
  self~assertEquals(12, .Numbers~least_common_multiple_ite(4, 6), "least_common_multiple_ite 1")
  self~assertEquals(24, .Numbers~least_common_multiple_ite(6, 8), "least_common_multiple_ite 2")
