# REDVEN

## Nota Previa: Creación de Base de Datos y Tablas

Para poder probar las consultas y ejemplos incluidos en este README, es necesario ejecutar previamente el script **ScriptREDVEN.sql**, que crea la base de datos `REDVEN` y todas las tablas necesarias en **SQL Server**.

💡 **Importante:** Ejecutar este script antes de probar cualquier consulta de ejemplo para asegurar que todas las tablas y relaciones existan correctamente.

## 1. Consultas SQL (Queries) y Sentencias DML

SQL es el lenguaje utilizado para gestionar **Bases de Datos Relacionales (BDD)**. Permite definir estructuras, manipular datos y consultar información.

Las sentencias de **Lenguaje de Manipulación de Datos (DML)** incluyen:

- `SELECT`: Recupera datos de una tabla o conjunto de tablas.
- `INSERT`: Inserta nuevos registros.
- `UPDATE`: Modifica registros existentes.
- `DELETE`: Elimina registros.

### 1.1. Sentencia SELECT y Cláusulas Fundamentales

- **SELECT:** Recupera todos los campos de una tabla. Se recomienda especificar solo los campos necesarios.
- **FROM:** Indica las tablas involucradas.
- **WHERE:** Filtra filas según criterios usando operadores lógicos (`AND`, `OR`, `NOT`) y funciones integradas.

### 1.2. Consultas Comparativas y Operadores Avanzados

- **Comparaciones:** `=`, `!=`, `<>`.
- **Intervalos:** `BETWEEN valor1 AND valor2` o `NOT BETWEEN`.
- **Pertenencia a lista:** `IN (valor1, valor2, ...)`.
- **Correspondencia de patrones:** `LIKE '%texto%'` o `_` para un solo carácter.
- **Registros distintos:** `DISTINCT` para eliminar duplicados.

### 1.3. Agrupación y Filtrado de Grupos

- **GROUP BY:** Agrupa filas en conjuntos de resumen.
- **HAVING:** Filtra grupos después de `GROUP BY`.
- **ORDER BY:** Ordena los resultados ascendente o descendente.

### 1.4. Combinación de Resultados y Subconsultas

- **UNION / UNION ALL:** Combina resultados de varias consultas.
- **Subconsultas:** Consultas anidadas dentro de otras consultas. También se pueden reemplazar con `JOIN` para optimización.

---

## 2. Tipos de Combinaciones (Joins)

SQL Server permite establecer relaciones entre tablas mediante combinaciones:

- **CROSS JOIN / Producto Cartesiano:** Todas las combinaciones posibles de dos tablas.
- **INNER JOIN:** Devuelve solo filas coincidentes.
- **LEFT (OUTER) JOIN:** Todas las filas de la tabla izquierda y coincidencias de la derecha.
- **RIGHT (OUTER) JOIN:** Todas las filas de la tabla derecha y coincidencias de la izquierda.
- **FULL OUTER JOIN:** Combina LEFT y RIGHT JOIN, mostrando todas las filas.
- **NATURAL JOIN:** No está implementado directamente en SQL Server; se puede simular mediante `INNER JOIN` con condiciones de igualdad en todas las columnas comunes.
- **JOIN ... USING:** SQL Server no soporta `USING`; se especifica la condición con `ON`.

---

## 3. Orden Lógico de Ejecución de Consultas y Optimización

Aunque las consultas se escriben de arriba hacia abajo, SQL Server las procesa siguiendo un **orden lógico interno**:

1. **FROM** → Selección de tablas y combinación (`JOIN`).  
2. **ON** → Condición de los JOINs.  
3. **OUTER JOIN** → Aplicación de LEFT, RIGHT o FULL OUTER.  
4. **WHERE** → Filtrado de filas antes de la agrupación.  
5. **GROUP BY** → Agrupación de las filas.  
6. **HAVING** → Filtrado de grupos después de la agregación.  
7. **SELECT** → Selección de columnas y cálculos, incluyendo alias.  
8. **DISTINCT** → Eliminación de duplicados.  
9. **ORDER BY** → Ordenamiento final del conjunto de resultados.  
10. **TOP / OFFSET-FETCH** → Limitación de filas devueltas.

💡 **Consejos de Optimización:**

- Evitar `SELECT *`, seleccionar solo los campos necesarios.  
- Usar índices para acelerar búsquedas y combinaciones.  
- Utilizar `WHERE` antes de `GROUP BY` para filtrar datos lo antes posible.  
- Revisar planes de ejecución con `SET STATISTICS PROFILE ON` o `SET STATISTICS IO ON`.  

---

## 4. Estructuras de Programación Avanzadas

### 4.1. Procedimientos Almacenados (Stored Procedures - SP)

- Aceptan parámetros de entrada y salida.
- Contienen lógica de control (`IF...ELSE`, bucles).
- Se crean con `CREATE PROCEDURE` y se ejecutan con `EXEC NombreSP`.
- Pueden anidarse hasta 32 niveles.
- Permiten reutilizar planes de ejecución para optimización.

### 4.2. Funciones (Functions)

- **Integradas:** `SUM()`, `MAX()`, `MIN()`, `AVG()`, `GETDATE()`, funciones de cadenas (`LEFT()`, `RIGHT()`).
- **Definidas por el usuario:** Escalares y agregadas (`CREATE FUNCTION`).
- Actúan sobre filas individuales o grupos de datos.
- Se utilizan con `GROUP BY` en funciones agregadas.

### 4.3. Triggers (Disparadores)

- Ejecutan automáticamente acciones ante `INSERT`, `UPDATE` o `DELETE`.
- Permiten mantener integridad de datos y automatizar procesos.

### 4.4. Vistas (Views)

- Tablas virtuales basadas en consultas.
- Permiten seguridad y simplificación de consultas complejas.
- Se consultan como tablas normales mediante `SELECT`.

---

## 5. Transacciones y Control de Concurrencia

### 5.1. Propiedades ACID

- **Atomicidad:** Todo o nada.
- **Consistencia:** Estado coherente antes y después.
- **Aislamiento:** Transacciones ejecutadas de forma independiente.
- **Durabilidad:** Cambios confirmados persisten tras fallos.

### 5.2. Control y Estados

- **Inicio:** `BEGIN TRANSACTION`
- **Confirmar:** `COMMIT`
- **Revertir:** `ROLLBACK`
- Estados: Activo, Parcialmente Confirmado, Confirmado, Fallido, Abortado.

### 5.3. Problemas de Concurrencia

- **Lost Update:** Actualizaciones sobrescritas.
- **Dirty Read:** Lectura de datos no confirmados.
- **Inconsistent Analysis:** Lectura parcial durante modificaciones concurrentes.

### 5.4. Niveles de Aislamiento

- `READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`.
- SQL Server garantiza consistencia mediante bloqueos y versiones de fila (`Snapshot Isolation`).
- **Bloqueos para Actualización:** `WITH (UPDLOCK)` y `FOR UPDATE` en select para controlar concurrencia.

---

## 6. Sentencias de Modificación y Control

- **UPDATE / DELETE:** Modifican o eliminan filas; usar `WHERE`.
- **TRUNCATE TABLE:** Elimina todas las filas más rápido que `DELETE`, no registra cada fila.
- **CREATE / ALTER / DROP:** Crear, modificar y eliminar bases, tablas e índices.

---

## 7. Funciones de Integridad y Optimización

- **Claves Foráneas (FK):** Mantienen integridad referencial.
- **Cascadas (CASCADE):** Permiten eliminación o actualización en cadena.
- **Bloqueos (LOCK TABLES / WITH HOLDLOCK):** Control de acceso concurrente.
- **Variables de Usuario:** `DECLARE @variable` para valores temporales.
- **Carga de Datos:** `BULK INSERT` o `OPENROWSET` para grandes volúmenes.
- **Optimización de Tablas:** `ALTER INDEX ... REBUILD` y `DBCC CHECKTABLE` para mantenimiento.