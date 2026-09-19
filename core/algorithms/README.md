# Algorithms Pure — REXX

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **REXX** (Open Object Rexx): ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre `.Array` de ooRexx, que se ordenan *in-place* y se devuelven; el caso nulo se representa con `.Nil` como indicador de fallo (no hay excepciones) y el array vacío es `.array~new`.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `rexx test/naive_sort_tests.rexx` (ooRexxUnit) | 24 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── src/
    │   └── naive_sort.rexx          # Módulo: clase NaiveSort con 3 métodos de clase
    ├── test/
    │   └── naive_sort_tests.rexx    # Suite: 3 tests × 8 casos + helper compartido
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Open Object Rexx (`rexx`), intérprete directo de los `.rexx` |
| **CLI** | `rexx test/<suite>.rexx`, ejecutado desde la raíz del proyecto |
| **Andamiaje** | ✅ Estructura manual (`mkdir -p src test`), la que ya usa [`foundations/numbers/`](../foundations/numbers/); sin manifiesto ni configuración de build |
| **Framework de tests** | ooRexxUnit: subclases de `TestCase` con métodos `test*`, cargado con `::requires "OOREXXUNIT.CLS"` (vía `REXX_PATH`) |
| **Runner** | `.TestSuite~new(.XTest)~execute` + `~print`; no hay archivo `run_tests` |
| **Separación** | `src/` (módulo) ↔ `test/` (suites) |
| **Módulo fuente** | Una clase ooRexx (`::class`) con métodos de clase: `.NaiveSort~selection_sort(arr)` |
| **API** | Una función por algoritmo, con el `.Array` recibido y devuelto |
| **Naming** | `snake_case` idéntico al de la especificación (`selection_sort`); los métodos de test de la suite usan `camelCase` (`testSelectionSort`) |
| **Mutabilidad** | `.Array` mutable e 1-based: lectura `arr~at(i)`, escritura `arr[i] = v` |
| **Nulabilidad** | `.Nil` como indicador de fallo (no se lanzan excepciones); el array vacío es `.array~new` |
| **Mensajes de aserción** | `assertEquals(expected, actual, message)` con el mensaje del contrato (`selection_sort should sort an unsorted array`) |
| **Verificación estática** | ❌ No hay analizador estático: `rexxc` no reporta errores de sintaxis y sale con 0; la comprobación real es cargar el módulo ejecutando la suite |
| **Artefactos** | Ninguno: ooRexx interpreta los fuentes y no genera salida |
| **Particularidades** | Sin cortocircuito en los operadores lógicos (`&` y `\|`); `if ... then do ... end` requiere el `do` explícito; una instancia no alcanza los métodos de clase con `self~...` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
rexx test/naive_sort_tests.rexx
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
