::class NaiveSort public

/* naive_sort — ordenamientos elementales O(n²).
 *
 * Especificación: 05_Naive_Sort
 *
 * Contrato: recibe una lista de enteros como cadena separada por blancos
 * ("5 2 9 1 5 6", el idioma de secuencia de REXX: words/word/subword) y
 * devuelve la lista ordenada de menor a mayor (in-place o como copia ordenada),
 * sin invocar ninguna biblioteca de ordenamiento y sin estructuras auxiliares
 * complejas. Las cadenas de REXX son inmutables, así que el resultado vuelve
 * por el valor devuelto.
 * Si la entrada es .Nil devuelve .Nil como indicador de fallo; si está vacía
 * ("") devuelve la misma cadena vacía. No lanza excepciones.
 *
 * Implementación pendiente: la escribe el autor. Esta delegación solo genera el
 * esqueleto y las pruebas unitarias.
 */
::method selection_sort class
  use arg arr
  if arr == .nil then return .nil
  n = arr~items
  if n < 2 then return arr
  do i = 1 to n - 1
    min_index = i
    do j = i + 1 to n
      if arr~at(j) < arr~at(min_index) then
        min_index = j
      end
    end
    if min_index \= i then
      temp = arr~at(i)
      arr~at(i) = arr~at(min_index)
      arr~at(min_index) = temp
    end
  end
  return arr

::method bubble_sort class
  use arg arr
  if arr == .nil then return .nil
  n = arr~items
  if n < 2 then return arr
  do i = 1 to n - 1
    swapped = .false
    do j = 1 to n - i
      if arr~at(j) > arr~at(j + 1) then
        temp = arr~at(j)
        arr~at(j) = arr~at(j + 1)
        arr~at(j + 1) = temp
        swapped = .true
      end
    end
    if swapped == .false then leave
  end
  return arr

::method insertion_sort class
  use arg arr
  if arr == .nil then return .nil
  n = arr~items
  if n < 2 then return arr
  do i = 2 to n
    key = arr~at(i)
    j = i - 1
    do while j > 0 & arr~at(j) > key
      arr~at(j + 1) = arr~at(j)
      j = j - 1
    end
    arr~at(j + 1) = key
  end
  return arr
