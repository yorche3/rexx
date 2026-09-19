# REXX

Proyectos en **REXX** (con Open Object Rexx), con programas simples ejecutados
con el intérprete `rexx` y proyectos con pruebas unitarias gestionados con
**ooRexxUnit**, el framework de pruebas de ooRexx (instalado por usuario).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |
| [`core/algorithms/`](core/algorithms/) | **Fase 1 — Algoritmos Puros**: `naive_sort` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
rexx hello_world.rexx

# Hello, User!
cd core/foundations/hellouser
rexx hello_user.rexx

# Calculator Tests
cd core/foundations/unit_test/calculator
rexx test/calculator_test.rexx

# Numbers Tests
cd core/foundations/numbers
rexx test/recursive_tests.rexx
rexx test/iterative_tests.rexx

# Naive Sort Tests
cd core/algorithms/naive_sort
rexx test/naive_sort_tests.rexx
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [Open Object Rexx](https://www.oorexx.org/) | `sudo apt install oorexx` (Linux) / descargar de oorexx.org |
| [ooRexxUnit](https://www.oorexx.org/) (framework de pruebas) | Incluido en el paquete **ooTest**; instalación por usuario (ver abajo) |

```bash
# Verificar instalación
rexx -v
```

### Instalar ooRexxUnit (una sola vez por usuario) / Install ooRexxUnit (once per user)

```bash
# 1. Extraer el framework desde el zip ooTest (p. ej. ooTest-4.2.0-snapshot06.zip)
mkdir -p ~/.rexx/oorexxunit
unzip -j ooTest-4.2.0-snapshot06.zip \
  'ooTest-4.2.0-snapshot06/framework/OOREXXUNIT.CLS' -d ~/.rexx/oorexxunit/

# 2. Añadir el directorio al path de búsqueda de ::requires (persistente)
echo 'export REXX_PATH="$HOME/.rexx/oorexxunit${REXX_PATH:+:$REXX_PATH}"' >> ~/.bashrc
source ~/.bashrc
```

> **ES:** El framework no se versiona en el repositorio: se instala una sola vez por usuario y los tests lo resuelven con `::requires "OOREXXUNIT.CLS"` vía `REXX_PATH`.
> **EN:** The framework is not versioned in the repository: it is installed once per user and tests resolve it with `::requires "OOREXXUNIT.CLS"` via `REXX_PATH`.

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (interpretado con `rexx`)

**ES:** Un único archivo fuente, sin dependencias externas, ejecutado directamente
con `rexx`. Ideal para `helloworld` y `hellouser`. REXX es typeless: sin
declaraciones de variables ni `main`.

**EN:** A single source file, no external dependencies, run directly with `rexx`.
Ideal for `helloworld` and `hellouser`. REXX is typeless: no variable
declarations and no `main`.

```bash
rexx <File>.rexx
```

### 2. Proyecto con pruebas unitarias (ooRexxUnit)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **ooRexxUnit**
como framework de test. El código fuente se organiza en `src/` (clases ooRexx
con `::class` y métodos de clase) y las pruebas en `test/` (subclases de
`TestCase` con métodos `test*`). Las suites se ejecutan desde la raíz del
proyecto: los `::requires` relativos resuelven contra el directorio de trabajo y
el framework se resuelve vía `REXX_PATH`.

**EN:** For projects that require unit tests, **ooRexxUnit** is used as the test
framework. Source code goes in `src/` (ooRexx classes with `::class` and class
methods) and tests in `test/` (`TestCase` subclasses with `test*` methods).
Suites run from the project root: relative `::requires` resolve against the
working directory and the framework resolves via `REXX_PATH`.

```bash
rexx test/<suite>.rexx     # desde la raíz del proyecto
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio
principal](https://github.com/yorche3/programming_languages) para ver todas las
versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*