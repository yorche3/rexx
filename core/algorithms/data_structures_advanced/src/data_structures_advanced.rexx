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

::attribute value

::method init
  use arg value
  self~value = value
  return

::method get_value
  return self~value

::class TreeNode subclass Node public

::attribute left
::attribute right

::method init
  use arg value
  self~value = value
  self~left = .Nil
  self~right = .Nil
  return

::method get_left
  return self~left

::method get_right
  return self~right

::method set_left
  use arg node
  self~left = node
  return self

::method set_right
  use arg node
  self~right = node
  return self

::class BinaryTree public

::attribute root
::attribute count

::method init
  self~root = .Nil
  self~count = 0
  return

::method insert
  use arg value
  if self~root == .Nil then do
    self~root = .TreeNode~new(value)
    self~count = self~count + 1
    return 1
  end
  current = self~root
  do while current \= .Nil
    if value == current~get_value then return 1
    if value < current~get_value then do
      if current~get_left == .Nil then do
        current~set_left(.TreeNode~new(value))
        self~count = self~count + 1
        return 1
      end
      current = current~get_left
    end
    else do
      if current~get_right == .Nil then do
        current~set_right(.TreeNode~new(value))
        self~count = self~count + 1
        return 1
      end
      current = current~get_right
    end
  end
  return 0

::method contains
  use arg value
  current = self~root
  do while current \= .Nil
    if value == current~get_value then return 1
    if value < current~get_value then current = current~get_left
    else current = current~get_right
  end
  return 0

::method is_empty
  return self~count == 0

::method size
  return self~count

::class GraphNode subclass Node

::attribute neighbors
::attribute next_vertex

::method init
  use arg label
  self~value = label
  self~neighbors = .List~new
  self~next_vertex = .Nil
  return

::class Graph public

::attribute vertices
::attribute vertex_total
::attribute edges

::method init
  self~vertices = .Nil
  self~vertex_total = 0
  self~edges = 0
  return

::method find_vertex
  use arg label
  current = self~vertices
  do while current \= .Nil
    if current~get_value == label then return current
    current = current~next_vertex
  end
  return .Nil

::method add_vertex
  use arg label
  if self~find_vertex(label) \= .Nil then return 1
  new_vertex = .GraphNode~new(label)
  new_vertex~next_vertex = self~vertices
  self~vertices = new_vertex
  self~vertex_total = self~vertex_total + 1
  return 1

::method add_edge
  use arg u, v
  u_vertex = self~find_vertex(u)
  if u_vertex == .Nil then return 0
  if self~find_vertex(v) == .Nil then return 0
  do nb over u_vertex~neighbors
    if nb == v then return 1
  end
  new_list = .List~new
  inserted = 0
  do nb over u_vertex~neighbors
    if inserted == 0 & v < nb then do
      new_list~append(v)
      inserted = 1
    end
    new_list~append(nb)
  end
  if inserted == 0 then new_list~append(v)
  u_vertex~neighbors = new_list
  self~edges = self~edges + 1
  return 1

::method has_edge
  use arg u, v
  u_vertex = self~find_vertex(u)
  if u_vertex == .Nil then return 0
  do nb over u_vertex~neighbors
    if nb == v then return 1
  end
  return 0

::method get_neighbors
  use arg u
  u_vertex = self~find_vertex(u)
  if u_vertex == .Nil then return .Nil
  copy = .List~new
  do nb over u_vertex~neighbors
    copy~append(nb)
  end
  return copy

::method is_empty
  return self~vertex_total == 0

::method vertex_count
  return self~vertex_total

::method edge_count
  return self~edges
