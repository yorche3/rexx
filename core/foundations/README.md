# 🚀 Fundamentos / Foundations — REXX

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **REXX** (con Open Object Rexx).

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **REXX**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **REXX**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
rexx/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── hello_world.rexx
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hello_user.rexx
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── src/
        │       │   └── calculator.rexx
        │       ├── test/
        │       │   └── calculator_test.rexx
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── src/
            │   └── numbers.rexx
            ├── test/
            │   ├── recursive_tests.rexx
            │   └── iterative_tests.rexx
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `say`, ejecución con `rexx` | — | ❌ Solo el intérprete |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `pull`, variables typeless, concatenación en `say` | — | ❌ Solo el intérprete |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | ooRexxUnit, `TestCase`, clases y métodos de clase | 5 aserciones | ✅ ooRexxUnit (por usuario) |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, acumuladores, bucles, TCO | 22 aserciones | ✅ ooRexxUnit (por usuario) |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo `.rexx`, ejecutados directamente con `rexx`. REXX es typeless: no hay declaraciones de variables ni `main`.
2. **Calculator**: Primer proyecto con framework de pruebas (**ooRexxUnit**, instalado por usuario en `~/.rexx/oorexxunit/` y resuelto vía `REXX_PATH`). Introduce las clases de ooRexx (`::class`, métodos de clase), la separación `src/` + `test/` y las suites `TestCase`.
3. **Numbers**: Expande el patrón a dos suites con un método de test por función. ooRexx **no optimiza la recursión de cola (TCO)**, por lo que `_acc` se conserva como puente didáctico con helpers privados, sin pruebas propias: `_rec` + `_ite` = 22 aserciones.

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file `.rexx` programs, run directly with `rexx`. REXX is typeless: no variable declarations and no `main`.
2. **Calculator**: First project with a test framework (**ooRexxUnit**, installed per user in `~/.rexx/oorexxunit/` and resolved via `REXX_PATH`). Introduces ooRexx classes (`::class`, class methods), the `src/` + `test/` separation, and `TestCase` suites.
3. **Numbers**: Expands the pattern to two suites with one test method per function. ooRexx **does not optimize tail recursion (TCO)**, so `_acc` is kept as an educational bridge with private helpers, without dedicated tests: `_rec` + `_ite` = 22 assertions.

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd rexx/core/foundations/helloworld
rexx hello_world.rexx
```

### Hello User

```bash
cd rexx/core/foundations/hellouser
rexx hello_user.rexx
```

### Calculator (pruebas)

```bash
cd rexx/core/foundations/unit_test/calculator
rexx test/calculator_test.rexx
```

### Numbers (pruebas)

```bash
cd rexx/core/foundations/numbers
rexx test/recursive_tests.rexx
rexx test/iterative_tests.rexx
```

> **ES:** Las suites se ejecutan desde la raíz de cada proyecto (los `::requires` relativos resuelven contra el directorio de trabajo). El framework ooRexxUnit se instala una sola vez por usuario (ver README de `calculator/`).
> **EN:** Suites run from each project's root (relative `::requires` resolve against the working directory). The ooRexxUnit framework is installed once per user (see the `calculator/` README).

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
