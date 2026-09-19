/* Casos de prueba de la especificación 05_Naive_Sort.md
 *
 * Representación: las constantes de cada caso son cadenas separadas por blancos
 * ("5 2 9 1 5 6"), el idioma de secuencia de REXX (words/word/subword), y el
 * ayudante compartido construye con ellas un .Array nuevo por caso, porque el
 * orden es in-place y la entrada se modifica.
 *
 * Caso nulo incluido: `.Nil` es representable y distinguible de la lista vacía
 * (""), así que el indicador de fallo del contrato es `.Nil` y se comprueba de
 * forma independiente del caso vacío. No se espera ninguna excepción.
 */

aResult = .TestSuite~new(.NaiveSortTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/naive_sort.rexx"

::class NaiveSortTest subclass TestCase

/* Entradas de la especificación */

::method standardInput class
  return "5 2 9 1 5 6"

::method sortedInput class
  return "1 2 3 4 5"

::method reverseInput class
  return "5 4 3 2 1"

::method identicalInput class
  return "7 7 7 7"

::method negativeInput class
  return "3 -1 4 -5 0"

::method singleInput class
  return "42"

::method emptyInput class
  return ""

::method nullInput class
  return .Nil

/* Salidas esperadas de la especificación */

::method standardOutput class
  return "1 2 5 5 6 9"

::method sortedOutput class
  return "1 2 3 4 5"

::method reverseOutput class
  return "1 2 3 4 5"

::method identicalOutput class
  return "7 7 7 7"

::method negativeOutput class
  return "-5 -1 0 3 4"

::method singleOutput class
  return "42"

::method emptyOutput class
  return ""

::method nullOutput class
  return .Nil

/* Tabla de casos: descripción, entrada y salida esperada. */
::method cases class
  cases = .array~new
  cases~append(.array~of("an unsorted array", self~standardInput, self~standardOutput))
  cases~append(.array~of("an already sorted array", self~sortedInput, self~sortedOutput))
  cases~append(.array~of("a reverse ordered array", self~reverseInput, self~reverseOutput))
  cases~append(.array~of("an array of identical elements", self~identicalInput, self~identicalOutput))
  cases~append(.array~of("an array with negative numbers", self~negativeInput, self~negativeOutput))
  cases~append(.array~of("a single element array", self~singleInput, self~singleOutput))
  cases~append(.array~of("an empty array", self~emptyInput, self~emptyOutput))
  cases~append(.array~of("a null input", self~nullInput, self~nullOutput))
  return cases

/* Helper compartido: recibe el nombre del método a probar y el nombre del
 * algoritmo, y ejecuta todos los casos con el mensaje descriptivo del contrato.
 */
::method assertSortsAllCases
  use arg methodName, algorithm
  cases = .NaiveSortTest~cases
  do i = 1 to cases~items
    aCase = cases[i]
    actual = .NaiveSort~send(methodName, self~buildArray(aCase[2]))
    self~assertEquals(self~asText(aCase[3]), self~asText(actual), algorithm "should sort" aCase[1])
  end

/* Construye un .Array nuevo por caso: los algoritmos ordenan in-place. */
::method buildArray
  use arg input
  if input == .Nil then return .Nil
  values = .array~new
  do i = 1 to words(input)
    values~append(word(input, i))
  end
  return values

/* Normaliza el valor a texto comparable, con un blanco entre elementos; las
 * cadenas se ajustan a espacios simples y .Nil se conserva como indicador. */
::method asText
  use arg value
  if value == .Nil then return .Nil
  if \value~isA(.array) then return space(value)
  text = ""
  do i = 1 to value~items
    text = text value~at(i)
  end
  return strip(text)

::method testSelectionSort
  self~assertSortsAllCases("selection_sort", "selection_sort")

::method testBubbleSort
  self~assertSortsAllCases("bubble_sort", "bubble_sort")

::method testInsertionSort
  self~assertSortsAllCases("insertion_sort", "insertion_sort")
