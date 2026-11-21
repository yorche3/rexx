# Data Structures Advanced — REXX

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **REXX** (Open Object Rexx), con **ooRexxUnit** como framework de pruebas unitarias.

El módulo implementa un nodo base portador de valor (`Node`) y dos estructuras de datos avanzadas: un Árbol Binario de Búsqueda (`BinaryTree`) construido sobre `TreeNode` (enlaces izquierdo y derecho), y un Grafo Dirigido (`Graph`) con registro enlazado canónico de vértices (`GraphNode`) y secuencias ordenadas de adyacencia gestionadas manualmente.

**ES:** Implementación orientada a objetos en ooRexx con manipulación explícita de punteros y referencias enlazadas, sin recurrir a mapas, diccionarios ni colecciones complejas para el registro de vértices o la lógica de adyacencia.

**EN:** Object-oriented implementation in ooRexx featuring explicit pointer and linked-reference manipulation, without relying on maps, dictionaries, or complex collections for vertex registration or adjacency logic.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_advanced.rexx`](src/data_structures_advanced.rexx) | Módulo fuente: cinco clases (`Node`, `TreeNode`, `BinaryTree`, `GraphNode`, `Graph`) en un único archivo. / Source module: five classes in a single file. |
| [`test/data_structures_advanced_tests.rexx`](test/data_structures_advanced_tests.rexx) | Suite de pruebas unitarias con ooRexxUnit: 23 métodos de prueba (24 test runs en la suite) y 156 aserciones. / Unit test suite using ooRexxUnit: 23 test methods (24 test runs in the suite) and 156 assertions. |
| [`.gitignore`](.gitignore) | Archivos generados excluidos. / Ignored generated files. |
| [`README.md`](README.md) | Documentación de Nivel 3 del módulo. / Level 3 module documentation. |

**Estructura de directorios esperada / Expected directory structure:**

```text
data_structures_advanced/
├── src/
│   └── data_structures_advanced.rexx
├── test/
│   └── data_structures_advanced_tests.rexx
├── .gitignore
└── README.md
```

> **ES:** La especificación propone `test/data_structures_advanced_test.ext` y `test/run_tests.ext`. En este proyecto se sigue el patrón homologado de ooRexx (`data_structures_basics`, `numbers`): `test/data_structures_advanced_tests.rexx` ejecuta directamente su runner ooRexxUnit (`.TestSuite~new(... )~execute`), prescindiendo de un script `run_tests` separado.
> **EN:** The specification suggests `test/data_structures_advanced_test.ext` and `test/run_tests.ext`. This project follows the homologated ooRexx pattern (`data_structures_basics`, `numbers`): `test/data_structures_advanced_tests.rexx` directly invokes its ooRexxUnit runner (`.TestSuite~new(... )~execute`), eliminating the need for a separate `run_tests` script.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El módulo se implementa de forma manual y minimalista en un único archivo fuente (`src/data_structures_advanced.rexx`):
1. **Base con valor**: `Node` actúa como clase base local que porta exclusivamente el atributo `value` y el método `get_value`, sin validaciones ni enlaces.
2. **Nodos derivados por herencia**: `TreeNode` y `GraphNode` heredan de `Node` mediante `subclass Node`. `TreeNode` añade los enlaces `left` y `right` hacia otros nodos o `.Nil`. `GraphNode` almacena la etiqueta (`label`) heredada en `value`, una lista interna `neighbors` para sus adyacencias y un puntero `next_vertex` para el registro canónico.
3. **Árbol Binario de Búsqueda (`BinaryTree`)**: Estructura no acotada sin capacidad máxima prefijada. La inserción y la búsqueda siguen la invariante del ABB en tiempo $O(h)$. Los duplicados en inserción tienen éxito idempotente sin incrementar el contador.
4. **Grafo Dirigido (`Graph`)**: Mantiene un registro enlazado canónico de vértices propio (`vertices` enlazado mediante `next_vertex`), con búsqueda lineal manual `find_vertex` en tiempo $O(V)$. La adyacencia utiliza la clase `.List` de la biblioteca estándar de ooRexx exclusivamente como contenedor de vecinos, implementando manualmente la comprobación de duplicados y la inserción ordenada ascendente en tiempo $O(d(u))$.

**EN:** The module is implemented manually and minimalistically in a single source file (`src/data_structures_advanced.rexx`):
1. **Value base**: `Node` acts as a local base class holding exclusively the `value` attribute and `get_value` method, without validations or links.
2. **Derived nodes via inheritance**: `TreeNode` and `GraphNode` inherit from `Node` via `subclass Node`. `TreeNode` adds `left` and `right` links pointing to other nodes or `.Nil`. `GraphNode` stores the inherited label in `value`, an internal `neighbors` list for its adjacencies, and a `next_vertex` pointer for the canonical registry.
3. **Binary Search Tree (`BinaryTree`)**: Unbounded structure without a contractual maximum capacity. Insertion and lookup follow the BST invariant in $O(h)$ time. Duplicate insertions succeed idempotently without incrementing the counter.
4. **Directed Graph (`Graph`)**: Maintains its own canonical linked vertex registry (`vertices` linked via `next_vertex`), with manual linear lookup `find_vertex` in $O(V)$ time. Adjacency uses ooRexx standard library's `.List` solely as neighbour storage, manually implementing duplicate checking and ascending sorted insertion in $O(d(u))$ time.

### Inicialización / Initialization

```bash
mkdir -p rexx/core/algorithms/data_structures_advanced/{src,test}
```

No se requieren herramientas de compilación externas ni gestores de paquetes; el runtime de ooRexx interpreta directamente los archivos `.rexx` resolviendo dependencias mediante `::requires`.

---

## 📄 Configuración clave / Key Configuration

No se requieren archivos de build externos ni manifiestos (`Makefile`, `package.json`, etc.). Las dependencias se resuelven en tiempo de ejecución:

- `::requires "OOREXXUNIT.CLS"`: cargado vía `REXX_PATH` desde `~/.rexx/oorexxunit/`.
- `::requires "src/data_structures_advanced.rexx"`: importación directa del módulo bajo prueba respecto al directorio de trabajo.

El archivo `.gitignore` excluye artefactos generados y volcados de depuración.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Open Object Rexx** (`rexx` / `rexxc` v5.2.0 o compatible).
- **ooRexxUnit** instalado por usuario (`REXX_PATH`), ver [`rexx/README.md`](../../../README.md).

```bash
# Verificación estática de sintaxis / Static syntax check
rexxc src/data_structures_advanced.rexx -s
rexxc test/data_structures_advanced_tests.rexx -s

# Ejecución de pruebas / Run tests
rexx test/data_structures_advanced_tests.rexx
```

**Salida real / Actual output:**

```text
nr of test runs:             24
nr of successful assertions: 156
nr of failures:              0
nr of errors:                0
```

> **ES:** 24 test runs corresponden a los 23 métodos de prueba de `DataStructuresAdvancedTest` (5 para `TreeNode`, 7 para `BinaryTree`, 11 para `Graph`) más la ejecución del objeto agregador de la suite en ooRexxUnit, acumulando 156 aserciones exitosas.
> **EN:** 24 test runs correspond to the 23 test methods in `DataStructuresAdvancedTest` (5 for `TreeNode`, 7 for `BinaryTree`, 11 for `Graph`) plus the suite aggregator execution in ooRexxUnit, totaling 156 successful assertions.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.init(value)` | `Integer → ()` | $O(1)$ | Constructor base: almacena `value`. / Base constructor: stores `value`. |
| `Node.get_value()` | `() → Integer` | $O(1)$ | Devuelve el valor almacenado. / Returns stored value. |
| `TreeNode.init(value)` | `Integer → ()` | $O(1)$ | Constructor derivado: hereda `value`, inicializa `left` y `right` a `.Nil`. / Derived constructor: inherits `value`, sets `left` and `right` to `.Nil`. |
| `TreeNode.get_left()` | `() → TreeNode / .Nil` | $O(1)$ | Devuelve el subárbol izquierdo o `.Nil`. / Returns left subtree or `.Nil`. |
| `TreeNode.get_right()` | `() → TreeNode / .Nil` | $O(1)$ | Devuelve el subárbol derecho o `.Nil`. / Returns right subtree or `.Nil`. |
| `TreeNode.set_left(node)` | `(TreeNode / .Nil) → TreeNode` | $O(1)$ | Actualiza el hijo izquierdo y retorna el receptor `self`. / Updates left child and returns receptor `self`. |
| `TreeNode.set_right(node)` | `(TreeNode / .Nil) → TreeNode` | $O(1)$ | Actualiza el hijo derecho y retorna el receptor `self`. / Updates right child and returns receptor `self`. |
| `BinaryTree.init()` | `() → ()` | $O(1)$ | Inicializa `root` a `.Nil` y `count` a `0`. / Initializes `root` to `.Nil` and `count` to `0`. |
| `BinaryTree.is_empty()` | `() → Boolean` | $O(1)$ | Retorna `1` si `count == 0`, `0` en caso contrario. / Returns `1` if `count == 0`, `0` otherwise. |
| `BinaryTree.size()` | `() → Integer` | $O(1)$ | Retorna el número de nodos (`count`). / Returns number of nodes (`count`). |
| `BinaryTree.insert(value)` | `Integer → Boolean` | $O(h)$ | Inserta según invariante ABB; duplicado es éxito sin incrementar tamaño; retorna `1`. / BST insertion; duplicate succeeds without incrementing count; returns `1`. |
| `BinaryTree.contains(value)` | `Integer → Boolean` | $O(h)$ | Búsqueda binaria en ABB; retorna `1` si se encuentra, `0` si no. / BST lookup; returns `1` if found, `0` otherwise. |
| `GraphNode.init(label)` | `Integer → ()` | $O(1)$ | Constructor derivado interno: almacena `label` en `value`, crea `.List` de vecinos y `next_vertex = .Nil`. / Internal constructor: stores `label`, creates neighbors `.List` and `next_vertex = .Nil`. |
| `Graph.init()` | `() → ()` | $O(1)$ | Inicializa `vertices` a `.Nil`, `vertex_total` a `0` y `edges` a `0`. / Sets `vertices` to `.Nil`, `vertex_total` to `0` and `edges` to `0`. |
| `Graph.is_empty()` | `() → Boolean` | $O(1)$ | Retorna `1` si `vertex_total == 0`, `0` en caso contrario. / Returns `1` if `vertex_total == 0`, `0` otherwise. |
| `Graph.vertex_count()` | `() → Integer` | $O(1)$ | Retorna el total de vértices registrados. / Returns total registered vertices. |
| `Graph.edge_count()` | `() → Integer` | $O(1)$ | Retorna el total de aristas dirigidas. / Returns total directed edges. |
| `Graph.find_vertex(label)` | `Integer → GraphNode / .Nil` | $O(V)$ | Helper interno: recorrido lineal del registro enlazado de vértices. / Internal helper: linear traversal of linked vertex registry. |
| `Graph.add_vertex(label)` | `Integer → Boolean` | $O(V)$ | Registra nuevo vértice al frente; duplicado es éxito sin mutar; retorna `1`. / Prepends new vertex; duplicate succeeds without mutating; returns `1`. |
| `Graph.add_edge(u, v)` | `(Integer, Integer) → Boolean` | $O(V + d(u))$ | Verifica existencia de extremos e inserta $v$ ordenado en vecinos; bucles y duplicados permitidos; retorna `1`, o `0` si falta extremo. / Checks endpoints and inserts $v$ sorted; loops and duplicates allowed; returns `1`, or `0` on missing endpoint. |
| `Graph.has_edge(u, v)` | `(Integer, Integer) → Boolean` | $O(V + d(u))$ | Verifica existencia de la arista dirigida $(u, v)$; retorna `1` o `0`. / Checks directed edge $(u, v)$; returns `1` or `0`. |
| `Graph.get_neighbors(u)` | `Integer → .List / .Nil` | $O(V + d(u))$ | Retorna copia independiente de la secuencia ordenada de vecinos, o `.Nil` si $u$ no existe. / Returns independent copy of sorted neighbors, or `.Nil` if $u$ is absent. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Herencia nativa mediante `subclass Node` para `TreeNode` y `GraphNode` | Composición con valor embebido | ooRexx soporta herencia de clases directamente; `TreeNode` y `GraphNode` heredan de forma transparente el atributo `value` y el método `get_value()`. |
| Registro canónico de vértices enlazado manualmente (`next_vertex`) | Diccionarios o tablas hash (`Directory`, `Table` de ooRexx) | La especificación exige explícitamente una implementación manual del registro de vértices sin delegar en índices optimizados de biblioteca, garantizando la complejidad $O(V)$. |
| Almacenamiento de vecinos en `.List` con inserción ordenada manual | Colección propia `NeighborNode` o delegación en ordenación de biblioteca | La especificación autoriza expresamente `LinkedList<T>` de la biblioteca estándar como almacenamiento de vecinos, requiriendo que la búsqueda e inserción ordenada se escriban a mano en $O(d(u))$. |
| Aislamiento de adyacencia mediante copia explícita en `get_neighbors` | Retornar referencia directa a la lista interna `neighbors` | Garantiza la invariante de aislamiento: modificar la copia devuelta o agregar aristas posteriores no muta ni invalida resultados previos. |
| `set_left` y `set_right` retornan el receptor `self` | Retornar nada (`return`) | Se alinea fielmente con el pseudocódigo (`return this`), facilitando el encadenamiento fluido de configuraciones de árbol. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Constructores `init(...)` retornando `this` | Método `init` llamado automáticamente por `.Class~new(...)` | En ooRexx, el mensaje `~new` instancia el objeto y despacha automáticamente `init`, retornando la nueva instancia creada. |
| Representación de ausencia (`absent`) | Objeto canónico `.Nil` | Singleton nativo de ooRexx para enlaces vacíos (`left`, `right`, `next_vertex`) y fallo en `get_neighbors` para vértices inexistentes. |
| Indicadores booleanos (`insert`, `contains`, `add_vertex`, `add_edge`, `has_edge`, `is_empty`) | Enteros `1` (verdadero) y `0` (falso) | ooRexx representa booleanos nativamente mediante los escalares enteros `1` y `0`. |
| Caso condicional "Adaptación inmutable" de `TreeNode` | Omitido | `TreeNode` en ooRexx es mutable; `set_left` y `set_right` mutan los atributos de la instancia y retornan `self`, por lo que el caso para tipos inmutables no aplica. |
| Layout `test/run_tests.ext` | `test/data_structures_advanced_tests.rexx` ejecutable con `rexx` | ooRexxUnit ejecuta suites directamente al invocar el script de pruebas, homologado con `numbers` y `data_structures_basics`. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `BinaryTree.contains(value)` | Valor no encontrado en el árbol | `0` | `tree~contains(99)` → `0` |
| `Graph.add_edge(u, v)` | Vértice origen $u$ o destino $v$ inexistente | `0` | `graph~add_edge(10, 99)` → `0` (no muta contadores) |
| `Graph.has_edge(u, v)` | Arista ausente o extremos inexistentes | `0` | `graph~has_edge(10, 30)` → `0` |
| `Graph.get_neighbors(u)` | Vértice $u$ inexistente en el grafo | `.Nil` | `graph~get_neighbors(99)` → `.Nil` (distinto de `.List~new` vacío) |
| `TreeNode.get_left()` / `get_right()` | Enlace ausente hacia subárbol | `.Nil` | `node~get_left()` → `.Nil` |
| Entrada nula o tipos no enteros | Dominio de algoritmos puros | No representable | El contrato de la fase opera sobre enteros positivos; los indicadores escalares `0` y `.Nil` diferencian el fallo sin ambigüedad. |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `TreeNode`: Crear un nodo de árbol | Sí | `test/data_structures_advanced_tests.rexx:75` (`testTreeNodeCreate`) | Inicializa con 10 y verifica `get_value() == 10`. |
| `TreeNode`: Enlaces iniciales ausentes | Sí | `test/data_structures_advanced_tests.rexx:79` (`testTreeNodeInitialLinksAbsent`) | Verifica que `get_left()` y `get_right()` retornen `.Nil`. |
| `TreeNode`: Enlazar dos hijos | Sí | `test/data_structures_advanced_tests.rexx:84` (`testTreeNodeLinkTwoChildren`) | Enlaza hijos 20 y 30; verifica sus valores desde el padre. |
| `TreeNode`: Recorrer cada enlace | Sí | `test/data_structures_advanced_tests.rexx:91` (`testTreeNodeTraverseEachLink`) | Recorre hacia hijos y verifica que sus propios enlaces sean `.Nil`. |
| `TreeNode`: Desenlazar hijos | Sí | `test/data_structures_advanced_tests.rexx:104` (`testTreeNodeUnlinkChildren`) | `set_left(.Nil)` y `set_right(.Nil)` preservan el valor 10 y limpian enlaces. |
| `TreeNode`: Adaptación inmutable | Omitido | — | En ooRexx `TreeNode` es mutable y sus setters devuelven el receptor; el caso inmutable no aplica. |
| `BinaryTree`: Crear vacío | Sí | `test/data_structures_advanced_tests.rexx:119` (`testBinaryTreeCreateEmpty`) | `is_empty() == 1`, `size() == 0`, `contains(50) == 0`. |
| `BinaryTree`: Insertar la raíz | Sí | `test/data_structures_advanced_tests.rexx:125` (`testBinaryTreeInsertRoot`) | Inserta 50; verifica tamaño 1, `is_empty() == 0` y `contains(50) == 1`. |
| `BinaryTree`: Insertar menor y mayor | Sí | `test/data_structures_advanced_tests.rexx:132` (`testBinaryTreeInsertLowerAndHigher`) | Inserta 50, 30, 70; verifica tamaño 3 y pertenencia de los tres. |
| `BinaryTree`: Ramas de varios niveles | Sí | `test/data_structures_advanced_tests.rexx:138` (`testBinaryTreeMultilevelBranches`) | Inserta 50, 30, 70, 20, 40; verifica tamaño 5 y pertenencia de todos. |
| `BinaryTree`: Valor ausente en árbol no vacío | Sí | `test/data_structures_advanced_tests.rexx:144` (`testBinaryTreeMissingValueNonEmpty`) | `contains(99) == 0` en árbol con 50; tamaño y presencia previa intactos. |
| `BinaryTree`: Duplicado idempotente | Sí | `test/data_structures_advanced_tests.rexx:151` (`testBinaryTreeIdempotentDuplicate`) | Inserta 50, 30, 70, 30; `size() == 3` y todos los elementos preservados. |
| `BinaryTree`: Inserciones ordenadas | Sí | `test/data_structures_advanced_tests.rexx:157` (`testBinaryTreeOrderedInsertions`) | Inserción monótona 20, 30, 40, 50, 70; tamaño 5 y `contains(99) == 0`. |
| `Graph`: Crear vacío | Sí | `test/data_structures_advanced_tests.rexx:166` (`testGraphCreateEmpty`) | `is_empty() == 1`, contadores en 0, `has_edge` y `get_neighbors` fallan. |
| `Graph`: Vértice aislado | Sí | `test/data_structures_advanced_tests.rexx:173` (`testGraphIsolatedVertex`) | Registra 10; no vacío, 1 vértice, 0 aristas, vecinos de 10 vacíos (""). |
| `Graph`: Etiquetas no consecutivas y arista dirigida | Sí | `test/data_structures_advanced_tests.rexx:180` (`testGraphNonconsecutiveLabelsDirectedEdge`) | Registra 10 y 70, arista dirigida; `has_edge(10, 70) == 1`, `has_edge(70, 10) == 0`. |
| `Graph`: Vértice duplicado conserva adyacencia | Sí | `test/data_structures_advanced_tests.rexx:187` (`testGraphDuplicateVertexPreservesAdjacency`) | `add_vertex(10)` repetido no duplica el vértice ni altera vecinos `[30]`. |
| `Graph`: Arista duplicada | Sí | `test/data_structures_advanced_tests.rexx:194` (`testGraphDuplicateEdge`) | `add_edge(10, 30)` repetido no duplica aristas ni altera contador (`edges == 1`). |
| `Graph`: Extremo inexistente sin mutación | Sí | `test/data_structures_advanced_tests.rexx:201` (`testGraphMissingEndpointWithoutMutation`) | Intentos de aristas con extremos faltantes retornan `0` sin mutar el grafo. |
| `Graph`: Vecinos ordenados y contadores | Sí | `test/data_structures_advanced_tests.rexx:218` (`testGraphSortedNeighboursAndCounts`) | Inserciones en desorden producen vecinos ordenados `30 50 70` en 10; 4 vértices, 4 aristas. |
| `Graph`: Consulta de arista ausente | Sí | `test/data_structures_advanced_tests.rexx:230` (`testGraphMissingEdgeQuery`) | `has_edge(10, 30) == 0` con vértices registrados pero sin arista; contadores intactos. |
| `Graph`: Vecinos de vértice inexistente | Sí | `test/data_structures_advanced_tests.rexx:236` (`testGraphNeighboursOfMissingVertex`) | `get_neighbors(99) == .Nil`, diferenciado de lista vacía en vértice 10. |
| `Graph`: Bucle y duplicado | Sí | `test/data_structures_advanced_tests.rexx:243` (`testGraphSelfLoopAndDuplicate`) | `add_edge(10, 10)` repetido; bucle admitido, vecinos `[10]`, 1 vértice, 1 arista. |
| `Graph`: Aislamiento del resultado de vecinos | Sí | `test/data_structures_advanced_tests.rexx:252` (`testGraphNeighbourResultIsolation`) | Modificar la lista devuelta o añadir aristas posteriores no afecta la consulta previa guardada. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio numérico entero | Valores tratados como escalares numéricos enteros | Conforme al alcance de Algoritmos Puros (Fase 1); tipos genéricos se introducen en fases posteriores. |
| Árbol binario sin balanceo automático | Inserciones estrictamente crecientes o decrecientes degradan la altura a $O(n)$ | Comportamiento esperado para la estructura BST canónica especificada; balanceo AVL o Red-Black corresponde a módulos avanzados. |
| Ausencia de comprobación estática de tipos | ooRexx es dinámico y no valida tipos de argumentos en tiempo de compilación | El contrato se garantiza mediante el diseño de la API y las aserciones de la suite de pruebas unitarias. |

---

## 📝 Notas de implementación / Implementation Notes

- **Modelo de objetos y herencia**: `Node` define la base que almacena `value`. `TreeNode` y `GraphNode` declaran `subclass Node`, heredando el atributo `value` y el método `get_value()`.
- **Árbol Binario de Búsqueda**: Implementa la inserción y búsqueda iterativas recorriendo punteros `left` y `right` con enlaces ausentes representados por `.Nil`. Los duplicados son tratados de forma idempotente, retornando éxito sin aumentar el tamaño del árbol.
- **Registro de vértices manual**: `Graph` gestiona sus vértices mediante un registro enlazado con `next_vertex`. Cada invocación a `find_vertex(label)` recorre linealmente este registro en tiempo $O(V)$, sin recurrir a estructuras indexadas ni tablas hash.
- **Adyacencia con `.List`**: Se utiliza `.List` exclusivamente como estructura física para los vecinos de cada vértice. La verificación de duplicados y la inserción ordenada se realizan manualmente recorriendo la lista elemento a elemento en tiempo $O(d(u))$.
- **Aislamiento en `get_neighbors`**: La operación construye una nueva instancia de `.List` copiando los vecinos existentes. Esto garantiza que las modificaciones posteriores al grafo o a la colección devuelta no violen la invariante de inmutabilidad del resultado devuelto.
- **Ausencia de excepciones**: Las condiciones de error o ausencia (vértice no encontrado, arista inexistente, enlace vacío) retornan `.Nil` o `0` según el contrato de la fase, sin lanzar excepciones ni interrumpir el flujo.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | [`rexx/core/algorithms/data_structures_basics/`](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | [`rexx/core/foundations/numbers/`](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial de ooRexx / Official ooRexx documentation | [Open Object Rexx Documentation](https://www.oorexx.org/docs/) |
