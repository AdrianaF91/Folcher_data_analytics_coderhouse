# Folcher_data_analytics_coderhouse

# 🛒 Ventas_Tech_DB - Base de Datos Relacional para Retail de Tecnología

## 📌 Descripción del Proyecto
Este proyecto forma parte de la certificación en **Data Analytics** de CoderHouse. Consiste en el diseño e implementación de modelo relacional para la empresa ficticia de retail de tecnología **TechStore** (base de datos `Ventas_Tech_DB`).

El proyecto abarca desde la creación, normalización (3NF) e implementación de la base de datos relacional `Ventas_Tech_DB`, hasta la extracción de métricas ejecutivas clave para responder a preguntas estratégicas de negocio.

---

## 🗂️ Modelo de Datos (Esquema Relacional)

El modelo consta de 4 tablas vinculadas mediante Claves Primarias (PK) y Claves Foráneas (FK):

  [categorias] (1) <--- (N) [productos] (1) <--- (N) [ventas] (N) ---> (1) [clientes]

---

## 🗂️ Tablas y Atributos del Modelo

El esquema relacional está diseñado bajo la Tercera Forma Normal (3NF) y se compone de cuatro tablas vinculadas entre sí:

* **`categorias`** (Tabla Dimensión)
  * `id_categoria` (INT, PRIMARY KEY): Identificador único de la categoría.
  * `nombre_categoria` (VARCHAR(50), NOT NULL): Nombre descriptivo de la línea de productos.
  * `descripcion` (VARCHAR(200)): Detalle o alcance de los artículos contenidos.

* **`clientes`** (Tabla Dimensión)
  * `id_cliente` (INT, PRIMARY KEY): Identificador único del cliente.
  * `nombre` (VARCHAR(100), NOT NULL): Nombre completo o razón social.
  * `email` (VARCHAR(100), UNIQUE): Correo electrónico del cliente.
  * `ciudad` (VARCHAR(50)): Ciudad de residencia o localización de la cuenta.
  * `fecha_registro` (DATE, NOT NULL): Fecha de alta del cliente en el sistema.

* **`productos`** (Tabla Dimensión)
  * `id_producto` (INT, PRIMARY KEY): Identificador único del producto.
  * `nombre_producto` (VARCHAR(100), NOT NULL): Nombre comercial del producto.
  * `id_categoria` (INT, FOREIGN KEY): Referencia a la tabla `categorias`.
  * `precio` (DECIMAL(10,2), NOT NULL): Precio unitario de lista.
  * `stock` (INT, DEFAULT 0): Cantidad disponible en inventario.
  * `activo` (BIT, DEFAULT 1): Disponibilidad del producto.

* **`ventas`** (Tabla de Hechos)
  * `id_venta` (INT, PRIMARY KEY): Identificador único de la transacción.
  * `id_cliente` (INT, FOREIGN KEY): Referencia al cliente que realiza la compra.
  * `id_producto` (INT, FOREIGN KEY): Referencia al producto comercializado.
  * `cantidad` (INT, NOT NULL): Unidades vendidas en la operación.
  * `precio_unitario` (DECIMAL(10,2), NOT NULL): Precio efectivo cobrado por unidad.
  * `fecha_venta` (DATE, NOT NULL): Fecha en la que se registró la transacción.

---

## ## 📊 Entregables e Implementación SQL

### Módulo 3 — Script de Ingeniería de Datos (`ventas_tech_db.sql`)
* **Limpieza del Entorno:** Ejecución de `DROP TABLE IF EXISTS` siguiendo el orden inverso de las dependencias para preservar las restricciones de claves foráneas.
* **Definición DDL:** Creación de tablas e implementación de restricciones `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL` y `UNIQUE`. Configuración de tipos de datos de precisión exacta como `DECIMAL(10,2)` para campos monetarios y `BIT` para banderas lógicas.
* **Carga DML:** Inserción ordenada de datos iniciales que incluye 4 categorías, 5 clientes, 6 productos y 10 transacciones en la tabla de hechos `ventas`.

### Módulo 4 — Consultas SQL de Negocio (`m4_consultas_negocio.sql`)
* **Consulta 1 — Resumen Ejecutivo Mensual:** Agregación por mes para calcular el total facturado (`cantidad * precio_unitario`), el volumen de pedidos y el ticket promedio utilizando las funciones `YEAR()` y `MONTH()`.
* **Consulta 2 — Ranking Top 5 de Productos:** Identificación de los 5 productos con mayor facturación y unidades vendidas mediante `GROUP BY id_producto`, ordenamiento descendente y limitación con `TOP 5`.
* **Consulta 3 — Clientes Recurrentes:** Filtrado de la base de clientes para extraer aquellos con más de una transacción realizada, empleando la cláusula `HAVING COUNT(id_venta) > 1`.
* **Consulta 4 — Desempeño Mensual vs. Promedio General:** Clasificación dinámica de cada mes (`Por encima` / `Por debajo`) respecto al promedio general de ventas del negocio, sin recurrir a clausulas `JOIN`.

## 💡 Principales Hallazgos de Negocio

* **Concentración de la Facturación:** El volumen de ingresos está fuertemente impulsado por artículos de alto valor unitario (como computadoras/laptops), los cuales concentran la mayor parte de la facturación en comparación con los accesorios y periféricos.
* **Comportamiento y Recurrencia de Clientes:** Se identificaron clientes clave con múltiples transacciones en el período analizado, demostrando patrones iniciales de fidelización que habilitan estrategias de retención o venta cruzada.
* **Comportamiento Temporal de las Ventas:** La evaluación mensual contra el promedio general evidencia picos de facturación en períodos específicos (como la primera mitad del mes de marzo), lo que permite planificar mejor las campañas comerciales y el reabastecimiento de inventario.

## 👩‍💻 Autoría y Datos del Proyecto

* **Estudiante:** Adriana Laura Folcher
