::class Calculator public

::method addition class
  use arg a, b
  return a + b

::method subtraction class
  use arg a, b
  return a - b

::method multiplication class
  use arg a, b
  result = 0
  do i = 1 to b
    result = self~addition(result, a)
  end
  return result

::method division class
  use arg a, b
  quotient = 0
  do while a >= b
    a = self~subtraction(a, b)
    quotient = self~addition(quotient, 1)
  end
  return quotient

::method modulus class
  use arg a, b
  q = self~division(a, b)
  p = self~multiplication(q, b)
  return self~subtraction(a, p)
