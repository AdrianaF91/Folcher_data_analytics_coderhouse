-- =============================================================================
-- ENTREGABLE MÓDULO 5: Consultas con JOINs 
-- =============================================================================

USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: Vista base del proyecto (INNER JOIN)
-- Combina ventas, clientes, productos y categorias en una sola vista.
-- -----------------------------------------------------------------------------
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 2: Clientes sin ventas (LEFT JOIN con WHERE IS NULL)
-- Identifica clientes registrados que aún no han realizado compras.
-- -----------------------------------------------------------------------------
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 3: Productos sin ventas (LEFT JOIN con WHERE IS NULL)
-- Identifica artículos del catálogo que no registraron ninguna venta.
-- -----------------------------------------------------------------------------
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Consolidado por canal (UNION ALL y GROUP BY)
-- Clasifica las ventas agregando la columna de canal de origen y totaliza con GROUP BY.
-- -----------------------------------------------------------------------------
WITH TransaccionesPorCanal AS (
    SELECT 
        id_venta,
        cantidad,
        precio_unitario,
        (cantidad * precio_unitario) AS total_venta,
        'Online' AS canal
    FROM ventas
    WHERE id_venta % 2 = 1 -- Simulación: ventas impares asignadas a Online

    UNION ALL

    SELECT 
        id_venta,
        cantidad,
        precio_unitario,
        (cantidad * precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM ventas
    WHERE id_venta % 2 = 0 -- Simulación: ventas pares asignadas a Presencial
)
SELECT 
    canal,
    COUNT(id_venta) AS cantidad_transacciones,
    SUM(total_venta) AS total_facturado
FROM TransaccionesPorCanal
GROUP BY canal;
GO