--
-- ESTA VISTA  ES UNA HERRAMIENTA ESPECIAL PARA REALIZAR CONSULTAS
-- 
-- Operaciones completas
-- Nombres de departamento, municipio, producto, cantidad, precio y monto 
-- DROP VIEW vista_operaciones
CREATE VIEW vista_operaciones AS
SELECT 	ope.id_registro,
        dep.nombre as departamento, ope.id_departamento, 
       	mun.nombre as municipio,    ope.id_municipio,
       	pro.nombre as producto,     ope.id_producto,
   		ope.fecha,
        ope.cantidad, 
		pro.precio,
	   	ope.cantidad * pro.precio as venta,
		ope.estado
FROM operaciones ope
JOIN departamentos dep on dep.id_departamento = ope.id_departamento
JOIN municipios    mun on mun.id_municipio    = ope.id_municipio
JOIN productos     pro on pro.id_producto     = ope.id_producto
ORDER BY dep.nombre, mun.nombre, pro.nombre

-- Seleccionar los 8 departamentos con mayor volumen de ventas 
-- (monto) de productos ordenados de mayor a menor. 
SELECT departamento, SUM(venta) AS monto_total
FROM vista_operaciones
GROUP BY departamento
ORDER BY monto_total DESC
LIMIT 8;

-- Los 15 municipios con mayor cantidad de productos vendidos en Antioquia
SELECT municipio, SUM(cantidad) AS total_unidades
FROM vista_operaciones
WHERE UPPER(departamento) = 'ANTIOQUIA' -- Esto asegura que encuentre 'Antioquia'
GROUP BY municipio
ORDER BY total_unidades DESC
LIMIT 15;

--Los 5 departamentos con mayor cantidad vendida del producto “MANZALOCA”
SELECT departamento, SUM(cantidad) AS unidades_manzaloca
FROM vista_operaciones
WHERE producto = 'MANZALOCA'
GROUP BY departamento
ORDER BY unidades_manzaloca DESC
LIMIT 5;

--Los 5 municipios con el menor monto ($) de ventas
SELECT departamento, municipio, SUM(venta) AS monto_minimo
FROM vista_operaciones
GROUP BY departamento, municipio
ORDER BY monto_minimo ASC
LIMIT 5;

--Cantidad de gaseosas por cada producto y región
SELECT 
    r.nombre AS region, 
    v.producto, 
    SUM(v.cantidad) AS cantidad_vendida
FROM vista_operaciones v
JOIN regiones r ON v.id_region = r.id_region -- Ahora v.id_region sí existe
GROUP BY r.nombre, v.producto
ORDER BY r.nombre ASC, cantidad_vendida DESC;

--Monto total de ventas de cada producto en Antioquia
SELECT producto, SUM(venta) AS monto_total_antioquia
FROM vista_operaciones
WHERE UPPER(departamento) = 'ANTIOQUIA' -- Convierte el dato a mayúsculas antes de comparar
GROUP BY producto
ORDER BY monto_total_antioquia DESC;

