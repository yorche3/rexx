/* Casos de prueba de la especificación 07_Data_Structures_Advanced.md
 *
 * Contrato: TreeNode, BinaryTree y Graph (ooRexx). Cada fila de la especificación
 * es un método de prueba con una instancia recién creada y sus pasos en orden.
 * La suite solo usa las operaciones del contrato. Indicadores: .Nil como
 * ausencia (enlaces y get_neighbors de un vértice inexistente) y 1/0 en
 * insert, contains, add_vertex, add_edge, has_edge e is_empty.
 * Los vecinos se comparan como texto ordenado separado por espacios; una
 * .List vacía ("") es distinta de .Nil.
 * Omitido: "Adaptación inmutable": TreeNode de ooRexx es mutable y set_left
 * devuelve el receptor, por lo que el caso condicional no aplica.
 */

aResult = .TestSuite~new(.DataStructuresAdvancedTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/data_structures_advanced.rexx"

::class DataStructuresAdvancedTest subclass TestCase

/* Ayudantes --------------------------------------------------------------- */

::method neighbors
  use arg graph, u
  list = graph~get_neighbors(u)
  if list == .Nil then return "<absent>"
  text = ""
  do item over list~allItems
    text = text item
  end
  return strip(text)

::method assertInserts
  use arg tree, values, label
  do i = 1 to words(values)
    value = word(values, i)
    self~assertEquals(1, tree~insert(value), label": insert" value "should succeed")
  end

::method assertContainsAll
  use arg tree, values, label
  do i = 1 to words(values)
    value = word(values, i)
    self~assertEquals(1, tree~contains(value), label": contains" value "should succeed")
  end

::method graphWith
  use arg labels
  graph = .Graph~new
  do i = 1 to words(labels)
    label = word(labels, i)
    self~assertEquals(1, graph~add_vertex(label), "add_vertex" label "should succeed")
  end
  return graph

::method assertCounts
  use arg graph, vertices, edges, label
  self~assertEquals(vertices, graph~vertex_count(), label": vertex_count should be" vertices)
  self~assertEquals(edges, graph~edge_count(), label": edge_count should be" edges)

::method valueOf
  use arg node
  if node == .Nil then return "<absent>"
  return node~get_value()

::method linkOf
  use arg node, which
  if node == .Nil then return "<no node>"
  if which == "get_left" then return node~get_left()
  return node~get_right()

/* TreeNode ---------------------------------------------------------------- */

::method testTreeNodeCreate
  node = .TreeNode~new(10)
  self~assertEquals(10, node~get_value(), "Create a tree node: get_value should be 10")

::method testTreeNodeInitialLinksAbsent
  node = .TreeNode~new(10)
  self~assertEquals(.Nil, node~get_left(), "Absent initial links: get_left should be absent")
  self~assertEquals(.Nil, node~get_right(), "Absent initial links: get_right should be absent")

::method testTreeNodeLinkTwoChildren
  parent = .TreeNode~new(10)
  parent~set_left(.TreeNode~new(20))
  parent~set_right(.TreeNode~new(30))
  self~assertEquals(20, self~valueOf(parent~get_left()), "Link two children: left value should be 20")
  self~assertEquals(30, self~valueOf(parent~get_right()), "Link two children: right value should be 30")

::method testTreeNodeTraverseEachLink
  parent = .TreeNode~new(10)
  parent~set_left(.TreeNode~new(20))
  parent~set_right(.TreeNode~new(30))
  left = parent~get_left()
  right = parent~get_right()
  self~assertEquals(20, self~valueOf(left), "Traverse each link: get_left should lead to 20")
  self~assertEquals(30, self~valueOf(right), "Traverse each link: get_right should lead to 30")
  self~assertEquals(.Nil, self~linkOf(left, "get_left"), "Traverse each link: left child get_left should be absent")
  self~assertEquals(.Nil, self~linkOf(left, "get_right"), "Traverse each link: left child get_right should be absent")
  self~assertEquals(.Nil, self~linkOf(right, "get_left"), "Traverse each link: right child get_left should be absent")
  self~assertEquals(.Nil, self~linkOf(right, "get_right"), "Traverse each link: right child get_right should be absent")

::method testTreeNodeUnlinkChildren
  parent = .TreeNode~new(10)
  parent~set_left(.TreeNode~new(20))
  parent~set_right(.TreeNode~new(30))
  parent~set_left(.Nil)
  self~assertEquals(.Nil, parent~get_left(), "Unlink children: left should be absent after clearing left")
  self~assertEquals(10, parent~get_value(), "Unlink children: value should stay 10 after clearing left")
  self~assertEquals(30, self~valueOf(parent~get_right()), "Unlink children: right child 30 should be kept after clearing left")
  parent~set_right(.Nil)
  self~assertEquals(.Nil, parent~get_left(), "Unlink children: left should be absent after clearing right")
  self~assertEquals(.Nil, parent~get_right(), "Unlink children: right should be absent after clearing right")
  self~assertEquals(10, parent~get_value(), "Unlink children: value should stay 10 after clearing right")

/* BinaryTree -------------------------------------------------------------- */

::method testBinaryTreeCreateEmpty
  tree = .BinaryTree~new
  self~assertEquals(1, tree~is_empty(), "Create empty: is_empty should be 1")
  self~assertEquals(0, tree~size(), "Create empty: size should be 0")
  self~assertEquals(0, tree~contains(50), "Create empty: contains 50 should fail")

::method testBinaryTreeInsertRoot
  tree = .BinaryTree~new
  self~assertEquals(1, tree~insert(50), "Insert the root: insert 50 should succeed")
  self~assertEquals(1, tree~size(), "Insert the root: size should be 1")
  self~assertEquals(0, tree~is_empty(), "Insert the root: is_empty should be 0")
  self~assertEquals(1, tree~contains(50), "Insert the root: contains 50 should succeed")

::method testBinaryTreeInsertLowerAndHigher
  tree = .BinaryTree~new
  self~assertInserts(tree, "50 30 70", "Insert lower and higher")
  self~assertEquals(3, tree~size(), "Insert lower and higher: size should be 3")
  self~assertContainsAll(tree, "50 30 70", "Insert lower and higher")

::method testBinaryTreeMultilevelBranches
  tree = .BinaryTree~new
  self~assertInserts(tree, "50 30 70 20 40", "Multilevel branches")
  self~assertContainsAll(tree, "50 30 70 20 40", "Multilevel branches")
  self~assertEquals(5, tree~size(), "Multilevel branches: size should be 5")

::method testBinaryTreeMissingValueNonEmpty
  tree = .BinaryTree~new
  self~assertEquals(1, tree~insert(50), "Missing value in nonempty tree: insert 50 should succeed")
  self~assertEquals(0, tree~contains(99), "Missing value in nonempty tree: contains 99 should fail")
  self~assertEquals(1, tree~size(), "Missing value in nonempty tree: size should stay 1")
  self~assertEquals(1, tree~contains(50), "Missing value in nonempty tree: contains 50 should still succeed")

::method testBinaryTreeIdempotentDuplicate
  tree = .BinaryTree~new
  self~assertInserts(tree, "50 30 70 30", "Idempotent duplicate")
  self~assertEquals(3, tree~size(), "Idempotent duplicate: size should be 3")
  self~assertContainsAll(tree, "50 30 70", "Idempotent duplicate")

::method testBinaryTreeOrderedInsertions
  tree = .BinaryTree~new
  self~assertInserts(tree, "20 30 40 50 70", "Ordered insertions")
  self~assertEquals(5, tree~size(), "Ordered insertions: size should be 5")
  self~assertContainsAll(tree, "20 30 40 50 70", "Ordered insertions")
  self~assertEquals(0, tree~contains(99), "Ordered insertions: contains 99 should fail")

/* Graph ------------------------------------------------------------------- */

::method testGraphCreateEmpty
  graph = .Graph~new
  self~assertEquals(1, graph~is_empty(), "Graph create empty: is_empty should be 1")
  self~assertCounts(graph, 0, 0, "Graph create empty")
  self~assertEquals(0, graph~has_edge(10, 30), "Graph create empty: has_edge 10 30 should fail")
  self~assertEquals(.Nil, graph~get_neighbors(10), "Graph create empty: get_neighbors 10 should fail")

::method testGraphIsolatedVertex
  graph = .Graph~new
  self~assertEquals(1, graph~add_vertex(10), "Isolated vertex: add_vertex 10 should succeed")
  self~assertEquals(0, graph~is_empty(), "Isolated vertex: is_empty should be 0")
  self~assertCounts(graph, 1, 0, "Isolated vertex")
  self~assertEquals("", self~neighbors(graph, 10), "Isolated vertex: neighbours of 10 should be empty")

::method testGraphNonconsecutiveLabelsDirectedEdge
  graph = self~graphWith("10 70")
  self~assertEquals(1, graph~add_edge(10, 70), "Directed edge: add_edge 10 70 should succeed")
  self~assertEquals(1, graph~has_edge(10, 70), "Directed edge: has_edge 10 70 should succeed")
  self~assertEquals(0, graph~has_edge(70, 10), "Directed edge: has_edge 70 10 should fail")
  self~assertCounts(graph, 2, 1, "Directed edge")

::method testGraphDuplicateVertexPreservesAdjacency
  graph = self~graphWith("10 30")
  self~assertEquals(1, graph~add_edge(10, 30), "Duplicate vertex: add_edge 10 30 should succeed")
  self~assertEquals(1, graph~add_vertex(10), "Duplicate vertex: add_vertex 10 again should succeed")
  self~assertCounts(graph, 2, 1, "Duplicate vertex")
  self~assertEquals("30", self~neighbors(graph, 10), "Duplicate vertex: neighbours of 10 should be 30")

::method testGraphDuplicateEdge
  graph = self~graphWith("10 30")
  self~assertEquals(1, graph~add_edge(10, 30), "Duplicate edge: first add_edge should succeed")
  self~assertEquals(1, graph~add_edge(10, 30), "Duplicate edge: second add_edge should succeed")
  self~assertCounts(graph, 2, 1, "Duplicate edge")
  self~assertEquals("30", self~neighbors(graph, 10), "Duplicate edge: neighbours of 10 should be 30")

::method testGraphMissingEndpointWithoutMutation
  graph = self~graphWith("10 30")
  self~assertEquals(1, graph~add_edge(10, 30), "Missing endpoint: add_edge 10 30 should succeed")
  self~assertEquals(0, graph~add_edge(10, 99), "Missing endpoint: add_edge 10 99 should fail")
  self~assertEquals(0, graph~add_edge(99, 10), "Missing endpoint: add_edge 99 10 should fail")
  self~assertEquals(0, graph~add_edge(98, 99), "Missing endpoint: add_edge 98 99 should fail")
  self~assertEquals(0, graph~add_edge(99, 99), "Missing endpoint: add_edge 99 99 should fail")
  self~assertCounts(graph, 2, 1, "Missing endpoint")
  self~assertEquals("30", self~neighbors(graph, 10), "Missing endpoint: neighbours of 10 should stay 30")
  self~assertEquals("", self~neighbors(graph, 30), "Missing endpoint: neighbours of 30 should be empty")
  self~assertEquals(0, graph~has_edge(10, 99), "Missing endpoint: has_edge 10 99 should fail")
  self~assertEquals(0, graph~has_edge(99, 10), "Missing endpoint: has_edge 99 10 should fail")
  self~assertEquals(0, graph~has_edge(98, 99), "Missing endpoint: has_edge 98 99 should fail")
  self~assertEquals(0, graph~has_edge(99, 99), "Missing endpoint: has_edge 99 99 should fail")
  self~assertEquals(.Nil, graph~get_neighbors(98), "Missing endpoint: get_neighbors 98 should fail")
  self~assertEquals(.Nil, graph~get_neighbors(99), "Missing endpoint: get_neighbors 99 should fail")

::method testGraphSortedNeighboursAndCounts
  graph = self~graphWith("10 30 50 70")
  self~assertEquals(1, graph~add_edge(10, 70), "Sorted neighbours: add_edge 10 70 should succeed")
  self~assertEquals(1, graph~add_edge(10, 30), "Sorted neighbours: add_edge 10 30 should succeed")
  self~assertEquals(1, graph~add_edge(10, 50), "Sorted neighbours: add_edge 10 50 should succeed")
  self~assertEquals(1, graph~add_edge(30, 50), "Sorted neighbours: add_edge 30 50 should succeed")
  self~assertEquals("30 50 70", self~neighbors(graph, 10), "Sorted neighbours: neighbours of 10 should be 30 50 70")
  self~assertEquals("50", self~neighbors(graph, 30), "Sorted neighbours: neighbours of 30 should be 50")
  self~assertEquals("", self~neighbors(graph, 50), "Sorted neighbours: neighbours of 50 should be empty")
  self~assertEquals("", self~neighbors(graph, 70), "Sorted neighbours: neighbours of 70 should be empty")
  self~assertCounts(graph, 4, 4, "Sorted neighbours")

::method testGraphMissingEdgeQuery
  graph = self~graphWith("10 30")
  self~assertEquals(0, graph~has_edge(10, 30), "Missing-edge query: has_edge 10 30 should fail")
  self~assertCounts(graph, 2, 0, "Missing-edge query")
  self~assertEquals(0, graph~is_empty(), "Missing-edge query: is_empty should be 0")

::method testGraphNeighboursOfMissingVertex
  graph = .Graph~new
  self~assertEquals(1, graph~add_vertex(10), "Neighbours of missing vertex: add_vertex 10 should succeed")
  self~assertEquals(.Nil, graph~get_neighbors(99), "Neighbours of missing vertex: get_neighbors 99 should fail")
  self~assertEquals("", self~neighbors(graph, 10), "Neighbours of missing vertex: neighbours of 10 should be empty, not absent")
  self~assertCounts(graph, 1, 0, "Neighbours of missing vertex")

::method testGraphSelfLoopAndDuplicate
  graph = .Graph~new
  self~assertEquals(1, graph~add_vertex(10), "Self-loop: add_vertex 10 should succeed")
  self~assertEquals(1, graph~add_edge(10, 10), "Self-loop: first add_edge 10 10 should succeed")
  self~assertEquals(1, graph~add_edge(10, 10), "Self-loop: second add_edge 10 10 should succeed")
  self~assertEquals(1, graph~has_edge(10, 10), "Self-loop: has_edge 10 10 should succeed")
  self~assertEquals("10", self~neighbors(graph, 10), "Self-loop: neighbours of 10 should be 10")
  self~assertCounts(graph, 1, 1, "Self-loop")
