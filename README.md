# Folcher_data_analytics_coderhouse

# 🛒 Ventas_Tech_DB - Base de Datos Relacional para Retail de Tecnología

## 📌 Descripción del Proyecto
Este proyecto forma parte de la certificación en **Data Analytics** de CoderHouse. Consiste en el diseño e implementación de modelo relacional para la empresa ficticia de retail de tecnología **TechStore** (base de datos `Ventas_Tech_DB`).

El objetivo principal es estructurar los datos del negocio garantizando la integridad referencial y cumpliendo con la **Tercera Forma Normal (3NF)**, creando un cimiento sólido para los posteriores análisis, transformaciones y tableros en **Power BI**.

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

## 🛠️ Contenido del Script SQL (`script_m3_ventas_tech.sql`)

El script está optimizado para su ejecución en **Microsoft SQL Server** y se estructura en las siguientes secciones ordenadas de manera lógica:

* **Creación y Selección de la Base de Datos**: Inicializa la base de datos `Ventas_Tech_DB` y selecciona el contexto de ejecución.
* **Limpieza de Entorno (`DROP TABLE IF EXISTS`)**: Remueve las tablas existentes respetando el orden inverso de sus dependencias.
* **Definición del Esquema Data Definition Language (DDL)**:
  * Asignación de restricciones de integridad primaria (`PRIMARY KEY`) en cada tabla.
  * Definición de claves foráneas (`FOREIGN KEY`) en `productos` y `ventas` para garantizar la integridad referencial.
  * Aplicación de restricciones `NOT NULL` en atributos indispensables (precios, nombres, fechas) y `UNIQUE` en correos electrónicos.
  * Uso de tipos de datos de precisión exacta como `DECIMAL(10,2)` para importes monetarios y `BIT` para indicadores booleanos.
* **Carga Inicial Data Manipulation Language (DML)**: Inserción secuencial de datos de prueba en las tablas.
* **Consultas de Validación**: Sentencias `SELECT` al final del script para verificar que cada tabla se haya creado e insertado correctamente sin errores.

---

## 👩‍💻 Autoría y Datos del Proyecto

* **Estudiante:** Adriana Laura Folcher
* **Programa:** Certificación en Data Analytics
* **Entregable:** Módulo 3 — Checkpoint: Script SQL de Data Analytics (`Ventas_Tech_DB`)
