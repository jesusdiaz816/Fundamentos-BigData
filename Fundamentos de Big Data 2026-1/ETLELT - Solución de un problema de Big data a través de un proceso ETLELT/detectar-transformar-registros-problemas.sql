ALTER TABLE operaciones 
ADD COLUMN modificado BOOLEAN DEFAULT FALSE,
ADD COLUMN causa VARCHAR(100);

-- Agregamos una columna para explicar qué se arregló
ALTER TABLE operaciones ADD COLUMN causa VARCHAR(100);


-- Formato de fecha válido = "AAAA-MM-DD"
-- Seleccionar los registros con fechas DIFERENTES al formato
SELECT * FROM operaciones WHERE fecha !~ '^\d{4}-\d{2}-\d{2}$';

-- Formato de fecha válido = "AAAA-MM-DD"
-- Seleccionar los registros con fechas IGUALES al formato
SELECT * FROM operaciones WHERE fecha ~ '^\d{4}-\d{2}-\d{2}$';

-- Correción de formato de fecha"
-- Corrección manual de registros específicos
UPDATE operaciones SET fecha = '2024-08-21', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 10001;
UPDATE operaciones SET fecha = '2024-02-08', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 11599;
UPDATE operaciones SET fecha = '2024-07-17', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 12110;
UPDATE operaciones SET fecha = '2024-12-13', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 13945;
UPDATE operaciones SET fecha = '2024-10-28', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 14368;
UPDATE operaciones SET fecha = '2024-09-27', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 15955;
UPDATE operaciones SET fecha = '2024-12-12', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 17125;
UPDATE operaciones SET fecha = '2024-09-09', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 18056;
UPDATE operaciones SET fecha = '2024-02-01', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 16558;
UPDATE operaciones SET fecha = '2024-11-23', modificado = TRUE, causa = 'Formato corregido a AAAA-MM-DD' WHERE id_registro = 19680;

-- CONSULTA: registros donde la cantidad es 0
SELECT id_registro, id_municipio, cantidad 
FROM operaciones 
WHERE cantidad = 0;

UPDATE operaciones ope
SET cantidad = (
    -- Esta subconsulta calcula el promedio del municipio específico
    SELECT ROUND(AVG(cantidad)) 
    FROM operaciones 
    WHERE id_municipio = ope.id_municipio AND cantidad > 0
),
modificado = TRUE,
causa = 'Cantidad 0 imputada por promedio de ventas municipal'
WHERE cantidad = 0;

-- Ahora esta consulta debería devolver 0 registros
SELECT count(*) 
FROM operaciones 
WHERE cantidad = 0;

-- CONSULTA: registros con cantidades menores a cero
SELECT id_registro, cantidad 
FROM operaciones 
WHERE cantidad < 0;


-- CONSULTA: los registros donde el departamento es 0
SELECT id_registro, id_municipio, id_departamento 
FROM operaciones 
WHERE id_departamento = 0;


-- Correción
UPDATE operaciones 
SET id_departamento = CAST(LEFT(CAST(id_municipio AS VARCHAR), 4) AS INTEGER),
    modificado = TRUE, 
    causa = 'ID de departamento recuperado a partir de los primeros 4 dígitos del ID de municipio'
WHERE id_departamento = 0;

-- Esta consulta ahora debe devolver 0 registros
SELECT count(*) 
FROM operaciones 
WHERE id_departamento = 0;

-- CONSULTA: registros de Támesis producto Tamesis 0
SELECT id_registro, id_municipio, id_producto 
FROM operaciones 
WHERE id_municipio = 5705108 AND id_producto = 0;

-- asignarles el código del producto NARANJITA. Según la tabla de productos del script, el ID de NARANJITA es 4
UPDATE operaciones 
SET id_producto = 4, 
    modificado = TRUE, 
    causa = 'Producto NARANJITA asignado por regla de negocio para Támesis'
WHERE id_municipio = 5705108 AND id_producto = 0



Select * from operaciones;
Select * from departamentos;
Select * from municipios;
