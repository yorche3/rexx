/* data_structures_advanced — Node, TreeNode, GraphNode, BinaryTree, Graph
 *
 * Especificación: 07_Data_Structures_Advanced
 *
 * Contrato: clases ooRexx y métodos en este archivo. Los constructores se
 * invocan con ~new y no devuelven un valor desde init.
 * TreeNode~get_value devuelve el entero; get_left/get_right devuelven un
 * TreeNode o .Nil; set_left/set_right aceptan ambos y devuelven el receptor.
 * BinaryTree~insert/contains y Graph~add_vertex/add_edge/has_edge devuelven
 * 1 por éxito y 0 por fallo; is_empty usa 1/0 y los contadores son enteros.
 * Graph~get_neighbors devuelve una .List independiente y ordenada, o .Nil
 * si falta el vértice. Los cuerpos son esqueletos, no implementaciones.
 */

::class Node

::method init
  use arg value
  return

::method get_value
  return .Nil

::class TreeNode subclass Node public

::method init
  use arg value
  return

::method get_left
  return .Nil

::method get_right
  return .Nil

::method set_left
  use arg node
  return .Nil

::method set_right
  use arg node
  return .Nil

::class BinaryTree public

::method init
  return

::method insert
  use arg value
  return 0

::method contains
  use arg value
  return 0

::method is_empty
  return 0

::method size
  return 0

::class GraphNode subclass Node

::method init
  use arg label
  return

::class Graph public

::method init
  return

::method add_vertex
  use arg label
  return 0

::method add_edge
  use arg u, v
  return 0

::method has_edge
  use arg u, v
  return 0

::method get_neighbors
  use arg u
  return .Nil

::method is_empty
  return 0

::method vertex_count
  return 0

::method edge_count
  return 0
