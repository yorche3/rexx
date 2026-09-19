::class NaiveSort public

/* naive_sort — ordenamientos elementales O(n²).
 *
 * Especificación: 05_Naive_Sort
 *
 * Contrato: recibe una lista de enteros como .Array de ooRexx
 * (.array~of(5, 2, 9, 1, 5, 6)) y devuelve la misma lista ordenada de menor a
 * mayor. El orden es in-place: se modifican los elementos de la entrada y se
 * devuelve su referencia, sin invocar ninguna biblioteca de ordenamiento ni
 * estructuras auxiliares complejas.
 * Si la entrada es .Nil devuelve .Nil como indicador de fallo; si tiene menos
 * de dos elementos (.array~new) devuelve la entrada sin cambios. No lanza
 * excepciones.
 */
::method selection_sort class
  use arg arr
  if arr == .nil then return .nil
  n = arr~items
  if n < 2 then return arr
  do i = 1 to n - 1
    min_index = i
    do j = i + 1 to n
      if arr~at(j) < arr~at(min_index) then do
        min_index = j
      end
    end
    if min_index \= i then do
      temp = arr~at(i)
      arr[i] = arr~at(min_index)
      arr[min_index] = temp
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
      if arr~at(j) > arr~at(j + 1) then do
        temp = arr~at(j)
        arr[j] = arr~at(j + 1)
        arr[j + 1] = temp
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
    do while j > 0
      if arr~at(j) <= key then leave
      arr[j + 1] = arr~at(j)
      j = j - 1
    end
    arr[j + 1] = key
  end
  return arr
