# Numbers — REXX

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **REXX** (Open Object Rexx), con **ooRexxUnit** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/numbers.rexx`](src/numbers.rexx) | Módulo `Numbers` — único archivo: clase con las 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help` privados. |
| [`test/recursive_tests.rexx`](test/recursive_tests.rexx) | Suite recursiva: 5 métodos de test (11 casos). |
| [`test/iterative_tests.rexx`](test/iterative_tests.rexx) | Suite iterativa: 5 métodos de test (11 casos). |

**Estructura de directorios esperada:**

```text
numbers/
├── src/
│   └── numbers.rexx           # Único archivo: 3 enfoques en 1
├── test/
│   ├── recursive_tests.rexx   # Tests: enfoque recursivo
│   └── iterative_tests.rexx   # Tests: enfoque iterativo
└── README.md                  # Este archivo
```

> **ES:** El framework `OOREXXUNIT.CLS` se instala por usuario en `~/.rexx/oorexxunit/` (ver el README de `calculator/`); las suites lo resuelven vía `REXX_PATH`.
> **EN:** The `OOREXXUNIT.CLS` framework is installed per user in `~/.rexx/oorexxunit/` (see the `calculator/` README); the suites resolve it via `REXX_PATH`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que `calculator`: una clase ooRexx con métodos de clase y suites `TestCase` de ooRexxUnit. Las 15 funciones se organizan en 3 grupos por enfoque:

**EN:** This project uses the same pattern as `calculator`: an ooRexx class with class methods and ooRexxUnit `TestCase` suites. The 15 functions are organized into 3 groups by approach:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc` | ❌ No (ver nota TCO) |
| Iterativo | `_ite` | `fibonacci_ite` | ✅ Sí |

**Combinación aplicada:** TCO ❌ + iteración ✅ → `_rec` + `_ite` = **2 suites × 11 aserciones = 22 aserciones (10 tests)**.

**Applied combination:** No TCO + iteration ✅ → `_rec` + `_ite` = **2 suites × 11 assertions = 22 assertions (10 tests)**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rexx/core/foundations/numbers/{src,test}
   ```

2. Escribir `src/numbers.rexx` y las suites en `test/`.

3. Tener `OOREXXUNIT.CLS` instalado (ver instalación en el README de `calculator/`).

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. Las suites cargan el módulo con `::requires "src/numbers.rexx"`.

### `src/numbers.rexx` — Implementación (3 enfoques en 1 archivo)

**ES:** Cada algoritmo tiene 3 implementaciones con los sufijos `_rec`, `_acc` e `_ite`; los helpers `_help` son **privados** (métodos de clase con `private`, solo invocables desde la propia clase). Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations with the suffixes `_rec`, `_acc` and `_ite`; the `_help` helpers are **private** (class methods marked `private`, only invocable from the class itself). For example, `fibonacci`:

```rexx
/* Direct recursion (_rec) */
::method fibonacci_rec class
  use arg n
  if n <= 1 then
    return n
  return self~fibonacci_rec(n - 1) + self~fibonacci_rec(n - 2)

/* Accumulator recursion (_acc): educational bridge, no TCO in ooRexx */
::method fibonacci_acc class
  use arg n
  return self~fibonacci_acc_help(n, 0, 1)

::method fibonacci_acc_help class private
  use arg n, acc2, acc1
  if n <= 0 then
    return acc2
  if n <= 2 then
    return acc1 + acc2
  return self~fibonacci_acc_help(n - 1, acc1, acc1 + acc2)

/* Iterative (_ite) */
::method fibonacci_ite class
  use arg n
  if n <= 1 then
    return n
  acc2 = 0
  acc1 = 1
  do i = 2 to n
    temp = acc1 + acc2
    acc2 = acc1
    acc1 = temp
  end
  return acc1
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `n + sum_rec(n-1)` | helper con `n + acc` | `do i = 1 to n` |
| `factorial` | `n * fact_rec(n-1)` | helper con `n * acc` | `do i = 2 to n` |
| `fibonacci` | suma de dos llamadas | helper con `acc2, acc1` | `do i = 2 to n` con `temp` |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | `do while b <> 0` |
| `least_common_multiple` | `(a * b) / gcd` | `(a * b) / gcd` | `(a * b) / gcd` |

### Suites de pruebas — ooRexxUnit

**ES:** Dos suites, una por enfoque probado. Cada suite agrupa un método de test por función (5 por suite); los 11 casos del pseudocódigo viven como `assertEquals` dentro de ellos (22 aserciones en total), cada una con su mensaje.

**EN:** Two suites, one per tested approach. Each suite groups one test method per function (5 per suite); the pseudocode's 11 cases live as `assertEquals`s within them (22 assertions in total), each with its message.

```rexx
aResult = .TestSuite~new(.RecursiveTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/numbers.rexx"

::class RecursiveTest subclass TestCase

::method testSumOfFirstNRec
  self~assertEquals(0, .Numbers~sum_of_first_n_rec(0), "sum_of_first_n_rec 1")
  self~assertEquals(6, .Numbers~sum_of_first_n_rec(3), "sum_of_first_n_rec 2")

::method testFibonacciRec
  self~assertEquals(0, .Numbers~fibonacci_rec(0), "fibonacci_rec 1")
  self~assertEquals(1, .Numbers~fibonacci_rec(1), "fibonacci_rec 2")
  self~assertEquals(8, .Numbers~fibonacci_rec(6), "fibonacci_rec 3")
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Open Object Rexx** (`rexx`).
- **ooRexxUnit** instalado por usuario (`REXX_PATH`).

```bash
# Verificar instalación
rexx -v
```

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto (los `::requires` son relativos al directorio de trabajo):

```bash
cd rexx/core/foundations/numbers
rexx test/recursive_tests.rexx
rexx test/iterative_tests.rexx
```

### Salida esperada / Expected output

```text
nr of test runs:             6
nr of successful assertions: 11
nr of failures:              0
nr of errors:                0
```

> **ES:** Cada suite reporta 11 aserciones exitosas (6 test runs = 5 métodos de test + la suite); 22 en total, equivalente al `tests runned 22 / passed 22 / failed 0` de la combinación sin TCO de la especificación.
> **EN:** Each suite reports 11 successful assertions (6 test runs = 5 test methods + the suite); 22 in total, equivalent to the specification's `tests runned 22 / passed 22 / failed 0` for the no-TCO combination.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En ooRexx, **no se garantiza TCO**: el intérprete no optimiza las llamadas de cola y la recursión profunda agota la pila (verificado empíricamente: 100.000 llamadas de cola terminan en fallo del intérprete). La versión con acumulador se conserva únicamente con fines educativos, como puente conceptual entre la recursión directa (`_rec`) y la versión iterativa (`_ite`). Como no hay un beneficio práctico de rendimiento, **no se desarrollan pruebas unitarias específicas para las funciones `_acc`**. Su comportamiento queda validado a través de las suites recursiva e iterativa, que ejercitan los mismos resultados.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In ooRexx, **TCO is not guaranteed**: the interpreter does not optimize tail calls and deep recursion exhausts the stack (empirically verified: 100,000 tail calls end in an interpreter crash). The accumulator version is kept purely for educational purposes, as a conceptual bridge between direct recursion (`_rec`) and the iterative version (`_ite`). Since there is no practical performance benefit, **no dedicated unit tests are written for the `_acc` functions**. Their behavior is validated through the recursive and iterative suites, which exercise the same results.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Los helpers `_help` son métodos de clase `private`: solo se invocan desde la propia clase con `self~...` (privados de verdad, no por convención).
- **EN:** The `_help` helpers are `private` class methods: they are only invoked from the class itself via `self~...` (truly private, not just by convention).
- **ES:** El MCM usa `(a * b) / gcd`; la división de REXX es decimal exacta y estos casos producen enteros exactos.
- **EN:** LCM uses `(a * b) / gcd`; REXX division is exact decimal and these cases produce exact integers.
- **ES:** En `greatest_common_divisor` se usa `//` (operador resto de REXX), legítimo en este algoritmo (la restricción de no usar operadores de módulo aplica solo al módulo `calculator` de la especificación 03).
- **EN:** `greatest_common_divisor` uses `//` (REXX's remainder operator), which is legitimate in this algorithm (the no-modulus-operator restriction applies only to the `calculator` module of specification 03).
- **ES:** Los `do i = 1 to n` con `n = 0` no iteran (inicio mayor que fin), como en el pseudocódigo.
- **EN:** `do i = 1 to n` loops with `n = 0` do not iterate (start greater than end), as in the pseudocode.
- **ES:** Las suites se ejecutan desde la raíz del proyecto: los `::requires` relativos resuelven contra el directorio de trabajo; `OOREXXUNIT.CLS` se resuelve vía `REXX_PATH`.
- **EN:** Suites run from the project root: relative `::requires` resolve against the working directory; `OOREXXUNIT.CLS` resolves via `REXX_PATH`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
