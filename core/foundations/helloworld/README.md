# Hello, World! — REXX

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **REXX** (con Open Object Rexx), con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.rexx`](hello_world.rexx) | Código fuente: imprime `"Hello, World! from Rexx"` en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.rexx  # Código fuente
└── README.md         # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Un único archivo `.rexx` es suficiente: REXX es un lenguaje interpretado, por lo que no requiere compilación previa para ejecutarse.

**EN:** The project was created manually, without scaffolding tools. A single `.rexx` file is enough: REXX is an interpreted language, so no prior compilation is required to run it.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rexx/core/foundations/helloworld
   ```

2. Escribir el archivo `hello_world.rexx` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `rexx`.

```rexx
say "Hello, World! from Rexx"
```

| Elemento | Propósito |
|----------|-----------|
| `say` | **Instrucción** (keyword) de REXX que escribe su argumento en la salida estándar seguido de un salto de línea (`\n`). |
| `"Hello, World! from Rexx"` | Argumento: la cadena a imprimir. |

> **ES:** REXX es un lenguaje *typeless*: las cadenas no requieren comillas obligatoriamente (`say Hello` es válido). Aquí se usan comillas dobles porque la cadena contiene una coma y signos; las comillas también delimitan espacios en blanco.
> **EN:** REXX is a *typeless* language: strings do not require quotes (`say Hello` is valid). Double quotes are used here because the string contains a comma and symbols; quotes also delimit blank spaces.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener un intérprete REXX instalado

```bash
# Verificar instalación (Open Object Rexx en esta máquina)
rexx -v
```

> **ES:** Existen varias implementaciones: **Open Object Rexx** (ooRexx, la usada aquí), **Regina REXX** (`regina`) y REXX clásico en mainframes. La sintaxis básica es compatible.
> **EN:** There are several implementations: **Open Object Rexx** (ooRexx, the one used here), **Regina REXX** (`regina`), and classic REXX on mainframes. The basic syntax is compatible.

### Ejecutar directamente / Run directly

```bash
cd rexx/core/foundations/helloworld
rexx hello_world.rexx
```

### Alternativa: ejecutar desde una cadena / Alternative: run from a string

```bash
rexx -e 'say "Hello, World! from Rexx"'
```

### Salida esperada / Expected output

```text
Hello, World! from Rexx
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** REXX no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** REXX does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `say` escribe en `stdout` y añade automáticamente un salto de línea.
- **EN:** `say` writes to `stdout` and automatically appends a newline.
- **ES:** REXX no distingue tipos: todo dato es una cadena; la conversión numérica ocurre solo en contexto aritmético.
- **EN:** REXX makes no type distinctions: every datum is a string; numeric conversion only happens in arithmetic context.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
