# ventas_e

## Descripción General

`ventas_e` consiste en la creación de una base de datos relacional orientada a la gestión de usuarios, empresas y relaciones entre ellos. El objetivo principal es ilustrar cómo diseñar, crear y manipular una base de datos utilizando **SQL Server**, incluyendo:

- Creación de bases de datos y usuarios.
- Diseño de tablas con claves primarias y foráneas.
- Relaciones entre tablas y restricciones de integridad.
- Población inicial de datos.
- Modificaciones estructurales y actualizaciones de datos.
- Gestión de cambios históricos y seguridad de la información.

El enfoque de este proyecto es **didáctico**, mostrando buenas prácticas en la modelación de datos, integridad referencial y escalabilidad.

---

## Scripts y Conceptos Teóricos

### 1. Crear la base de datos y usuario

**Archivo:** `CrearBaseYUsuario.sql`

**Instrucciones usadas:**

- `CREATE DATABASE <nombre>`: Crea una nueva base de datos.
- `CREATE LOGIN <nombre> WITH PASSWORD = '<contraseña>'`: Crea un login a nivel servidor.
- `CREATE USER <nombre> FOR LOGIN <login>`: Crea un usuario dentro de la base de datos asociado a un login.
- `ALTER ROLE db_owner ADD MEMBER <usuario>`: Asigna al usuario permisos de propietario (Owner), otorgándole control total sobre la base.

**Concepto clave:**  
Diferencia entre **login** (a nivel servidor) y **usuario** (a nivel base de datos). Esto permite controlar la seguridad y permisos granularmente.

---

### 2. Crear tablas principales

**Archivo:** `CrearTablas.sql`

**Instrucciones usadas:**

- `CREATE TABLE`: Define la estructura de una tabla, especificando columnas y tipos de datos.
- Tipos de datos comunes:
  - `UNIQUEIDENTIFIER`: Genera un identificador global único (GUID).
  - `VARCHAR(n)`: Cadena de texto de longitud variable.
  - `INT`: Entero.
- `PRIMARY KEY`: Define la clave primaria de la tabla, garantizando unicidad.
- `FOREIGN KEY ... REFERENCES ...`: Define una clave foránea que mantiene la **integridad referencial**.
- Opciones `ON DELETE CASCADE` y `ON UPDATE CASCADE`:
  - `ON DELETE CASCADE`: Al eliminar un registro padre, se eliminan automáticamente los registros relacionados.
  - `ON UPDATE CASCADE`: Al actualizar la clave primaria del registro padre, se actualizan automáticamente los registros hijos.

**Concepto clave:**  
El diseño relacional permite mantener consistencia y prevenir registros huérfanos. La tabla `UsuarioXEmpresa` ejemplifica una **relación muchos a muchos** entre usuarios y empresas.

---

### 3. Modificación de tablas

**Archivo:** `ModificarTablas.sql`

**Instrucciones usadas:**

- `ALTER TABLE <tabla> DROP COLUMN <columna>`: Elimina un campo de la tabla.
- `ALTER TABLE <tabla> ADD <columna> <tipo>`: Agrega uno o más campos a la tabla existente.

**Concepto clave:**  
Las bases de datos evolucionan con el tiempo. `ALTER TABLE` permite adaptar la estructura de datos sin perder la información existente.

---

### 4. Poblar la tabla Empresa

**Archivo:** `PoblarEmpresas.sql`

**Instrucciones usadas:**

- `INSERT INTO <tabla> (<columnas>) VALUES (<valores>)`: Inserta nuevos registros en la tabla.
- `NEWID()`: Genera un GUID único automáticamente para usar como clave primaria.

**Concepto clave:**  
Poblar la base de datos con datos de ejemplo permite probar consultas, relaciones y restricciones antes de operar con datos reales.

---

### 5. Poblar la tabla Usuario y establecer relaciones

**Archivo:** `PoblarUsuariosYRelaciones.sql`

**Instrucciones usadas:**

- `INSERT INTO` para agregar registros de usuarios.
- `SELECT ... FROM ... WHERE ...` combinado con `INSERT INTO` para establecer relaciones en `UsuarioXEmpresa`.
- `DECLARE` y variables (`@Variable`) para almacenar IDs temporales y facilitar inserciones dinámicas.

**Concepto clave:**  
Las relaciones entre tablas se pueden manejar de manera programática utilizando consultas dinámicas y variables. Esto es especialmente útil para poblar tablas relacionales automáticamente.

---

### 6. Cambios en la información de usuarios

**Archivo:** `CambiosInformacionUsuarios.sql`

**Instrucciones usadas:**

- `DELETE FROM <tabla> WHERE ...`: Elimina registros específicos.
- `UPDATE <tabla> SET <columna> = <valor> WHERE ...`: Actualiza registros existentes.
- Ciclos `WHILE` y tablas temporales `CREATE TABLE #Temp`: Permiten aplicar cambios masivos de manera controlada.
- Uso de concatenación y manipulación de cadenas para generar contraseñas dinámicas.

**Concepto clave:**  
El manejo histórico de datos y la seguridad requieren operaciones que modifican registros existentes sin afectar la integridad general de la base de datos.

---

## Buenas Prácticas Destacadas

1. **Uso de `UNIQUEIDENTIFIER` como clave primaria** para integraciones y escalabilidad.
2. **Integridad referencial** mediante claves foráneas y `CASCADE`.
3. **Evolución de tablas** con `ALTER TABLE` para adaptarse a cambios del negocio.
4. **Separación de scripts** por funcionalidades (creación, modificación, población de datos) para mayor claridad y mantenimiento.
5. **Variables y tablas temporales** para operaciones dinámicas y masivas.

---

## Recomendación de Ejecución

Se recomienda ejecutar los scripts en el siguiente orden:

1. `CrearBaseYUsuario.sql`
2. `CrearTablas.sql`
3. `ModificarTablas.sql`
4. `PoblarEmpresas.sql`
5. `PoblarUsuariosYRelaciones.sql`
6. `CambiosInformacionUsuarios.sql`

---

## Conclusión

`ventas_e` es un ejemplo completo de cómo:

- Diseñar una base de datos relacional.
- Mantener la integridad y consistencia de datos.
- Gestionar usuarios y empresas con relaciones muchos a muchos.
- Adaptar y actualizar estructuras y datos a lo largo del tiempo.
- Aplicar buenas prácticas de seguridad y escalabilidad en bases de datos.
