# Data Structures Basics — REXX

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **REXX** (Open Object Rexx), con **ooRexxUnit** como framework de pruebas unitarias.

El módulo implementa una celda enlazada compartida `Node` y tres estructuras de datos construidas manualmente sobre ella: `LinkedList`, `Stack` (LIFO) y `Queue` (FIFO). Cada ADT gestiona directamente sus punteros sin delegar en `LinkedList` ni en colecciones de la biblioteca estándar de ooRexx.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.rexx`](src/data_structures_basics.rexx) | Módulo fuente: cuatro clases públicas (`Node`, `LinkedList`, `Stack`, `Queue`) en un solo archivo. / Source module: four public classes in a single file. |
| [`test/data_structures_basics_tests.rexx`](test/data_structures_basics_tests.rexx) | Suite de pruebas unitarias con ooRexxUnit: 23 métodos de prueba y 106 aserciones. / Unit test suite using ooRexxUnit: 23 test methods and 106 assertions. |
| [`.gitignore`](.gitignore) | Archivos generados excluidos. / Ignored generated files. |
| [`README.md`](README.md) | Documentación de Nivel 3 del módulo. / Level 3 module documentation. |

**Estructura de directorios esperada / Expected directory structure:**

```text
data_structures_basics/
├── src/
│   └── data_structures_basics.rexx
├── test/
│   └── data_structures_basics_tests.rexx
├── .gitignore
└── README.md
```

> **ES:** La especificación propone `test/data_structures_basics_test.ext` y `test/run_tests.ext`. En este proyecto se usa el patrón homologado de ooRexx: `test/data_structures_basics_tests.rexx` ejecuta directamente su runner ooRexxUnit (`.TestSuite~new(... )~execute`), prescindiendo de un script `run_tests` separado.
> **EN:** The specification suggests `test/data_structures_basics_test.ext` and `test/run_tests.ext`. This project follows the homologated ooRexx pattern: `test/data_structures_basics_tests.rexx` directly invokes its ooRexxUnit runner (`.TestSuite~new(... )~execute`), eliminating the need for a separate `run_tests` script.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este módulo se construye de forma minimalista en un único archivo de código (`src/data_structures_basics.rexx`) que declara cuatro clases públicas mediante `::class ... public`. Cada estructura administra directamente sus propios atributos (`::attribute`) y punteros (`head`/`tail`, `top`, `front`/`rear`), así como su contador de elementos (`count`), reutilizando únicamente la celda `Node`.

**EN:** This module is built minimalistically in a single source file (`src/data_structures_basics.rexx`) declaring four public classes via `::class ... public`. Each structure directly manages its own attributes (`::attribute`) and pointers (`head`/`tail`, `top`, `front`/`rear`) along with its element counter (`count`), reusing only the `Node` cell.

### Inicialización / Initialization

```bash
mkdir -p rexx/core/algorithms/data_structures_basics/{src,test}
```

No se requieren herramientas de compilación externas ni gestores de paquetes; ooRexx interpreta los archivos `.rexx` directamente y resuelve dependencias mediante directivas `::requires`.

---

## 📄 Configuración clave / Key Configuration

No se requieren archivos de build ni manifiestos (`Makefile`, `package.json`, etc.). Las dependencias se gestionan mediante:

- `::requires "OOREXXUNIT.CLS"`: cargado vía `REXX_PATH` desde `~/.rexx/oorexxunit/`.
- `::requires "src/data_structures_basics.rexx"`: importación directa del módulo bajo prueba.

El archivo `.gitignore` ignora artefactos temporales y volcados del entorno de ejecución.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Open Object Rexx** (`rexx` / `rexxc` v5.2.0 o compatible).
- **ooRexxUnit** instalado por usuario (`REXX_PATH`), ver [`rexx/README.md`](../../../README.md).

```bash
# Verificación estática de sintaxis / Static syntax check
rexxc src/data_structures_basics.rexx -s
rexxc test/data_structures_basics_tests.rexx -s

# Ejecución de pruebas / Run tests
rexx test/data_structures_basics_tests.rexx
```

**Salida real / Actual output:**

```text
nr of test runs:             23
nr of successful assertions: 106
nr of failures:              0
nr of errors:                0
```

> **ES:** 23 test runs corresponden a los 23 métodos de prueba de `DataStructuresBasicsTest` (3 para `Node`, 7 para `LinkedList`, 6 para `Stack`, 7 para `Queue`), acumulando 106 aserciones exitosas sobre las secuencias de operaciones.
> **EN:** 23 test runs correspond to the 23 test methods in `DataStructuresBasicsTest` (3 for `Node`, 7 for `LinkedList`, 6 for `Stack`, 7 for `Queue`), totaling 106 successful assertions over the operation sequences.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.init(value)` | `Integer → ()` | $O(1)$ | Constructor: asigna `value` y establece `next` como `.Nil`. / Sets `value` and leaves `next` as `.Nil`. |
| `Node.get_value()` | `() → Integer` | $O(1)$ | Devuelve el valor almacenado. / Returns stored value. |
| `Node.get_next()` | `() → Node / .Nil` | $O(1)$ | Devuelve el siguiente nodo o `.Nil`. / Returns next node or `.Nil`. |
| `Node.set_next(next)` | `(Node / .Nil) → ()` | $O(1)$ | Actualiza la referencia al siguiente nodo. / Updates reference to next node. |
| `LinkedList.init()` | `() → ()` | $O(1)$ | Inicializa `head` y `tail` a `.Nil`, y `count` a `0`. / Sets `head` and `tail` to `.Nil`, `count` to `0`. |
| `LinkedList.is_empty()` | `() → Boolean` | $O(1)$ | Retorna `1` si `count == 0`, `0` en caso contrario. / Returns `1` if `count == 0`, `0` otherwise. |
| `LinkedList.size()` | `() → Integer` | $O(1)$ | Retorna el número de elementos (`count`). / Returns number of elements (`count`). |
| `LinkedList.get_head()` | `() → Integer` | $O(1)$ | Valor de la cabeza o `-1` si la lista está vacía. / Head value or `-1` if empty. |
| `LinkedList.insert_head(value)` | `Integer → ()` | $O(1)$ | Inserta nodo en la cabeza; actualiza `tail` si estaba vacía; `count + 1`. / Inserts node at head; updates `tail` if empty; `count + 1`. |
| `LinkedList.insert_tail(value)` | `Integer → ()` | $O(1)$ | Inserta nodo en la cola; enlaza `tail` previa; `count + 1`. / Inserts node at tail; links previous `tail`; `count + 1`. |
| `LinkedList.delete(value)` | `Integer → Boolean` | $O(n)$ | Elimina la primera ocurrencia linealmente y decrementa `count`; retorna `1` o `0`. / Deletes first occurrence linearly and decrements `count`; returns `1` or `0`. |
| `Stack.init()` | `() → ()` | $O(1)$ | Inicializa `top` a `.Nil` y `count` a `0`. / Sets `top` to `.Nil` and `count` to `0`. |
| `Stack.is_empty()` | `() → Boolean` | $O(1)$ | Retorna `1` si `count == 0`, `0` en caso contrario. / Returns `1` if `count == 0`, `0` otherwise. |
| `Stack.size()` | `() → Integer` | $O(1)$ | Retorna el número de elementos (`count`). / Returns number of elements (`count`). |
| `Stack.push(value)` | `Integer → ()` | $O(1)$ | Inserta nodo sobre `top` e incrementa `count`. / Pushes node onto `top` and increments `count`. |
| `Stack.pop()` | `() → Integer` | $O(1)$ | Extrae y retorna el valor de `top`; decrementa `count`; `-1` si está vacía. / Pops and returns `top` value; decrements `count`; `-1` if empty. |
| `Stack.peek()` | `() → Integer` | $O(1)$ | Observa el valor de `top` sin mutar; `-1` si está vacía. / Observes `top` value without mutating; `-1` if empty. |
| `Queue.init()` | `() → ()` | $O(1)$ | Inicializa `front` y `rear` a `.Nil` y `count` a `0`. / Sets `front` and `rear` to `.Nil` and `count` to `0`. |
| `Queue.is_empty()` | `() → Boolean` | $O(1)$ | Retorna `1` si `count == 0`, `0` en caso contrario. / Returns `1` if `count == 0`, `0` otherwise. |
| `Queue.size()` | `() → Integer` | $O(1)$ | Retorna el número de elementos (`count`). / Returns number of elements (`count`). |
| `Queue.enqueue(value)` | `Integer → ()` | $O(1)$ | Inserta nodo tras `rear`; actualiza `front` si estaba vacía; `count + 1`. / Enqueues node after `rear`; updates `front` if empty; `count + 1`. |
| `Queue.dequeue()` | `() → Integer` | $O(1)$ | Extrae y retorna el valor de `front`; limpia `rear` si se vacía; `-1` si está vacía. / Dequeues and returns `front` value; clears `rear` if empty; `-1` if empty. |
| `Queue.peek()` | `() → Integer` | $O(1)$ | Observa el valor de `front` sin mutar; `-1` si está vacía. / Observes `front` value without mutating; `-1` if empty. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clases públicas en un único archivo (`src/data_structures_basics.rexx`) | Separar una clase por archivo (`Node.rexx`, `LinkedList.rexx`, etc.) | Convención idiomática de ooRexx para módulos cohesivos; evita sobrecarga de directivas `::requires` cruzadas en fases tempranas. |
| Atributos de instancia explícitos con `::attribute` | Asignación dinámica en métodos (`self~var = val`) | En ooRexx, asignar a una variable no declarada mediante mensaje provoca `Error 97.1: Object does not understand message`. |
| Estructuras autónomas sin delegación | Componer o delegar `Stack` y `Queue` sobre `LinkedList` | La especificación prohíbe explícitamente envolver `LinkedList`. Cada ADT mantiene su propia lógica de punteros ($O(1)$ garantizado). |
| Indicadores de retorno escalares (`-1` y `1`/`0`) | Lanzar condiciones o excepciones con `raise` | Cumplimiento del contrato de la fase (sin excepciones) y compatibilidad con el sistema numérico simple de ooRexx. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node.init(value)`, `LinkedList.init()`, etc. | Método constructor `init` invocado automáticamente por `.Class~new(...)` | En ooRexx, el mensaje `~new` asigna el objeto y despacha automáticamente el método `init` con los argumentos recibidos. |
| Ausencia de enlace (`absent`) | `.Nil` | Representación nativa y singleton canónico de ooRexx para referencias nulas u objetos ausentes. |
| Valores booleanos de retorno (`delete`, `is_empty`) | `1` (verdadero) y `0` (falso) | ooRexx representa booleanos nativamente como enteros `1` y `0` en expresiones de control. |
| `tail == current` en `delete` | Comparación de enlace `current~get_next() == .Nil` para actualizar `tail = previous` | Si el nodo borrado era el último de la secuencia, la cola pasa a ser el nodo predecesor sin ambigüedad. |
| Layout `test/run_tests.ext` | `test/data_structures_basics_tests.rexx` ejecutable con `rexx` | ooRexxUnit ejecuta suites directamente al invocar el script de pruebas, homologado con `numbers` y `naive_sort`. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LinkedList.get_head()` | Lista vacía (`head == .Nil` / `count == 0`) | `-1` | `.LinkedList~new~get_head()` → `-1` |
| `LinkedList.delete(value)` | Elemento no encontrado en la lista | `0` | `list~delete(99)` → `0` |
| `Stack.pop()` | Pila vacía (`top == .Nil` / `count == 0`) | `-1` | `.Stack~new~pop()` → `-1` |
| `Stack.peek()` | Pila vacía (`top == .Nil` / `count == 0`) | `-1` | `.Stack~new~peek()` → `-1` |
| `Queue.dequeue()` | Cola vacía (`front == .Nil` / `count == 0`) | `-1` | `.Queue~new~dequeue()` → `-1` |
| `Queue.peek()` | Cola vacía (`front == .Nil` / `count == 0`) | `-1` | `.Queue~new~peek()` → `-1` |
| Entrada nula / ausente en operaciones | Operaciones con enteros positivos esperados | No representable | El contrato de la fase opera sobre dominio entero positivo; los indicadores enteros `-1` distinguen el fallo sin ambigüedad. |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `Node`: Inicializar y observar valor/enlace | Sí | `test/data_structures_basics_tests.rexx:25` (`testNodeGetValue`, `testNodeGetNext`) | Verifica constructor, observación de valor y enlace `.Nil` inicial. |
| `Node`: Inicializar otro nodo, enlazar y recorrer | Sí | `test/data_structures_basics_tests.rexx:33` (`testNodeSetNext`) | Verifica enlace con `set_next`, observación del valor referenciado y enlace ausente. |
| `LinkedList`: Estado vacío | Sí | `test/data_structures_basics_tests.rexx:43` (`testLinkedListInit`) | Verifica `size() == 0`, `is_empty() == 1`, `get_head() == -1`. |
| `LinkedList`: Insertar por ambos extremos | Sí | `test/data_structures_basics_tests.rexx:70` (`testLinkedListInsertTail`, `testLinkedListInsertHead`) | Secuencia combinada `insert_tail` e `insert_head`, verificación de cabeza y tamaño. |
| `LinkedList`: Eliminar primera aparición | Sí | `test/data_structures_basics_tests.rexx:83` (`testLinkedListDelete`) | Elimina cabeza, cola y elementos intermedios comprobando éxito (`1`) y tamaño. |
| `LinkedList`: Valor ausente | Sí | `test/data_structures_basics_tests.rexx:99` (`testLinkedListDelete`) | `delete(99)` devuelve `0` y preserva tamaño intacto. |
| `LinkedList`: Vaciar | Sí | `test/data_structures_basics_tests.rexx:101` (`testLinkedListDelete`) | Eliminaciones sucesivas hasta vaciar; verifica `is_empty() == 1`, `size() == 0`, `get_head() == -1`. |
| `Stack`: Estado vacío y extracción fallida | Sí | `test/data_structures_basics_tests.rexx:134` (`testStackInit`) | Verifica `size() == 0`, `is_empty() == 1`, `peek() == -1`, `pop() == -1`. |
| `Stack`: LIFO y `peek` no mutante | Sí | `test/data_structures_basics_tests.rexx:141` (`testStackPush`, `testStackPeek`) | `push(10, 20, 30)`, `peek()` devuelve `30` sin consumir elemento. |
| `Stack`: Extracción y reutilización | Sí | `test/data_structures_basics_tests.rexx:152` (`testStackPop`) | Extracciones LIFO sucesivas, inserción intermedia y vaciado total. |
| `Stack`: Vacío tras extracción | Sí | `test/data_structures_basics_tests.rexx:163` (`testStackPop`) | `pop()` sobre pila vaciada devuelve `-1` y preserva `is_empty() == 1`. |
| `Queue`: Estado vacío y extracción fallida | Sí | `test/data_structures_basics_tests.rexx:197` (`testQueueInit`) | Verifica `size() == 0`, `is_empty() == 1`, `peek() == -1`, `dequeue() == -1`. |
| `Queue`: FIFO y `peek` no mutante | Sí | `test/data_structures_basics_tests.rexx:204` (`testQueueEnqueue`, `testQueuePeek`) | `enqueue(10, 20, 30)`, `peek()` devuelve `10` sin alterar orden ni tamaño. |
| `Queue`: Extracción y reutilización | Sí | `test/data_structures_basics_tests.rexx:215` (`testQueueDequeue`) | Extracciones FIFO sucesivas, inserción intermedia y vaciado total. |
| `Queue`: Vacío tras extracción | Sí | `test/data_structures_basics_tests.rexx:226` (`testQueueDequeue`) | `dequeue()` sobre cola vaciada devuelve `-1` y preserva `is_empty() == 1`. |
| Casos con entrada nula / no enteros | Omitido | — | El contrato de Fase 1 opera sobre enteros positivos; ooRexx distingue el fallo con los centinelas `-1` y `0`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio restringido a enteros no negativos (`n >= 0`) | El centinela numérico `-1` colisionaría si se insertara `-1` como valor válido | Adecuado para la especificación de Fase 1 (Algoritmos Puros); en fases avanzadas se adoptarán tipos opcionales o polimórficos. |
| Estructuras no tipadas fuertemente | ooRexx es dinámico y no restringe el tipo de `value` en tiempo de compilación | El contrato y la suite garantizan coherencia operando sobre tipos numéricos enteros. |

---

## 📝 Notas de implementación / Implementation Notes

- **ooRexx Object Model**: Se define la jerarquía mediante directivas `::class` públicas. En ooRexx, los constructores corresponden al método `init`, el cual se invoca automáticamente al instanciar mediante `.Clase~new(...)`.
- **Atributos y encapsulamiento**: Cada atributo de instancia se declara con `::attribute`. En ooRexx, esto genera automáticamente los métodos accesores de lectura (`self~atributo`) y mutación (`self~atributo = valor`).
- **Control de flujo y bloques `do`/`end`**: En REXX, las ramas condicionales que ejecutan múltiples sentencias requieren bloques `do`/`end` explícitos. REXX no cierra sentencias `if` con `end`, lo que provocaría un error de sintaxis en tiempo de carga (`Error 10`).
- **Gestión de referencias**: La ausencia de enlace o referencia vacía se representa de forma canónica con el objeto singleton `.Nil`. La comparación de identidad se realiza con `==` y `\==`.
- **Centinelas de fallo**: Siguiendo las directrices de la Fase 1, no se lanzan excepciones (`raise`) ni se crean tipos envolventes artificiales: las operaciones de extracción u observación sobre vacío devuelven `-1`, y las operaciones booleanas devuelven `1` o `0`.
- **Independencia de estructuras**: `Stack` y `Queue` no envuelven ni heredan de `LinkedList`; gestionan sus propios punteros (`top`, `front`, `rear`) de manera directa e independiente sobre celdas `Node`, garantizando tiempo constante $O(1)$ en todas sus operaciones elementales.

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
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`rexx/core/foundations/numbers/`](../../foundations/numbers/README.md) |
| Módulo previo de algoritmos / Previous algorithm module | [`rexx/core/algorithms/naive_sort/`](../naive_sort/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial de ooRexx / Official ooRexx documentation | [Open Object Rexx Documentation](https://www.oorexx.org/docs/) |
