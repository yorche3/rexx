::class Numbers public

/* Direct recursion (_rec) */

::method sum_of_first_n_rec class
  use arg n
  if n = 0 then
    return 0
  return n + self~sum_of_first_n_rec(n - 1)

::method factorial_rec class
  use arg n
  if n = 0 then
    return 1
  return n * self~factorial_rec(n - 1)

::method fibonacci_rec class
  use arg n
  if n <= 1 then
    return n
  return self~fibonacci_rec(n - 1) + self~fibonacci_rec(n - 2)

::method greatest_common_divisor_rec class
  use arg a, b
  if b = 0 then
    return a
  return self~greatest_common_divisor_rec(b, a // b)

::method least_common_multiple_rec class
  use arg a, b
  return (a * b) / self~greatest_common_divisor_rec(a, b)

/* Accumulator recursion (_acc): educational bridge, no TCO in ooRexx */

::method sum_of_first_n_acc class
  use arg n
  return self~sum_of_first_n_acc_help(n, 0)

::method sum_of_first_n_acc_help class private
  use arg n, acc
  if n <= 0 then
    return acc
  return self~sum_of_first_n_acc_help(n - 1, n + acc)

::method factorial_acc class
  use arg n
  return self~factorial_acc_help(n, 1)

::method factorial_acc_help class private
  use arg n, acc
  if n <= 1 then
    return acc
  return self~factorial_acc_help(n - 1, n * acc)

::method fibonacci_acc class
  use arg n
  return self~fibonacci_acc_help(n, 0, 1)

::method fibonacci_acc_help class private
  use arg n, acc2, acc1
  if n <= 0 then
    return acc2
  if n <= 2 then
    return acc1 + acc2
  return self~fibonacci_acc_help(n - 1, acc1, acc1 + acc2)

::method greatest_common_divisor_acc class
  use arg a, b
  return self~greatest_common_divisor_acc_help(a, b)

::method greatest_common_divisor_acc_help class private
  use arg a, b
  if b = 0 then
    return a
  return self~greatest_common_divisor_acc_help(b, a // b)

::method least_common_multiple_acc class
  use arg a, b
  return (a * b) / self~greatest_common_divisor_acc(a, b)

/* Iterative (_ite) */

::method sum_of_first_n_ite class
  use arg n
  result = 0
  do i = 1 to n
    result = result + i
  end
  return result

::method factorial_ite class
  use arg n
  result = 1
  do i = 2 to n
    result = result * i
  end
  return result

::method fibonacci_ite class
  use arg n
  if n <= 1 then
    return n
  acc2 = 0
  acc1 = 1
  do i = 2 to n
    temp = acc1 + acc2
    acc2 = acc1
    acc1 = temp
  end
  return acc1

::method greatest_common_divisor_ite class
  use arg a, b
  do while b <> 0
    temp = b
    b = a // b
    a = temp
  end
  return a

::method least_common_multiple_ite class
  use arg a, b
  return (a * b) / self~greatest_common_divisor_ite(a, b)
