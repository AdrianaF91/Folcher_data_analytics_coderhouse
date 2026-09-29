-- =============================================================================
-- ENTREGABLE MÓDULO 4: Consultas SQL de Negocio
-- Archivo: m4_consultas_negocio.sql
-- =============================================================================

USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: Resumen ejecutivo mensual
-- Nota: En SQL Server se utiliza MONTH(fecha_venta) [Equivalente a EXTRACT(MONTH FROM fecha_venta)]
-- -----------------------------------------------------------------------------
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 2: Ranking Top 5 de productos
-- Nota: En SQL Server se utiliza TOP 5 [Equivalente a LIMIT 5]
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
-- -----------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC, total_gastado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima / por debajo del promedio general
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
-- BLOQUE DE CIERRE: Hallazgos de Negocio Concretos y Precisos
-- -----------------------------------------------------------------------------
-- -- Hallazgo 1: Existe un empate exacto en el primer puesto de facturación 
-- --            entre el producto 1 (Laptop Pro 15) y el producto 4 (Auriculares BT Pro), 
-- --            generando cada uno $2.400,00 sobre el total comercializado.
-- -- Hallazgo 2: Los clientes 1, 2, 3, 4 y 5 muestran alta recurrencia en el período, 
-- --            destacándose el cliente 1 con 2 pedidos y una facturación acumulada de $3.600,00.
-- -- Hallazgo 3: El mes de marzo de 2024 acumuló una facturación total de $4.821,00, 
-- --            posicionándose por encima del promedio general de la muestra.