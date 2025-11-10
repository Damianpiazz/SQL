# SQL y Bases de Datos

Este repositorio contiene material de estudio y referencia correspondiente a la materia **Bases de Datos** de la **Universidad Tecnológica Nacional (UTN)**. Incluye los principales conceptos teóricos y prácticos sobre la gestión de bases de datos relacionales, como el **Modelado Entidad-Relación (MER/DER)**, **Modelo Relacional**, **Normalización**, **Álgebra Relacional**, **SQL**, **Transacciones**, y las **estructuras físicas** de almacenamiento y optimización.  

---

## Índice de Carpetas

- [`REDVEN`](REDVEN)  
  Contiene scripts y ejemplos prácticos de:
  - Stored Procedures
  - Consultas comunes
  - Transacciones
  - Vistas
  - Funciones SQL
- [`ventas_e`](ventas_e)  
  Contiene scripts y ejemplos prácticos de:
  - Creación de la base de datos y usuarios
  - Creación de tablas y relaciones
  - Modificación de tablas
  - Población de datos inicial
  - Actualizaciones y cambios históricos de usuarios y empresas
---

## Teoria

## 1. Fundamentos de Bases de Datos

Una **Base de Datos (BDD)** es una colección organizada de datos que representan un aspecto del mundo real, denominado **minimundo** o **universo de discurso**. Los datos no son aleatorios; deben mantener coherencia y significado, de modo que puedan ser utilizados para consultas, reportes y análisis de manera eficiente.

Un **Sistema de Administración de Bases de Datos (DBMS / SGBD)** es un conjunto de programas que permite a los usuarios:

1. **Definición de Datos**: Especificar tipos de datos, estructuras, restricciones y relaciones entre los datos.
2. **Construcción y Almacenamiento**: Guardar los datos en un medio persistente controlado por el DBMS, asegurando integridad y consistencia.
3. **Manipulación**: Permite realizar consultas, actualizaciones y generación de informes que reflejan cambios en el minimundo.
4. **Compartición**: Facilita el acceso concurrente a múltiples usuarios y aplicaciones, manteniendo consistencia y aislamiento.

**Características del DBMS:**

- **Autodescriptivo**: Contiene datos y metadatos (estructura y restricciones), almacenados en un catálogo interno.
- **Abstracción de Datos**: La estructura física de almacenamiento es independiente de los programas que acceden a los datos.
- **Seguridad y Persistencia**: Control de accesos y recuperación ante fallos.

---

## 2. Modelado Conceptual: Modelo Entidad-Relación (MER)

El **Modelo Entidad-Relación (MER)** es una herramienta conceptual que traduce objetos y relaciones del mundo real en un esquema que puede implementarse en una base de datos.

### 2.1. Nociones Básicas

- **Entidad**: Objeto distinguible del mundo real, tangible o abstracto, con propiedades únicas (**atributos**).
- **Conjunto de Entidades**: Agrupa entidades del mismo tipo que comparten atributos comunes.
- **Relación**: Asociación entre entidades. Puede contener atributos propios.
- **Atributo**: Propiedad que describe a una entidad. Su conjunto de valores posibles se denomina **dominio**.
- **Clave primaria**: Atributo o conjunto de atributos que identifica de manera única a cada entidad.

### 2.2. Tipos de Atributos

- **Simples**: No se dividen más.
- **Compuestos**: Formados por subatributos (ej., dirección → calle, número, ciudad).
- **Multivalorados**: Pueden tener varios valores para la misma entidad.
- **Derivados**: Calculables a partir de otros atributos (ej., edad a partir de fecha de nacimiento).

### 2.3. Entidades Débiles, Especialización y Agregación

- **Entidad Débil**: No tiene clave propia y depende de otra entidad para su identificación.
- **Especialización / Generalización**: Define jerarquías de entidades y relaciones entre niveles (cobertura total/parcial, exclusión/superposición).
- **Agregación**: Permite considerar una relación y sus entidades participantes como una nueva entidad para simplificar el modelado.

### 2.4. Cardinalidad y Diagramación

- **1:1 (Uno a Uno)**: Cada entidad de A se asocia con una sola entidad de B.
- **1:N (Uno a Muchos)**: Cada entidad de A se asocia con varias entidades de B.
- **N:M (Muchos a Muchos)**: Entidades de A y B pueden asociarse múltiples veces entre sí.

- **Cardinalidad mínima**: Indica si la participación es obligatoria (≥1) u opcional (0).
- **Cardinalidad máxima**: Indica el número máximo de asociaciones.

---

## 3. Modelo Relacional

El **Modelo Relacional** traduce el MER a un formato implementable mediante **tablas**:

- **Tuplas (filas)**: Representan instancias de entidades o relaciones.
- **Atributos (columnas)**: Representan propiedades de las entidades o relaciones.
- **Claves**: Garantizan unicidad y permiten establecer integridad referencial.

### 3.1. Tipos de Claves

- **Clave candidata (CC)**: Conjunto mínimo de atributos que identifica tuplas.
- **Clave primaria (CP)**: CC elegida para identificar de manera única.
- **Clave externa (FK)**: Atributo que referencia la CP de otra tabla, asegurando integridad referencial.

### 3.2. Integridad Referencial

Garantiza consistencia entre relaciones:

- **Restrict (NO ACTION)**: Evita modificar o borrar una tupla referenciada.
- **Cascade**: Propaga modificaciones o eliminaciones a las tablas relacionadas.

### 3.3. Conversión MER → Relacional

- Entidades fuertes y débiles → tablas.
- Atributos compuestos → simples.
- Atributos multivalorados → tablas separadas con FK.
- Relaciones 1:1 y 1:N → FK en la tabla correspondiente.
- Relaciones N:M → tabla de intersección con claves primarias de ambas entidades y atributos propios de la relación.

---

## 4. Normalización y Dependencias Funcionales

La **Normalización** reduce redundancia y anomalías en la BDD. 

### 4.1. Anomalías

1. **Inserción**: Problemas al añadir un nuevo registro que depende de información existente.
2. **Borrado**: Eliminación de información que no debería perderse.
3. **Modificación**: Necesidad de actualizar el mismo dato en múltiples registros.

### 4.2. Dependencias Funcionales

- **X → Y**: Valores de X determinan valores de Y:

$$
t_1[X] = t_2[X] \implies t_1[Y] = t_2[Y]
$$

- **Dependencia parcial**: Y depende solo de parte de la clave primaria.
- **Dependencia transitiva**: Si \(X \rightarrow Y\) y \(Y \rightarrow Z\), entonces \(X \rightarrow Z\).

### 4.3. Formas Normales

- **1FN**: Sin grupos repetitivos:

$$
\forall A_i \in R, \text{dominio}(A_i) \text{ atómico}
$$

- **2FN**: Sin dependencias parciales:

$$
R \text{ está en 1FN} \wedge \nexists X \subset K \text{ tal que } X \rightarrow Y
$$

- **3FN**: Sin dependencias transitivas:

$$
R \text{ está en 2FN} \wedge \forall (X \rightarrow Y), X \text{ clave primaria o Y atributo clave}
$$

- **BCNF**: Cada determinante es clave candidata:

$$
X \rightarrow Y \implies X \text{ es clave candidata}
$$

- **4FN y 5FN**: Manejo avanzado de multivalores y divisiones complejas.
- **Desnormalización**: Solo por rendimiento justificado.

---

## 5. Álgebra Relacional

Permite manipular relaciones para obtener nuevas relaciones:

- **Conjuntos**: Unión (∪), Intersección (∩), Diferencia (−), Producto Cartesiano (χ).
- **Operadores relacionales**: Selección (σ), Proyección (π), Renombre (ρ), Producto Natural (⋈), División (÷).
- **Manipulación avanzada**: Asignación (←), Modificación (δ).

### Ejemplo paso a paso

1. Seleccionar empleados del departamento 4 con sueldo mayor a 60000:

$$
\sigma_{\text{Depto}=4 \vee \text{Sueldo}>60000} (\text{Empleados})
$$

2. Proyectar Nombre, Apellido y DNI:

$$
\pi_{\text{Nombre, Apellido, DNI}} \Big( \sigma_{\text{Depto}=4 \vee \text{Sueldo}>60000} (\text{Empleados}) \Big)
$$

3. Proyectar Nombre y DNI de Beneficiarios:

$$
\pi_{\text{NombreBen, DNIemple}} (\text{Beneficiarios})
$$

4. Unir ambos conjuntos:

$$
\pi_{\text{Nombre, Apellido, DNI}} (\dots) \ \cup \ \pi_{\text{NombreBen, DNIemple}} (\text{Beneficiarios})
$$

---

## 6. SQL: Consultas y Joins

### 6.1. Lenguajes SQL

- **DDL (Data Definition Language)**: CREATE, ALTER, DROP.
- **DML (Data Manipulation Language)**: INSERT, SELECT, UPDATE, DELETE, TRUNCATE.

### 6.2. Cláusulas y Consultas

- **WHERE**: Filtra registros según condiciones.
- **LIKE / NOT LIKE**: Patrones con `%` y `_`.
- **IN / NOT IN**: Coincidencia con listas.
- **DISTINCT / DISTINCTROW**: Elimina duplicados.
- **GROUP BY**: Agrupa registros.
- **HAVING**: Condición sobre grupos.

### 6.3. Joins

- **INNER JOIN**: Devuelve solo coincidencias.
- **LEFT/RIGHT/FULL OUTER JOIN**: Incluye filas sin coincidencias.
- **NATURAL JOIN / USING**: Combina automáticamente por atributos comunes.

### 6.4. Procedimientos y Triggers

- **Procedimientos almacenados**: Bloques de SQL reutilizables con parámetros.
- **Triggers (Disparadores)**: Ejecutan acciones automáticas ante eventos.

---

## 7. Transacciones y Control de Concurrencia

- **Transacción**: Unidad lógica de operaciones (BEGIN…COMMIT/ROLLBACK).
- **Propiedades ACID**:

  - **Atomicidad**:

  $$
  T = \{ O_1, O_2, \dots, O_n \} \implies \text{todas o ninguna se ejecuta}
  $$

  - **Consistencia**:

  $$
  \forall T, D_{\text{inicial}} \xrightarrow{T} D_{\text{final}}, D_{\text{final}} \text{ cumple todas las restricciones}
  $$

  - **Aislamiento (Serialización)**:

  $$
  \text{Ejecutar } T_1, T_2, \dots, T_n \text{ concurrentemente } \equiv \text{ alguna ejecución serial de } T_i
  $$

  - **Durabilidad**:

  $$
  \text{Si } T \text{ se confirma (COMMIT), los cambios persisten aunque falle el sistema.}
  $$

- **Problemas comunes**: Actualización perdida, Lectura sucia, Análisis inconsistente.
- **Recuperación**: Actualización diferida, inmediata y Shadow Paging.

---

## 8. Estructuras Físicas: Motores, Índices y Dispersión

### 8.1. Motores de Base de Datos

#### MySQL

- **MyISAM**: Optimizado para lectura, subtipos estático/dinámico/comprimido.
- **InnoDB / BDB**: Soporta ACID, FK y transacciones seguras.
- **HEAP**: Tablas en memoria, muy rápidas.
- **MERGE**: Combina tablas MyISAM idénticas.

#### SQL Server

- **Heap**: Tabla sin índice clusterizado.
- **Clustered Table**: Tabla con índice clusterizado que organiza físicamente los datos.
- **In-Memory OLTP**: Tablas completamente en memoria para alta velocidad de transacciones.
- **Temporal Tables**: Mantienen un historial automático de cambios para auditorías y recuperación.
- **Columnstore**: Optimizado para almacenamiento columnar y análisis de grandes volúmenes de datos.

### 8.2. Índices y Árboles

- Mejoran el rendimiento de consultas mediante punteros a registros.
- Tipos: PRIMARY, UNIQUE, FULLTEXT, COLUMNSTORE.
- Comandos útiles: **EXPLAIN**, **OPTIMIZE TABLE**.

### 8.3. Dispersión (Hashing)

- Manejo de colisiones y sinónimos.
- **Densidad de empaquetamiento (DE)**: Medida de eficiencia del almacenamiento.
- **Granularidad**: Tamaño de los elementos (grueso/fino), afecta concurrencia.
