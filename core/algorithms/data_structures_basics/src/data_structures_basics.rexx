/* data_structures_basics — Node, LinkedList, Stack y Queue
 *
 * Especificación: 06_Data_Structures_Basics
 *
 * Contrato ooRexx: cuatro clases públicas en un solo archivo, que es la
 * convención del lenguaje; separar una clase por archivo y reexportarlas con
 * ::requires queda para cuando haya que modularizar. `init` es el constructor
 * del contrato y crea el estado inicial: enlaces ausentes y contador a cero.
 *
 * Adecuaciones:
 *   - Indicadores de fallo de esta fase: las lecturas enteras que pueden fallar
 *     (`get_head`, `peek`, `pop`, `dequeue`) devuelven **-1**; las booleanas
 *     (`delete`, `is_empty`) devuelven **1** (éxito / cierto) o **0** (fallo /
 *     falso). **Solo los enlaces** (`next`, `head`, `tail`, `top`, `front`,
 *     `rear`) usan `.Nil` como ausencia.
 *   - El estado de instancia se declara con `::attribute`: ooRexx no crea
 *     variables de instancia por asignación (`self~x = v` sin atributo falla
 *     con 97.1).
 *   - Los cuerpos de las operaciones son esqueletos que devuelven el indicador
 *     natural y no lanzan excepciones: el algoritmo es del paso 5.
 */

/* Node: celda enlazada compartida por LinkedList, Stack y Queue.
 * Adecuación: `value` no se reasigna después de la construcción; `next` sí.
 */
::class Node public

::attribute value
::attribute next

::method init
  use arg value
  self~value = value
  self~next  = .Nil

::method get_value
  return -1

::method get_next
  return .Nil

::method set_next
  use arg n
  return

/* LinkedList: lista enlazada construida desde cero sobre Node. */
::class LinkedList public

::attribute head
::attribute tail
::attribute count

::method init
  self~head  = .Nil
  self~tail  = .Nil
  self~count = 0

::method get_head
  return -1

::method insert_head
  use arg value
  return

::method insert_tail
  use arg value
  return

::method delete
  use arg value
  return 0

::method is_empty
  return 0

::method size
  return 0

/* Stack: pila LIFO construida desde cero sobre Node. */
::class Stack public

::attribute top
::attribute count

::method init
  self~top   = .Nil
  self~count = 0

::method push
  use arg value
  return

::method pop
  return -1

::method peek
  return -1

::method is_empty
  return 0

::method size
  return 0

/* Queue: cola FIFO construida desde cero sobre Node. */
::class Queue public

::attribute front
::attribute rear
::attribute count

::method init
  self~front = .Nil
  self~rear  = .Nil
  self~count = 0

::method enqueue
  use arg value
  return

::method dequeue
  return -1

::method peek
  return -1

::method is_empty
  return 0

::method size
  return 0
