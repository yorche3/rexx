# Naive Sort — REXX

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **REXX** (Open Object Rexx), con **ooRexxUnit** como framework de pruebas unitarias.

Los tres algoritmos elementales de ordenamiento $O(n^2)$ — **selection sort**, **bubble sort** e **insertion sort** — trabajan **in-place** sobre un `.Array` de ooRexx, con comparaciones e intercambios paso a paso y sin bibliotecas de ordenamiento.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/naive_sort.rexx`](src/naive_sort.rexx) | Módulo `NaiveSort` — clase con los 3 métodos de clase del contrato. |
| [`test/naive_sort_tests.rexx`](test/naive_sort_tests.rexx) | Suite ooRexxUnit — 3 métodos de test y 1 helper compartido (8 casos cada uno). |

**Estructura de directorios / Directory structure:**

```text
naive_sort/
├── src/
│   └── naive_sort.rexx          # Módulo: 3 algoritmos
├── test/
│   └── naive_sort_tests.rexx    # Suite: 3 tests × 8 casos
└── README.md                    # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Estructura creada manualmente (`mkdir -p src test`), sin manifiesto ni configuración de build: ooRexx interpreta los `.rexx` directamente. El módulo es una clase `NaiveSort` con **métodos de clase** (se invocan sobre la clase, no sobre una instancia: `.NaiveSort~selection_sort(arr)`) y la suite es una subclase de `TestCase` con un método `test*` por algoritmo.

**EN:** Structure created by hand (`mkdir -p src test`), with no manifest or build configuration: ooRexx interprets `.rexx` files directly. The module is a `NaiveSort` class with **class methods** (invoked on the class, not on an instance: `.NaiveSort~selection_sort(arr)`) and the suite is a `TestCase` subclass with one `test*` method per algorithm.

### Inicialización / Initialization

```bash
mkdir -p rexx/core/algorithms/naive_sort/{src,test}
# Escribir src/naive_sort.rexx y test/naive_sort_tests.rexx
# Requisito: OOREXXUNIT.CLS instalado (ver rexx/README.md)
```

---

## 📄 Contrato e implementación / Contract & Implementation

**ES:** El contrato recibe y devuelve un `.Array` de ooRexx. El orden es in-place: se modifican los elementos recibidos y se devuelve la referencia al mismo array. Si la entrada es `.Nil` se devuelve `.Nil` como indicador de fallo; si tiene menos de dos elementos (`n < 2`) se devuelve la entrada sin cambios. No se lanza ninguna excepción.

**EN:** The contract takes and returns an ooRexx `.Array`. Sorting is in-place: the received elements are modified and the reference to the same array is returned. A `.Nil` input returns `.Nil` as the failure indicator; inputs with fewer than two elements (`n < 2`) are returned unchanged. No exception is thrown.

```rexx
::class NaiveSort public

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
```

| Elemento del contrato | Representación en ooRexx |
| --------------------- | ------------------------ |
| Array de enteros | `.array~of(5, 2, 9, 1, 5, 6)` (índices 1-based) |
| Caso nulo | `.Nil` (indicador de fallo) |
| Array vacío | `.array~new` (`~items` = 0) |
| Orden | in-place, devuelve la misma referencia |
| Nombres de la especificación | `selection_sort`, `bubble_sort`, `insertion_sort` (snake_case, idénticos a la especificación) |

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Open Object Rexx** (`rexx`).
- **ooRexxUnit** instalado por usuario (`REXX_PATH`), ver [`rexx/README.md`](../../../README.md).

```bash
rexx -v
```

### Ejecutar las pruebas / Run tests

```bash
cd rexx/core/algorithms/naive_sort
rexx test/naive_sort_tests.rexx
```

**Salida real / Actual output:**

```text
nr of test runs:             4
nr of successful assertions: 24
nr of failures:              0
nr of errors:                0
```

> **ES:** 4 test runs = 3 métodos de test + la suite; 24 aserciones = 3 algoritmos × 8 casos (7 del pseudocódigo + el caso nulo). El intérprete devuelve código de salida 0 aunque haya fallos, así que el resultado se lee en el resumen (`nr of failures` / `nr of errors`) y en las líneas `[failure]` / `[error]`.
> **EN:** 4 test runs = 3 test methods + the suite; 24 assertions = 3 algorithms × 8 cases (7 from the pseudocode + the null case). The interpreter exits with code 0 even on failures, so the result is read from the summary (`nr of failures` / `nr of errors`) and the `[failure]` / `[error]` lines.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función / Algorithm | Enfoque / Approach | Descripción / Description |
| ------------------- | ------------------ | ------------------------- |
| `selection_sort(arr)` | iterativo, in-place | Busca el mínimo del tramo no ordenado con `min_index` y lo intercambia al inicio. $O(n^2)$ siempre. |
| `bubble_sort(arr)` | iterativo, in-place, con bandera | Compara adyacentes e intercambia; sale antes con `leave` cuando `swapped` es `.false`. $O(n^2)$ peor/promedio, $O(n)$ mejor. |
| `insertion_sort(arr)` | iterativo, in-place | Guarda `key`, desplaza el sub-array ordenado y lo inserta en su posición. $O(n^2)$ peor/promedio, $O(n)$ mejor. |

**Suite de pruebas / Test suite:** cada método de test delega en el helper compartido `assertSortsAllCases(methodName, algorithm)`, que recorre la tabla de casos y construye un `.Array` nuevo por caso (el orden es in-place). El mensaje de cada aserción sigue el contrato: `"{algorithm} should sort {case}"`.

| Caso (descripción en la suite) | Entrada | Salida esperada |
| ------------------------------ | ------- | --------------- |
| an unsorted array | `5 2 9 1 5 6` | `1 2 5 5 6 9` |
| an already sorted array | `1 2 3 4 5` | `1 2 3 4 5` |
| a reverse ordered array | `5 4 3 2 1` | `1 2 3 4 5` |
| an array of identical elements | `7 7 7 7` | `7 7 7 7` |
| an array with negative numbers | `3 -1 4 -5 0` | `-5 -1 0 3 4` |
| a single element array | `42` | `42` |
| an empty array | (vacío) | (vacío) |
| a null input | `.Nil` | `.Nil` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** La asignación por índice en un `.Array` no existe como `arr~at(i) = v` (`Error 97.1: does not understand message "AT="`): se escribe con la forma de corchetes `arr[i] = v`, que delega en `put`. La lectura sí es `arr~at(i)`.
- **EN:** Indexed assignment on an `.Array` does not exist as `arr~at(i) = v` (`Error 97.1: does not understand message "AT="`): it is written with the bracket form `arr[i] = v`, which delegates to `put`. Reading stays as `arr~at(i)`.
- **ES:** En `insertion_sort` el `while` del pseudocódigo se traduce a `do while j > 0` con `if arr~at(j) <= key then leave`: REXX evalúa **ambos** operandos de `&` (no hay cortocircuito), así que la condición compuesta `j > 0 & arr~at(j) > key` provocaba `Error 93.907` al evaluar `arr~at(0)`.
- **EN:** In `insertion_sort` the pseudocode `while` becomes `do while j > 0` with `if arr~at(j) <= key then leave`: REXX evaluates **both** operands of `&` (there is no short-circuit), so the compound condition `j > 0 & arr~at(j) > key` raised `Error 93.907` when evaluating `arr~at(0)`.
- **ES:** El cuerpo de un `::method` es una rutina que termina en `return`: no lleva un `end` final, y cada bloque `if ... then do` necesita su `do` explícito. Un `end` de más produce `Error 10: Unexpected or unmatched END` al **cargar** el módulo, no al ejecutarlo.
- **EN:** A `::method` body is a routine closed by `return`: it takes no trailing `end`, and every `if ... then do` block needs its explicit `do`. A surplus `end` raises `Error 10: Unexpected or unmatched END` when the module is **loaded**, not when it runs.
- **ES:** Una instancia **no** alcanza los métodos de clase con `self~metodo` (`Error 97.1: Object "an X" does not understand message`): por eso los ayudantes de la suite (`buildArray`, `asText`) son métodos de instancia, mientras que las constantes de los casos son métodos de clase invocados desde otro método de clase (`cases`).
- **EN:** An instance does **not** reach class methods via `self~method` (`Error 97.1: Object "an X" does not understand message`): that is why the suite helpers (`buildArray`, `asText`) are instance methods, while the case constants are class methods invoked from another class method (`cases`).
- **ES:** `.Array` no se compara por contenido con `=` (compara identidad: dos arrays iguales dan `0`), así que la suite normaliza entradas y salidas a texto con un blanco entre elementos antes de `assertEquals`; `.Nil` se conserva como indicador y se compara por identidad (`1`).
- **EN:** `.Array` is not compared by content with `=` (it compares identity: two equal arrays yield `0`), so the suite normalizes inputs and outputs to blank-separated text before `assertEquals`; `.Nil` is kept as the indicator and compared by identity (`1`).
- **ES:** Los bucles `do i = 1 to 0` (o `to n - 1` con `n = 1`) no iteran en REXX: el caso de un solo elemento y el array vacío salen por la guarda `n < 2`. La comparación de los elementos es numérica porque los tokens son numéricos.
- **EN:** `do i = 1 to 0` loops (or `to n - 1` with `n = 1`) do not iterate in REXX: the single-element and empty-array cases exit through the `n < 2` guard. Element comparison is numeric because the tokens are numeric.
- **ES:** No hay analizador estático en ooRexx: `rexxc` no reporta estos errores (solo imprime el banner y sale con 0). La verificación real es cargar el módulo ejecutando la suite desde la raíz del proyecto, porque los `::requires` relativos resuelven contra el directorio de trabajo.
- **EN:** There is no static analyzer in ooRexx: `rexxc` does not report these errors (it just prints the banner and exits with 0). The real check is loading the module by running the suite from the project root, because relative `::requires` resolve against the working directory.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Algoritmos Puros](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
