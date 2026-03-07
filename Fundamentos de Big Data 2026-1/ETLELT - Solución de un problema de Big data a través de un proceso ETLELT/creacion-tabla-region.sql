-- 1. Crear la tabla de regiones
CREATE TABLE regiones (
    id_region INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. Poblar la tabla de regiones según el mapeo del algoritmo
INSERT INTO regiones (id_region, nombre) VALUES 
(1, 'Region Eje Cafetero - Antioquia'),
(2, 'Region Centro Oriente'),
(3, 'Region Centro Sur'),
(4, 'Region Caribe'),
(5, 'Region Llano'),
(6, 'Region Pacifico');

-- 3. Modificar la tabla operaciones para recibir el nuevo ID
ALTER TABLE operaciones ADD COLUMN id_region INTEGER;

