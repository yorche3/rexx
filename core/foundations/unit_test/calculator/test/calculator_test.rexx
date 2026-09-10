aResult = .TestSuite~new(.CalculatorTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/calculator.rexx"

::class CalculatorTest subclass TestCase

::method testAddition
  self~assertEquals(5, .Calculator~addition(2, 3), "addition")

::method testSubtraction
  self~assertEquals(3, .Calculator~subtraction(5, 2), "subtraction")

::method testMultiplication
  self~assertEquals(12, .Calculator~multiplication(3, 4), "multiplication")

::method testDivision
  self~assertEquals(3, .Calculator~division(10, 3), "division")

::method testModulus
  self~assertEquals(1, .Calculator~modulus(10, 3), "modulus")
