# Calculator — REXX

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **REXX** (Open Object Rexx), con **ooRexxUnit** como framework de pruebas unitarias — el framework de pruebas de ooRexx, distribuido con la suite ooTest del proyecto.

Operaciones aritméticas básicas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) con implementaciones intuitivas y educativas, validadas mediante pruebas unitarias.

---

## 📦 Instalación de ooRexxUnit / Installing ooRexxUnit

**ES:** `ooRexxUnit` se distribuye dentro del paquete **ooTest** (suite de tests de ooRexx), descargable de la página de ooRexx (`ooTest-4.2.0-snapshot06.zip`). Dentro del zip está en `framework/OOREXXUNIT.CLS` (autocontenido). En este proyecto se instala **por usuario** (como los frameworks de los demás lenguajes), usando el path de búsqueda de `::requires`:

**EN:** `ooRexxUnit` is distributed inside the **ooTest** package (ooRexx's test suite), downloadable from the ooRexx site (`ooTest-4.2.0-snapshot06.zip`). Inside the zip it lives at `framework/OOREXXUNIT.CLS` (self-contained). This project installs it **per user** (like the frameworks of the other languages), using the `::requires` search path:

```bash
# 1. Extraer el framework a un directorio estable del usuario
mkdir -p ~/.rexx/oorexxunit
unzip -j ooTest-4.2.0-snapshot06.zip \
  'ooTest-4.2.0-snapshot06/framework/OOREXXUNIT.CLS' -d ~/.rexx/oorexxunit/

# 2. Añadir el directorio al path de búsqueda de ::requires (persistente)
echo 'export REXX_PATH="$HOME/.rexx/oorexxunit${REXX_PATH:+:$REXX_PATH}"' >> ~/.bashrc
source ~/.bashrc
```

**ES:** Con esto, cualquier programa puede hacer `::requires "OOREXXUNIT.CLS"` sin copiar el archivo al proyecto. El zip de origen (que incluye su licencia CPL 1.0) queda en el equipo del usuario.

**EN:** With this, any program can `::requires "OOREXXUNIT.CLS"` without copying the file into the project. The source zip (which includes its CPL 1.0 license) stays on the user's machine.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/calculator.rexx`](src/calculator.rexx) | Código fuente: clase `Calculator` con los 5 métodos de clase. |
| [`test/calculator_test.rexx`](test/calculator_test.rexx) | Suite de pruebas: `CalculatorTest` subclase de `TestCase` con 5 métodos `test*`. |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── calculator.rexx        # Código fuente
├── test/
│   └── calculator_test.rexx   # Suite de pruebas
└── README.md                  # Este archivo
```

> **ES:** `OOREXXUNIT.CLS` no se versiona en el proyecto: se instala por usuario en `~/.rexx/oorexxunit/` (ver instalación).
> **EN:** `OOREXXUNIT.CLS` is not versioned in the project: it is installed per user in `~/.rexx/oorexxunit/` (see installation).

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente. ooRexx es REXX orientado a objetos: el módulo `calculator` es una **clase** con métodos de clase, y la suite es una subclase de `TestCase` de ooRexxUnit. Los `::requires` resuelven **relativos al directorio de trabajo**, por lo que la suite se ejecuta desde la raíz del proyecto.

**EN:** The project was created manually. ooRexx is object-oriented REXX: the `calculator` module is a **class** with class methods, and the suite is a subclass of ooRexxUnit's `TestCase`. `::requires` directives resolve **relative to the working directory**, so the suite runs from the project root.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p rexx/core/foundations/unit_test/calculator/{src,test}
   ```

2. Escribir `src/calculator.rexx` y `test/calculator_test.rexx`.

3. Instalar `ooRexxUnit` en `~/.rexx/oorexxunit/` (ver sección de instalación).

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El módulo se comparte mediante `::requires`.

### `src/calculator.rexx` — Implementaciones educativas

**ES:** Cada operación compleja se construye a partir de las simples (concepto que se explora a fondo en `04_Numbers`): `multiplication` suma repetidamente, `division` resta repetidamente y `modulus` reutiliza `division` y `multiplication`. Por eso **no** se usan los operadores `*`, `/` ni `//`.

**EN:** Each complex operation is built from the simple ones (a concept explored in depth in `04_Numbers`): `multiplication` adds repeatedly, `division` subtracts repeatedly, and `modulus` reuses `division` and `multiplication`. That's why the operators `*`, `/` and `//` are **not** used.

```rexx
::class Calculator public

::method addition class
  use arg a, b
  return a + b

::method subtraction class
  use arg a, b
  return a - b

::method multiplication class
  use arg a, b
  result = 0
  do i = 1 to b
    result = self~addition(result, a)
  end
  return result

::method division class
  use arg a, b
  quotient = 0
  do while a >= b
    a = self~subtraction(a, b)
    quotient = self~addition(quotient, 1)
  end
  return quotient

::method modulus class
  use arg a, b
  q = self~division(a, b)
  p = self~multiplication(q, b)
  return self~subtraction(a, p)
```

| Método | Implementación educativa |
|--------|-------------------------|
| `addition class` | Suma directa (`+`) |
| `subtraction class` | Resta directa (`-`) |
| `multiplication class` | Suma repetitiva: `do i = 1 to b` suma `a` a `result` |
| `division class` | Resta repetitiva: `do while a >= b` resta `b` y cuenta |
| `modulus class` | `q = division(a, b)`; `p = multiplication(q, b)`; `subtraction(a, p)` |

> **ES:** `::method <nombre> class` define un método de clase; se invoca con notación de punto sobre la clase: `.Calculator~addition(2, 3)`. Sin el punto, `Calculator` es un literal de cadena en REXX.
> **EN:** `::method <name> class` defines a class method; it is invoked with dot notation on the class: `.Calculator~addition(2, 3)`. Without the dot, `Calculator` is a string literal in REXX.

### `test/calculator_test.rexx` — Suite ooRexxUnit

**ES:** La suite define una subclase de `TestCase` con un método `test*` por operación (5 tests). El programa principal crea un `TestSuite` con la clase (recoge automáticamente los métodos `test*`) y lo ejecuta con `execute` (método público; `run` es privado).

**EN:** The suite defines a `TestCase` subclass with one `test*` method per operation (5 tests). The main program creates a `TestSuite` with the class (auto-collecting `test*` methods) and executes it with `execute` (public method; `run` is private).

```rexx
aResult = .TestSuite~new(.CalculatorTest)~execute
aResult~print

::requires "OOREXXUNIT.CLS"
::requires "src/calculator.rexx"

::class CalculatorTest subclass TestCase

::method testAddition
  self~assertEquals(5, .Calculator~addition(2, 3), "addition")

::method testSubtraction
  self~assertEquals(3, .Calculator~subtraction(5, 2), "subtraction")

::method testMultiplication
  self~assertEquals(12, .Calculator~multiplication(3, 4), "multiplication")

::method testDivision
  self~assertEquals(3, .Calculator~division(10, 3), "division")

::method testModulus
  self~assertEquals(1, .Calculator~modulus(10, 3), "modulus")
```

| Elemento | Propósito |
|----------|-----------|
| `::requires "OOREXXUNIT.CLS"` | Carga el framework de pruebas (relativo al directorio de trabajo). |
| `::requires "src/calculator.rexx"` | Carga el módulo bajo prueba. |
| `::class CalculatorTest subclass TestCase` | Suite: los métodos que empiezan por `test` se recogen automáticamente. |
| `self~assertEquals(expected, actual, msg)` | Aserción de igualdad (el orden es **esperado, real, mensaje**). |
| `.TestSuite~new(.CalculatorTest)` | Crea la suite con todos los `test*` de la clase. |
| `~execute` / `~print` | Ejecuta las pruebas y muestra el resumen. |

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Open Object Rexx** (`rexx`).

```bash
# Verificar instalación
rexx -v
```

> **ES:** No se necesitan dependencias adicionales en el proyecto: `OOREXXUNIT.CLS` se instala por usuario en `~/.rexx/oorexxunit/` y se resuelve vía `REXX_PATH`.
> **EN:** No additional project dependencies: `OOREXXUNIT.CLS` is installed per user in `~/.rexx/oorexxunit/` and resolved via `REXX_PATH`.

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto (los `::requires` son relativos al directorio de trabajo):

```bash
cd rexx/core/foundations/unit_test/calculator
rexx test/calculator_test.rexx
```

### Salida esperada / Expected output

```text
nr of test runs:             6
nr of successful assertions: 5
nr of failures:              0
nr of errors:                0
```

> **ES:** `6` test runs son los 5 métodos `test*` más la suite; `5` aserciones exitosas equivalen al `Tests run: 5, Passed: 5, Failed: 0` de la especificación.
> **EN:** `6` test runs are the 5 `test*` methods plus the suite; `5` successful assertions equal the specification's `Tests run: 5, Passed: 5, Failed: 0`.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Los `::requires` resuelven en este orden: primero relativos al **directorio de trabajo**, y luego en los directorios de `REXX_PATH` (donde se instaló `OOREXXUNIT.CLS`). Por eso la suite se ejecuta desde la raíz del proyecto con `rexx test/calculator_test.rexx`.
- **EN:** `::requires` resolves in this order: first relative to the **working directory**, then in the `REXX_PATH` directories (where `OOREXXUNIT.CLS` was installed). That's why the suite runs from the project root with `rexx test/calculator_test.rexx`.
- **ES:** La clase se declara `::class Calculator public` para que quede registrada en `.environment` y sea visible desde el programa principal.
- **EN:** The class is declared `::class Calculator public` so it gets registered in `.environment` and is visible from the main program.
- **ES:** Los métodos de clase se invocan con punto: `.Calculator~addition(2, 3)`; sin punto, `Calculator` es una cadena literal.
- **EN:** Class methods are invoked with the dot: `.Calculator~addition(2, 3)`; without it, `Calculator` is a string literal.
- **ES:** En ooRexxUnit, `execute` es el método público para correr la suite (`run` es privado).
- **EN:** In ooRexxUnit, `execute` is the public method to run the suite (`run` is private).
- **ES:** La división por cero no se maneja en este ejemplo educativo (según el pseudocódigo de la especificación); las pruebas usan valores válidos.
- **EN:** Division by zero is not handled in this educational example (per the specification's pseudocode); tests use valid values.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
