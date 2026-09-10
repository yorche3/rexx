# Hello, User! — REXX

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **REXX** (con Open Object Rexx), con un enfoque manual y minimalista.

Solicita un nombre al usuario por la entrada estándar (estilo prompt) y saluda.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.rexx`](hello_user.rexx) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.rexx  # Código fuente
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura del prompt** — `say` imprime `"Enter your name: "` (con salto de línea).
2. **Entrada de usuario** — `pull` lee una línea desde la entrada estándar y la asigna a `name`.
3. **Concatenación en la salida** — `say` con varias expresiones las concatena separadas por espacios.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Prompt output** — `say` prints `"Enter your name: "` (with newline).
2. **User input** — `pull` reads a line from standard input and assigns it to `name`.
3. **Concatenation in output** — `say` with several expressions concatenates them separated by spaces.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rexx/core/foundations/hellouser
   ```

2. Escribir el archivo `hello_user.rexx` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `rexx`.

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `say`.
2. Leer una línea desde `stdin` con `pull` y asignarla a `name`.
3. Imprimir `"Hello, <nombre>!"` concatenando tres expresiones con `say`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `say`.
2. Read a line from `stdin` with `pull` and assign it to `name`.
3. Print `"Hello, <name>!"` concatenating three expressions with `say`.

```rexx
say "Enter your name: "
pull name
say "Hello, " name "!"
```

| Elemento | Propósito |
|----------|-----------|
| `say "Enter your name: "` | Imprime el prompt en `stdout` con salto de línea. |
| `pull name` | Lee una línea desde la entrada estándar y la asigna a la variable `name` (sin `$` ni sigilos: REXX es typeless). |
| `say "Hello, " name "!"` | `say` con varias expresiones las une separadas por espacios: `Hello, ` + `name` + `!`. |
| `name` | Variable REXX: su nombre es la palabra literal, sin caracteres especiales. |

> **ES:** En REXX clásico, `pull` lee del *external data queue* (stdin en scripts) y **convierte la entrada a MAYÚSCULAS**. Para conservar las mayúsculas/minúsculas tal cual se escriben, se usa `parse pull name`. Este ejemplo usa `pull` (comportamiento clásico), por lo que `Ada` se saluda como `ADA`.
> **EN:** In classic REXX, `pull` reads from the *external data queue* (stdin in scripts) and **UPPERCASES the input**. To preserve the exact case, use `parse pull name`. This example uses `pull` (classic behavior), so `Ada` is greeted as `ADA`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener un intérprete REXX instalado

```bash
# Verificar instalación (Open Object Rexx en esta máquina)
rexx -v
```

### Ejecutar / Run

```bash
cd rexx/core/foundations/hellouser
rexx hello_user.rexx
```

**ES:** El programa muestra el prompt y espera a que escribas tu nombre y presiones Enter.
**EN:** The program shows the prompt and waits for you to type your name and press Enter.

### Salida esperada / Expected output

```text
Enter your name: 
Ada
Hello,  ADA !
```

> **ES:** El nombre se muestra en MAYÚSCULAS por `pull` y `say` separa las expresiones con espacios (de ahí `Hello,␣␣ADA␣!`). También admite entrada redirigida: `printf 'Ada\n' | rexx hello_user.rexx`.
> **EN:** The name appears UPPERCASED because of `pull`, and `say` separates expressions with spaces (hence `Hello,␣␣ADA␣!`). It also accepts redirected input: `printf 'Ada\n' | rexx hello_user.rexx`.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** REXX no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** REXX does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `pull` combina lectura de stdin y asignación; su variante `parse pull` conserva las mayúsculas/minúsculas de la entrada.
- **EN:** `pull` combines stdin reading and assignment; its `parse pull` variant preserves the input's case.
- **ES:** `say` escribe en `stdout` con salto de línea; con varios argumentos los une con un espacio entre cada uno.
- **EN:** `say` writes to `stdout` with a newline; with several arguments it joins them with one space between each.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
