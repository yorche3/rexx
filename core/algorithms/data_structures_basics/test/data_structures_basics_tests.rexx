/* Casos de prueba de la especificación 06_Data_Structures_Basics.md
 *
 * Contrato: cuatro clases públicas (Node, LinkedList, Stack, Queue). Cada tabla
 * de la especificación se ejecuta como una secuencia de operaciones sobre la
 * MISMA instancia, sin recrear objetos para cada borde: los escenarios van de
 * lo vacío a lo lleno y vuelven a lo vacío.
 *
 * Representación: la suite no observa la representación, solo el contrato
 * (valores devueltos, size, is_empty y el valor de la cabeza). Indicadores de
 * la fase: -1 en las lecturas enteras que pueden fallar (get_head, peek, pop,
 * dequeue) y 1/0 en las booleanas (delete, is_empty). Los enlaces solo se
 * manipulan a través de la estructura. No se espera ninguna excepción.
 */

aResult = .TestSuite~new(.DataStructuresBasicsTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/data_structures_basics.rexx"

::class DataStructuresBasicsTest subclass TestCase

/* Node -------------------------------------------------------------------- */

::method testNodeGetValue
  node = .Node~new(42)
  self~assertEquals(42, node~get_value(), "Node get_value should return the value given to init")

::method testNodeGetNext
  node = .Node~new(42)
  self~assertEquals(.Nil, node~get_next(), "Node get_next should be an absent link before set_next")

::method testNodeSetNext
  node = .Node~new(42)
  linked = .Node~new(7)
  node~set_next(linked)
  self~assertEquals(7, node~get_next()~get_value(), "Node get_next should see the node linked by set_next")
  node~set_next(.Nil)
  self~assertEquals(.Nil, node~get_next(), "Node set_next should accept an absent link")

/* LinkedList -------------------------------------------------------------- */

::method testLinkedListInit
  list = .LinkedList~new
  self~assertEquals(0, list~size(), "LinkedList size should be 0 after init")
  self~assertEquals(1, list~is_empty(), "LinkedList is_empty should be 1 after init")
  self~assertEquals(-1, list~get_head(), "LinkedList get_head should be the failure indicator when empty")

::method testLinkedListGetHead
  list = .LinkedList~new
  self~assertEquals(-1, list~get_head(), "LinkedList get_head should be the failure indicator when empty")
  list~insert_tail(10)
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 after the first insertion")
  list~insert_head(5)
  self~assertEquals(5, list~get_head(), "LinkedList get_head should be the last inserted head")
  self~assertEquals(5, list~get_head(), "LinkedList get_head should not remove the head")
  list~delete(5)
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 after the head is removed")

::method testLinkedListInsertHead
  list = .LinkedList~new
  list~insert_head(10)
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 after inserting 10 into an empty list")
  self~assertEquals(1, list~size(), "LinkedList size should be 1 after one insert_head")
  list~insert_head(5)
  self~assertEquals(5, list~get_head(), "LinkedList get_head should be 5 after inserting 5 at the head")
  self~assertEquals(2, list~size(), "LinkedList size should be 2 after two insert_head")
  self~assertEquals(0, list~is_empty(), "LinkedList is_empty should be 0 with two elements")

::method testLinkedListInsertTail
  list = .LinkedList~new
  list~insert_tail(10)
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 after the first insert_tail")
  self~assertEquals(1, list~size(), "LinkedList size should be 1 after one insert_tail")
  list~insert_tail(20)
  list~insert_tail(30)
  self~assertEquals(10, list~get_head(), "LinkedList get_head should stay 10 when appending at the tail")
  self~assertEquals(3, list~size(), "LinkedList size should be 3 after three insert_tail")
  list~insert_head(5)
  self~assertEquals(5, list~get_head(), "LinkedList get_head should be the new head after insert_head on a non empty list")
  self~assertEquals(4, list~size(), "LinkedList size should be 4 after mixing insert_head and insert_tail")

::method testLinkedListDelete
  list = .LinkedList~new
  list~insert_tail(10)
  list~insert_tail(20)
  list~insert_tail(30)
  list~insert_head(5)
  self~assertEquals(4, list~size(), "LinkedList size should be 4 before deleting")
  self~assertEquals(1, list~delete(5), "LinkedList delete should report success when removing the head")
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 after the head is removed")
  self~assertEquals(3, list~size(), "LinkedList size should be 3 after the head is removed")
  self~assertEquals(1, list~delete(30), "LinkedList delete should report success when removing the tail")
  self~assertEquals(2, list~size(), "LinkedList size should be 2 after the tail is removed")
  list~insert_tail(40)
  self~assertEquals(3, list~size(), "LinkedList size should be 3 after appending to the list whose tail was removed")
  self~assertEquals(1, list~delete(40), "LinkedList delete should find the element appended after the tail was removed")
  self~assertEquals(2, list~size(), "LinkedList size should be 2 after removing that element")
  self~assertEquals(0, list~delete(99), "LinkedList delete should report failure for a value that is not stored")
  self~assertEquals(2, list~size(), "LinkedList size should not change when delete reports failure")
  self~assertEquals(1, list~delete(20), "LinkedList delete should report success when removing a middle element")
  self~assertEquals(1, list~size(), "LinkedList size should be 1 after removing the middle element")
  self~assertEquals(10, list~get_head(), "LinkedList get_head should be 10 with a single element left")
  self~assertEquals(1, list~delete(10), "LinkedList delete should report success when removing the only element")
  self~assertEquals(1, list~is_empty(), "LinkedList is_empty should be 1 after the only element is removed")
  self~assertEquals(-1, list~get_head(), "LinkedList get_head should be the failure indicator after the list is emptied")
  self~assertEquals(0, list~delete(10), "LinkedList delete should report failure on an empty list")
  list~insert_head(1)
  self~assertEquals(1, list~get_head(), "LinkedList get_head should be 1 after reusing an emptied list")
  self~assertEquals(1, list~size(), "LinkedList size should be 1 after reusing an emptied list")

::method testLinkedListIsEmpty
  list = .LinkedList~new
  self~assertEquals(1, list~is_empty(), "LinkedList is_empty should be 1 for a new list")
  list~insert_tail(10)
  self~assertEquals(0, list~is_empty(), "LinkedList is_empty should be 0 with one element")
  list~delete(10)
  self~assertEquals(1, list~is_empty(), "LinkedList is_empty should be 1 after the element is removed")

::method testLinkedListSize
  list = .LinkedList~new
  self~assertEquals(0, list~size(), "LinkedList size should be 0 for a new list")
  list~insert_head(1)
  list~insert_tail(2)
  list~insert_tail(3)
  self~assertEquals(3, list~size(), "LinkedList size should be 3 after three insertions")
  list~delete(2)
  self~assertEquals(2, list~size(), "LinkedList size should be 2 after one removal")
  list~delete(2)
  self~assertEquals(2, list~size(), "LinkedList size should not change when delete reports failure")

/* Stack ------------------------------------------------------------------- */

::method testStackInit
  stack = .Stack~new
  self~assertEquals(0, stack~size(), "Stack size should be 0 after init")
  self~assertEquals(1, stack~is_empty(), "Stack is_empty should be 1 after init")
  self~assertEquals(-1, stack~peek(), "Stack peek should be the failure indicator when empty")
  self~assertEquals(-1, stack~pop(), "Stack pop should be the failure indicator when empty")

::method testStackPush
  stack = .Stack~new
  stack~push(1)
  self~assertEquals(1, stack~size(), "Stack size should be 1 after one push")
  self~assertEquals(1, stack~peek(), "Stack peek should be the most recently pushed value")
  stack~push(2)
  stack~push(3)
  self~assertEquals(3, stack~size(), "Stack size should be 3 after three pushes")
  self~assertEquals(3, stack~peek(), "Stack peek should be 3 after pushing 3")
  self~assertEquals(0, stack~is_empty(), "Stack is_empty should be 0 with three elements")

::method testStackPop
  stack = .Stack~new
  stack~push(1)
  stack~push(2)
  stack~push(3)
  self~assertEquals(3, stack~pop(), "Stack pop should return the last pushed value first")
  self~assertEquals(2, stack~size(), "Stack size should be 2 after one pop")
  self~assertEquals(2, stack~pop(), "Stack pop should return the next value in LIFO order")
  self~assertEquals(1, stack~pop(), "Stack pop should return the first pushed value last")
  self~assertEquals(0, stack~size(), "Stack size should be 0 after popping every element")
  self~assertEquals(1, stack~is_empty(), "Stack is_empty should be 1 after popping every element")
  self~assertEquals(-1, stack~pop(), "Stack pop should be the failure indicator on an empty stack")
  self~assertEquals(-1, stack~peek(), "Stack peek should be the failure indicator after the stack is emptied")
  stack~push(9)
  self~assertEquals(9, stack~pop(), "Stack pop should work on a stack reused after being emptied")

::method testStackPeek
  stack = .Stack~new
  stack~push(1)
  stack~push(2)
  self~assertEquals(2, stack~peek(), "Stack peek should return the top value")
  self~assertEquals(2, stack~size(), "Stack peek should not change the size")
  self~assertEquals(2, stack~pop(), "Stack peek should not consume the value")

::method testStackIsEmpty
  stack = .Stack~new
  self~assertEquals(1, stack~is_empty(), "Stack is_empty should be 1 for a new stack")
  stack~push(1)
  self~assertEquals(0, stack~is_empty(), "Stack is_empty should be 0 with one element")
  stack~pop()
  self~assertEquals(1, stack~is_empty(), "Stack is_empty should be 1 after the element is popped")

::method testStackSize
  stack = .Stack~new
  self~assertEquals(0, stack~size(), "Stack size should be 0 for a new stack")
  stack~push(1)
  stack~push(2)
  self~assertEquals(2, stack~size(), "Stack size should be 2 after two pushes")
  stack~pop()
  self~assertEquals(1, stack~size(), "Stack size should be 1 after one pop")
  stack~pop()
  self~assertEquals(0, stack~size(), "Stack size should be 0 after popping every element")

/* Queue ------------------------------------------------------------------- */

::method testQueueInit
  queue = .Queue~new
  self~assertEquals(0, queue~size(), "Queue size should be 0 after init")
  self~assertEquals(1, queue~is_empty(), "Queue is_empty should be 1 after init")
  self~assertEquals(-1, queue~peek(), "Queue peek should be the failure indicator when empty")
  self~assertEquals(-1, queue~dequeue(), "Queue dequeue should be the failure indicator when empty")

::method testQueueEnqueue
  queue = .Queue~new
  queue~enqueue(1)
  self~assertEquals(1, queue~size(), "Queue size should be 1 after one enqueue")
  self~assertEquals(1, queue~peek(), "Queue peek should be the first enqueued value")
  queue~enqueue(2)
  queue~enqueue(3)
  self~assertEquals(3, queue~size(), "Queue size should be 3 after three enqueues")
  self~assertEquals(1, queue~peek(), "Queue peek should stay at the front when enqueuing")
  self~assertEquals(0, queue~is_empty(), "Queue is_empty should be 0 with three elements")

::method testQueueDequeue
  queue = .Queue~new
  queue~enqueue(1)
  queue~enqueue(2)
  queue~enqueue(3)
  self~assertEquals(1, queue~dequeue(), "Queue dequeue should return the first enqueued value first")
  self~assertEquals(2, queue~size(), "Queue size should be 2 after one dequeue")
  self~assertEquals(2, queue~dequeue(), "Queue dequeue should return the next value in FIFO order")
  self~assertEquals(3, queue~dequeue(), "Queue dequeue should return the last enqueued value last")
  self~assertEquals(0, queue~size(), "Queue size should be 0 after dequeuing every element")
  self~assertEquals(1, queue~is_empty(), "Queue is_empty should be 1 after dequeuing every element")
  self~assertEquals(-1, queue~dequeue(), "Queue dequeue should be the failure indicator on an empty queue")
  self~assertEquals(-1, queue~peek(), "Queue peek should be the failure indicator after the queue is emptied")
  queue~enqueue(9)
  self~assertEquals(9, queue~dequeue(), "Queue dequeue should work on a queue reused after being emptied")

::method testQueuePeek
  queue = .Queue~new
  queue~enqueue(1)
  queue~enqueue(2)
  self~assertEquals(1, queue~peek(), "Queue peek should return the front value")
  self~assertEquals(2, queue~size(), "Queue peek should not change the size")
  self~assertEquals(1, queue~dequeue(), "Queue peek should not consume the value")

::method testQueueIsEmpty
  queue = .Queue~new
  self~assertEquals(1, queue~is_empty(), "Queue is_empty should be 1 for a new queue")
  queue~enqueue(1)
  self~assertEquals(0, queue~is_empty(), "Queue is_empty should be 0 with one element")
  queue~dequeue()
  self~assertEquals(1, queue~is_empty(), "Queue is_empty should be 1 after the element is dequeued")

::method testQueueSize
  queue = .Queue~new
  self~assertEquals(0, queue~size(), "Queue size should be 0 for a new queue")
  queue~enqueue(1)
  queue~enqueue(2)
  self~assertEquals(2, queue~size(), "Queue size should be 2 after two enqueues")
  queue~dequeue()
  self~assertEquals(1, queue~size(), "Queue size should be 1 after one dequeue")
  queue~dequeue()
  self~assertEquals(0, queue~size(), "Queue size should be 0 after dequeuing every element")
