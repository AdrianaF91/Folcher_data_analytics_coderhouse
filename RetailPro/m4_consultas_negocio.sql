-- =============================================================================
-- ENTREGABLE MÓDULO 4: Consultas SQL de Negocio
-- =============================================================================

USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
-- -----------------------------------------------------------------------------
SELECT 
    YEAR(fecha_venta) AS anio,
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 2: Ranking de productos (Top 5)
-- Top 5 de id_producto por total facturado, mostrando unidades y total generado.
-- -----------------------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 3: Clientes recurrentes
-- Clientes con más de un pedido, mostrando cantidad de pedidos y total gastado.
-- -----------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY cantidad_pedidos DESC, total_gastado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima / por debajo del promedio general
-- Total facturado por mes etiquetado con CASE WHEN respecto al promedio mensual.
-- -----------------------------------------------------------------------------
SELECT 
    mes,
    total_mes,
    promedio_mensual,
    CASE 
        WHEN total_mes >= promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS etiqueta_promedio
FROM (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes,
        AVG(SUM(cantidad * precio_unitario)) OVER () AS promedio_mensual
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS resumen_mensual
ORDER BY mes;
GO

-- -----------------------------------------------------------------------------
-- Hallazgos concretos del análisis
-- -----------------------------------------------------------------------------
-- -- Hallazgo 1: El producto con ID 1 (Laptop Pro 15) concentra la mayor parte de 
-- --            la facturación total del negocio debido a su alto precio unitario 
-- --            en comparación con los periféricos y accesorios.
-- -- Hallazgo 2: Existen clientes recurrentes (como los clientes 1 y 4) que 
-- --            registran múltiples compras en la base de datos transaccional, evidenciando 
-- --            patrones iniciales de fidelización.
-- -- Hallazgo 3: El análisis temporal de marzo de 2024 demuestra que el volumen de 
-- --            ventas se concentra fuertemente en la primera quincena, ubicando a dicho 
-- --            período por encima del promedio general de facturación del período.