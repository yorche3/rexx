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
 *   - Operaciones implementadas con recorridos propios y `do`/`end` explícitos
 *     para los bloques de más de una instrucción (en REXX un `if` no se cierra
 *     con `end`: es Error 10). Sin excepciones ni indicadores nuevos: solo los
 *     de arriba.
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
  return self~value

::method get_next
  return self~next

::method set_next
  use arg n
  self~next = n
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
  if self~head == .Nil then return -1
  return self~head~get_value()

::method insert_head
  use arg value
  new_node = .Node~new(value)
  new_node~set_next(self~head)
  self~head = new_node
  if self~tail == .Nil then self~tail = new_node
  self~count = self~count + 1
  return

::method insert_tail
  use arg value
  new_node = .Node~new(value)
  if self~tail == .Nil then do
    self~head = new_node
    self~tail = new_node
  end
  else do
    self~tail~set_next(new_node)
    self~tail = new_node
  end
  self~count = self~count + 1
  return

::method delete
  use arg value
  current  = self~head
  previous = .Nil
  do while current \== .Nil
    if current~get_value() == value then do
      if previous == .Nil then do
        self~head = current~get_next()
      end
      else do
        previous~set_next(current~get_next())
      end
      if current~get_next() == .Nil then self~tail = previous
      self~count = self~count - 1
      return 1
    end
    previous = current
    current  = current~get_next()
  end
  return 0

::method is_empty
  return self~count == 0

::method size
  return self~count

/* Stack: pila LIFO construida desde cero sobre Node. */
::class Stack public

::attribute top
::attribute count

::method init
  self~top   = .Nil
  self~count = 0

::method push
  use arg value
  new_node = .Node~new(value)
  new_node~set_next(self~top)
  self~top = new_node
  self~count = self~count + 1
  return

::method pop
  if self~top == .Nil then return -1
  value = self~top~get_value()
  self~top = self~top~get_next()
  self~count = self~count - 1
  return value

::method peek
  if self~top == .Nil then return -1
  return self~top~get_value()

::method is_empty
  return self~count == 0

::method size
  return self~count

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
  new_node = .Node~new(value)
  if self~rear == .Nil then do
    self~front = new_node
    self~rear = new_node
  end
  else do
    self~rear~set_next(new_node)
    self~rear = new_node
  end
  self~count = self~count + 1
  return

::method dequeue
  if self~front == .Nil then return -1
  value = self~front~get_value()
  self~front = self~front~get_next()
  if self~front == .Nil then self~rear = .Nil
  self~count = self~count - 1
  return value

::method peek
  if self~front == .Nil then return -1
  return self~front~get_value()

::method is_empty
  return self~count == 0

::method size
  return self~count
