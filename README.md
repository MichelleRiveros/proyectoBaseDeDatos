# Proyecto Base De Datos

1. Archivo sql con la estructura de la base de datos:

![image](1.png)}

2. DDL / Creacion de la base de datos:

```mysql

CREATE DATABASE proyecto;
Query OK, 1 row affected (0.07 sec)

SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| normalizacion      |
| performance_schema |
| proyecto           |
| sys                |
| work               |
+--------------------+
7 rows in set (0.00 sec)
```

3. Creacion de las tablas:
```mysql

CREATE TABLE pais(
    id_pais INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_pais)
);

CREATE TABLE region(
    id_region INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_pais INT(11) NOT NULL,
    PRIMARY KEY(id_region),
    CONSTRAINT FK_region_pais FOREIGN KEY (id_pais) REFERENCES 
    pais(id_pais)
);

CREATE TABLE ciudad(
    id_ciudad INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_region INT(11) NOT NULL,
    PRIMARY KEY(id_ciudad),
    CONSTRAINT FK_ciudad_region FOREIGN KEY (id_region) REFERENCES 
    region(id_region)
);

CREATE TABLE direccion(
    id_direccion INT(11) NOT NULL AUTO_INCREMENT,
    linea_direccion VARCHAR(50) NOT NULL,
    barrio VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10),
    id_ciudad INT(11) NOT NULL,
    PRIMARY KEY(id_direccion),
    CONSTRAINT FK_direccion_ciudad FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE proveedor (
    id_proveedor INT(11) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_proveedor)
);

CREATE TABLE proveedor_direccion (
    id_proveedor INT(11) NOT NULL,
    id_direccion INT(11) NOT NULL,
    PRIMARY KEY (id_proveedor, id_direccion),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE oficina (
    id_oficina INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    PRIMARY KEY (id_oficina)
);

CREATE TABLE oficina_direccion (
    id_oficina INT(11) NOT NULL,
    id_direccion INT(11) NOT NULL,
    PRIMARY KEY (id_oficina, id_direccion),
    FOREIGN KEY (id_oficina) REFERENCES oficina(id_oficina),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE gama_producto(
    id_gama INT(11) NOT NULL AUTO_INCREMENT,
    gama VARCHAR (50) NOT NULL,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256),
    PRIMARY KEY (id_gama)
);

CREATE TABLE dimensiones(
    id_dimensiones INT(11) NOT NULL AUTO_INCREMENT,
    alto DECIMAL(5),
    ancho DECIMAL(5),
    profundidad INT(5),
    diametro DECIMAL(5),
    unidad_de_medida VARCHAR(10),
    PRIMARY KEY (id_dimensiones)
);

CREATE TABLE producto (
    id_producto INT(11) NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_producto),
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_proveedor DECIMAL (12,5),
    precio_venta DECIMAL(12,5) NOT NULL,
    id_dimensiones INT(11),
    FOREIGN KEY (id_dimensiones) REFERENCES dimensiones(id_dimensiones),
    id_proveedor INT(11),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    id_gama INT(11) NOT NULL,
    FOREIGN KEY (id_gama) REFERENCES gama_producto(id_gama)
);

CREATE TABLE inventario (
    id_inventario INT(11) NOT NULL AUTO_INCREMENT,
    id_producto INT(11) NOT NULL,
    cantidad_en_stock SMALLINT(6) NOT NULL,
    ubicacion VARCHAR(100), 
    PRIMARY KEY (id_inventario),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE empleado (
    id_empleado INT(11) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    id_oficina INT(11) NOT NULL,
    id_jefe INT(11),
    puesto VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_empleado),
    CONSTRAINT FK_empleado_oficina FOREIGN KEY (id_oficina) REFERENCES 	 
    oficina(id_oficina),
    CONSTRAINT FK_empleado_jefe FOREIGN KEY (id_jefe) REFERENCES 
    empleado(id_empleado)
);

CREATE TABLE contacto (
    id_contacto INT(11) NOT NULL,
    nombre_contacto VARCHAR(50) NOT NULL,
    apellido_contacto VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_contacto)
);

CREATE TABLE cliente (
    id_cliente INT(11) NOT NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    apellido1_cliente VARCHAR(50) NOT NULL,
    apellido2_cliente VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    id_empleado_rep_ventas INT(11),
    limite_credito DECIMAL(15,2),
    id_contacto INT(11),
    PRIMARY KEY (id_cliente),
    CONSTRAINT FK_contacto_cliente FOREIGN KEY (id_contacto) REFERENCES 
    contacto(id_contacto),
    CONSTRAINT FK_cliente_empleado_rep_ventas FOREIGN KEY 
    (id_empleado_rep_ventas) REFERENCES empleado(id_empleado)
);

CREATE TABLE cliente_direccion (
    id_cliente INT(11) NOT NULL,
    id_direccion INT(11) NOT NULL,
    PRIMARY KEY (id_cliente, id_direccion),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE estado_pedido(
    id_estado INT(11)  NOT NULL,
    estado VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_estado)
);

CREATE TABLE pedido (
    id_pedido INT(11) NOT NULL AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    fecha_entrega DATE,
    comentarios TEXT,
    id_estado INT(11) NOT NULL,
    id_cliente INT(11) NOT NULL,
    PRIMARY KEY(id_pedido),
    CONSTRAINT FK_estado_pedido FOREIGN KEY (id_estado) REFERENCES estado_pedido (id_estado),
    CONSTRAINT FK_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_pedido (
    id_pedido INT(11) NOT NULL,
    id_producto INT(11) NOT NULL,
    cantidad INT(11),
    precio_unidad DECIMAL(15,2),
    numero_linea SMALLINT(6),
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE pago(
id_transaccion INT(100) NOT NULL AUTO_INCREMENT,
PRIMARY KEY (id_transaccion),
id_cliente INT(11) NOT NULL,
forma_pago VARCHAR(40) NOT NULL,
fecha_pago DATE NOT NULL,
total DECIMAL(15) NOT NULL,
CONSTRAINT FK_pago_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

mysql> show tables;
+---------------------+
| Tables_in_proyecto  |
+---------------------+
| ciudad              |
| cliente             |
| cliente_direccion   |
| contacto            |
| detalle_pedido      |
| dimensiones         |
| direccion           |
| empleado            |
| estado_pedido       |
| gama_producto       |
| inventario          |
| oficina             |
| oficina_direccion   |
| pago                |
| pais                |
| pedido              |
| producto            |
| proveedor           |
| proveedor_direccion |
| region              |
+---------------------+
20 rows in set (0.00 sec)
```

**DML** / **INSERT**

```mysql

-- Países

INSERT INTO pais (nombre) VALUES
('España'),
('Francia'),
('Italia'),
('Alemania'),
('Portugal'),
('Reino Unido'),
('Estados Unidos'),
('China'),
('Japón'),
('Brasil');

-- Regiones

INSERT INTO region (nombre, id_pais) VALUES
('Madrid', 1),  -- Madrid, España
('Cataluña', 1), -- Cataluña, España
('Île-de-France', 2), -- Île-de-France, Francia
('Lombardía', 3), -- Lombardía, Italia
('Baviera', 4), -- Baviera, Alemania
('Lisboa', 5), -- Lisboa, Portugal
('Londres', 6), -- Londres, Reino Unido
('California', 7), -- California, Estados Unidos
('Shanghái', 8), -- Shanghái, China
('Kantō', 9), -- Kantō, Japón
('São Paulo', 10); -- São Paulo, Brasil

-- Ciudades

INSERT INTO ciudad (nombre, id_region) VALUES
('Madrid', 1),  -- Madrid, España
('Barcelona', 2), -- Barcelona, España
('París', 3), -- París, Francia
('Milán', 4), -- Milán, Italia
('Múnich', 5), -- Múnich, Alemania
('Lisboa', 6), -- Lisboa, Portugal
('Londres', 7), -- Londres, Reino Unido
('Los Ángeles', 8), -- Los Ángeles, Estados Unidos
('Shanghái', 9), -- Shanghái, China
('Tokio', 10), -- Tokio, Japón
('São Paulo', 11); -- São Paulo, Brasil

-- Direccion

INSERT INTO direccion (linea_direccion, barrio, codigo_postal, id_ciudad) VALUES
('Calle Gran Vía, 1', 'Centro', '28013', 1), -- Calle Gran Vía, 1, Centro, Madrid, España
('Avinguda Diagonal, 123', 'Eixample', '08008', 2), -- Avinguda Diagonal, 123, Eixample, Barcelona, España
('Rue de Rivoli, 1', 'Louvre', '75001', 3), -- Rue de Rivoli, 1, Louvre, París, Francia
('Via Monte Napoleone, 1', 'Quadrilatero della moda', '20121', 4), -- Via Monte Napoleone, 1, Quadrilatero della moda, Milán, Italia
('Kardinal-Faulhaber-Straße 1', 'Altstadt-Lehel', '80333', 5), -- Kardinal-Faulhaber-Straße 1, Altstadt-Lehel, Múnich, Alemania
('Rua Augusta, 123', 'Baixa', '1100-048', 6), -- Rua Augusta, 123, Baixa, Lisboa, Portugal
('Buckingham Palace Road, 10', 'Westminster', 'SW1A 1AA', 7), -- Buckingham Palace Road, 10, Westminster, Londres, Reino Unido
('Hollywood Boulevard, 123', 'Hollywood', '90028', 8), -- Hollywood Boulevard, 123, Hollywood, Los Ángeles, Estados Unidos
('Nanjing Road, 123', 'Huangpu', '200003', 9), -- Nanjing Road, 123, Huangpu, Shanghái, China
('Ginza, 1', 'Chūō', '104-0061', 10), -- Ginza, 1, Chūō, Tokio, Japón
('Avenida Paulista, 123', 'Bela Vista', '01310-300', 11); -- Avenida Paulista, 123, Bela Vista, São Paulo, Brasil

-- Proveedor

INSERT INTO proveedor (id_proveedor, telefono, nombre) VALUES
(1, '123456789', 'Proveedor A'),
(2, '987654321', 'Proveedor B'),
(3, '456789123', 'Proveedor C'),
(4, '789123456', 'Proveedor D'),
(5, '321654987', 'Proveedor E');

-- Proveedor_direccion

INSERT INTO proveedor_direccion (id_proveedor, id_direccion) VALUES
(1, 1),  -- Proveedor A -> Calle Gran Vía, 1, Centro, Madrid, España
(2, 2),  -- Proveedor B -> Avinguda Diagonal, 123, Eixample, Barcelona, España
(3, 3),  -- Proveedor C -> Rue de Rivoli, 1, Louvre, París, Francia
(4, 4),  -- Proveedor D -> Via Monte Napoleone, 1, Quadrilatero della moda, Milán, Italia
(5, 5);  -- Proveedor E -> Kardinal-Faulhaber-Straße 1, Altstadt-Lehel, Múnich, Alemania

-- Oficina

INSERT INTO oficina (nombre, telefono) VALUES
('Oficina Central', '123456789'),
('Sucursal Barcelona', '987654321'),
('Sucursal París', '456789123'),
('Sucursal Milán', '789123456'),
('Sucursal Múnich', '321654987');

-- Oficina_direccion

INSERT INTO oficina_direccion (id_oficina, id_direccion) VALUES
(1, 1),  -- Oficina Central -> Calle Gran Vía, 1, Centro, Madrid, España
(2, 2),  -- Sucursal Barcelona -> Avinguda Diagonal, 123, Eixample, Barcelona, España
(3, 3),  -- Sucursal París -> Rue de Rivoli, 1, Louvre, París, Francia
(4, 4),  -- Sucursal Milán -> Via Monte Napoleone, 1, Quadrilatero della moda, Milán, Italia
(5, 5);  -- Sucursal Múnich -> Kardinal-Faulhaber-Straße 1, Altstadt-Lehel, Múnich, Alemania

-- Gama_producto

INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html, imagen) VALUES
('Electrodomésticos', 'Gama de productos relacionados con electrodomésticos.', '<p>Gama de productos relacionados con electrodomésticos.</p>', 'imagen_electrodomesticos.jpg'),
('Muebles', 'Gama de productos relacionados con muebles para el hogar.', '<p>Gama de productos relacionados con muebles para el hogar.</p>', 'imagen_muebles.jpg'),
('Electrónica', 'Gama de productos relacionados con electrónica de consumo.', '<p>Gama de productos relacionados con electrónica de consumo.</p>', 'imagen_electronica.jpg'),
('Juguetes', 'Gama de productos relacionados con juguetes para niños.', '<p>Gama de productos relacionados con juguetes para niños.</p>', 'imagen_juguetes.jpg'),
('Ropa', 'Gama de productos relacionados con ropa y accesorios de moda.', '<p>Gama de productos relacionados con ropa y accesorios de moda.</p>', 'imagen_ropa.jpg'),
('Ornamentales', 'Gama de productos ornamentales para decoración.', '<p>Gama de productos ornamentales para decoración.</p>', 'imagen_ornamentales.jpg');

-- Dimensiones

INSERT INTO dimensiones (alto, ancho, profundidad, diametro, unidad_de_medida) VALUES
(50.0, 30.0, 20.0, NULL, 'cm'),  -- Dimensiones para un electrodoméstico
(200.0, 150.0, 60.0, NULL, 'cm'),  -- Dimensiones para un mueble
(NULL, NULL, NULL, 25.0, 'cm'),  -- Dimensiones para un producto electrónico
(NULL, NULL, NULL, 10.0, 'cm'),  -- Dimensiones para un juguete
(NULL, NULL, NULL, NULL, 'cm'),  -- Dimensiones para un producto de ropa
(NULL, NULL, NULL, NULL, NULL);  -- Dimensiones para un producto ornamental

-- Producto

INSERT INTO producto (nombre, descripcion, precio_proveedor, precio_venta, id_dimensiones, id_proveedor, id_gama) VALUES
('Lavadora', 'Lavadora de carga frontal con capacidad de 8 kg.', 400.00, 599.99, 1, 1, 1),  -- Electrodoméstico
('Sofá', 'Sofá de tres plazas con tapizado de tela.', 300.00, 499.99, 2, 2, 2),  -- Mueble
('Televisor', 'Televisor LED de 55 pulgadas con resolución 4K.', 600.00, 899.99, 3, 3, 3),  -- Electrónica
('Muñeca', 'Muñeca de porcelana con vestido de fiesta.', 20.00, 39.99, 4, 4, 4),  -- Juguete
('Camiseta', 'Camiseta de algodón con estampado de rayas.', 10.00, 24.99, NULL, NULL, 5),  -- Ropa
('Florero', 'Florero de cerámica decorado con motivos florales.', 15.00, 29.99, 6, NULL, 6);  -- Ornamentales

-- Inventario

INSERT INTO inventario (id_producto, cantidad_en_stock, ubicacion) VALUES
(1, 50, 'Almacén 1'),
(2, 100, 'Almacén 2'),
(3, 80, 'Almacén 3'),
(4, 150, 'Almacén 4'),
(5, 200, 'Almacén 5'),  -- Producto de la gama "Ropa"
(6, 200, 'Almacén 6');  -- Producto de la gama "Ornamentales"

-- Empleado

INSERT INTO empleado (id_empleado, nombre, apellido1, apellido2, extension, email, id_oficina, id_jefe, puesto) VALUES
(1, 'John', 'Doe', '', '101', 'john.doe@example.com', 1, NULL, 'CEO'),  -- Jefe de la empresa
(2, 'Jane', 'Smith', '', '102', 'jane.smith@example.com', 1, 1, 'CFO'),  -- Jefe Financiero
(3, 'Michael', 'Johnson', '', '103', 'michael.johnson@example.com', 1, 1, 'COO'),  -- Jefe de Operaciones
(4, 'Emily', 'Brown', '', '104', 'emily.brown@example.com', 2, 1, 'Gerente de Ventas'),  -- Gerente de Ventas
(5, 'David', 'Martinez', '', '105', 'david.martinez@example.com', 2, 4, 'Representante de Ventas'),  -- Representante de Ventas
(6, 'Emma', 'Garcia', '', '106', 'emma.garcia@example.com', 2, 4, 'Representante de Ventas'),  -- Representante de Ventas
(7, 'William', 'Lopez', '', '107', 'william.lopez@example.com', 2, 4, 'Representante de Ventas'),  -- Representante de Ventas
(8, 'Olivia', 'Rodriguez', '', '108', 'olivia.rodriguez@example.com', 2, 4, 'Representante de Ventas'),  -- Representante de Ventas
(9, 'Noah', 'Hernandez', '', '109', 'noah.hernandez@example.com', 3, 1, 'Gerente de Marketing'),  -- Gerente de Marketing
(10, 'Ava', 'Gonzalez', '', '110', 'ava.gonzalez@example.com', 3, 9, 'Analista de Marketing'),  -- Analista de Marketing
(11, 'James', 'Perez', '', '111', 'james.perez@example.com', 3, 9, 'Analista de Marketing'),  -- Analista de Marketing
(12, 'Isabella', 'Torres', '', '112', 'isabella.torres@example.com', 4, 1, 'Gerente de Logística'),  -- Gerente de Logística
(13, 'Alexander', 'Rivera', '', '113', 'alexander.rivera@example.com', 4, 12, 'Supervisor de Almacén'),  -- Supervisor de Almacén
(14, 'Sophia', 'Flores', '', '114', 'sophia.flores@example.com', 4, 12, 'Supervisor de Almacén'),  -- Supervisor de Almacén
(15, 'Mia', 'Sanchez', '', '115', 'mia.sanchez@example.com', 5, 1, 'Gerente de Recursos Humanos');  -- Gerente de Recursos Humanos

-- Contacto

INSERT INTO contacto (id_contacto, nombre_contacto, apellido_contacto) VALUES
(1, 'Juan', 'López'),
(2, 'María', 'García'),
(3, 'Carlos', 'Martínez'),
(4, 'Laura', 'Rodríguez'),
(5, 'Pedro', 'Hernández');

-- Cliente

INSERT INTO cliente (id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, telefono, id_empleado_rep_ventas, limite_credito, id_contacto) VALUES
(1, 'Juan', 'Pérez', 'González', '123456789', 5, 5000.00, 1),
(2, 'Maria', 'López', 'García', '987654321', 6, 8000.00, 2),
(3, 'José',  'Martínez', 'Rodríguez', '555555555', 7, 10000.00, 3),
(4, 'Ana',  'Gómez', 'Fernández', '444444444', 8, 12000.00, 4),
(5, 'Carlos',  'Díaz', 'Hernández', '333333333', 9, 15000.00, 5),
(6, 'Laura',  'Ruiz', 'Jiménez', '222222222', 10, 20000.00, 1),
(7, 'Pedro',  'Sánchez', 'Pérez', '111111111', 11, 25000.00, 2),
(8, 'Sara',  'Gutiérrez', 'López', '999999999', 12, 30000.00, 3),
(9, 'Miguel',  'Torres', 'Martínez', '888888888', 13, 35000.00, 4),
(10, 'Carmen',  'Vásquez', 'Rodríguez', '777777777', 14, 40000.00, 5),
(11, 'Elena',  'Moreno', 'Martínez', '666666666', 15, 45000.00, 1),
(12, 'Francisco',  'Álvarez', 'Sánchez', '555555555', 4, 50000.00, 2),
(13, 'Isabel',  'Jiménez', 'Gutiérrez', '444444444', 3, 55000.00, 3),
(14, 'Daniel',  'Ortega', 'García', '333333333', 2, 60000.00, 4),
(15, 'Lucía',  'Flores', 'Rodríguez', '222222222', 1, 65000.00, 5),
(16, 'Manuel',  'Romero', 'Pérez', '111111111', 10, 70000.00, 1),
(17, 'Rosa',  'Santos', 'Hernández', '999999999', 9, 75000.00, 2),
(18, 'Javier',  'Morales', 'López', '888888888', 8, 80000.00, 3),
(19, 'Silvia',  'Iglesias', 'Martínez', '777777777', 7, 85000.00, 4),
(20, 'Alberto',  'Cruz', 'González', '666666666', 6, 90000.00, 5);

-- Cliente_direccion

INSERT INTO cliente_direccion (id_cliente, id_direccion) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 1),
(13, 5),
(14, 3),
(15, 7),
(16, 8),
(17, 10),
(18, 6),
(19, 9),
(20, 4);

-- Estado

INSERT INTO estado_pedido (id_estado, estado) VALUES
(1, 'En proceso'),
(2, 'En espera'),
(3, 'Completado'),
(4, 'Cancelado'),
(5, 'No entregado a tiempo');

-- Pedido

INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, comentarios, id_estado, id_cliente) VALUES
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 1),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 2),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 3),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 4),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 5),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 6),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 7),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 8),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 9),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 10),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 11),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 12),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 13),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 14),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 15),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 16),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 17),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 18),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 19),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 5, 20);

-- Detalle_pedido

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unidad, numero_linea) VALUES
(1, 1, 1, 599.99, 1),  -- Cliente 1: Lavadora
(2, 2, 1, 499.99, 1),  -- Cliente 2: Sofá
(3, 3, 1, 899.99, 1),  -- Cliente 3: Televisor
(4, 4, 1, 39.99, 1),   -- Cliente 4: Muñeca
(5, 5, 1, 24.99, 1),   -- Cliente 5: Camiseta
(6, 6, 1, 29.99, 1),   -- Cliente 6: Florero
(7, 1, 1, 599.99, 1),  -- Cliente 7: Lavadora
(8, 2, 1, 499.99, 1),  -- Cliente 8: Sofá
(9, 3, 1, 899.99, 1),  -- Cliente 9: Televisor
(10, 4, 1, 39.99, 1),  -- Cliente 10: Muñeca
(11, 5, 1, 24.99, 1),  -- Cliente 11: Camiseta
(12, 6, 1, 29.99, 1),  -- Cliente 12: Florero
(13, 1, 1, 599.99, 1), -- Cliente 13: Lavadora
(14, 2, 1, 499.99, 1), -- Cliente 14: Sofá
(15, 3, 1, 899.99, 1), -- Cliente 15: Televisor
(16, 4, 1, 39.99, 1),  -- Cliente 16: Muñeca
(17, 5, 1, 24.99, 1),  -- Cliente 17: Camiseta
(18, 6, 1, 29.99, 1),  -- Cliente 18: Florero
(19, 1, 1, 599.99, 1), -- Cliente 19: Lavadora
(20, 2, 1, 499.99, 1); -- Cliente 20: Sofá

-- Pago

INSERT INTO pago (id_cliente, forma_pago, fecha_pago, total) VALUES
(1, 'Efectivo', '2022-05-01', 599.99),
(2, 'Tarjeta de crédito', '2024-05-02', 499.99),
(3, 'Transferencia bancaria', '2024-05-03', 899.99),
(4, 'Cheque', '2020-01-04', 39.99),
(5, 'Efectivo', '2022-05-05', 24.99),
(6, 'Tarjeta de crédito', '2024-05-06', 29.99),
(7, 'PayPal', '2008-03-07', 599.99),
(8, 'PayPal', '2024-01-08', 499.99),
(9, 'PayPal', '2024-05-09', 899.99),
(10, 'PayPal', '2024-05-10', 39.99),
(11, 'PayPal', '2008-01-11', 24.99),
(12, 'PayPal', '2024-05-12', 29.99),
(13, 'Efectivo', '2021-05-13', 599.99),
(14, 'Tarjeta de crédito', '2014-05-14', 499.99),
(15, 'Transferencia bancaria', '2015-05-15', 899.99),
(16, 'Cheque', '2024-05-16', 39.99),
(17, 'Efectivo', '2024-05-17', 24.99),
(18, 'Tarjeta de crédito', '2024-05-18', 29.99),
(19, 'PayPal', '2024-05-19', 599.99),
(20, 'PayPal', '2024-05-20', 499.99);
```

**Consultas sobre una tabla**

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

```mysql
SELECT oficina.id_oficina, c.nombre as Ciudad
FROM oficina_direccion as oficina 
RIGHT JOIN direccion as d ON d.id_ciudad = oficina.id_direccion 
INNER JOIN ciudad as c ON c.id_ciudad = d.id_ciudad
WHERE oficina.id_oficina IS NOT NULL;

+------------+-----------+
| id_oficina | Ciudad    |
+------------+-----------+
|          1 | Madrid    |
|          2 | Barcelona |
|          3 | París     |
|          4 | Milán     |
|          5 | Múnich    |
+------------+-----------+
5 rows in set (0.00 sec)
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```mysql
SELECT ofidi.id_oficina, c.nombre, ofi.telefono 
FROM oficina_direccion ofidi JOIN direccion as d ON d.id_ciudad = ofidi.id_direccion 
INNER JOIN ciudad as c ON c.id_ciudad = d.id_ciudad  
JOIN oficina as ofi ON ofi.id_oficina = ofidi.id_oficina
JOIN region as rg ON rg.id_region = c.id_region
JOIN pais pa  ON rg.id_pais = pa.id_pais
WHERE pa.nombre = 'España';

+------------+-----------+-----------+
| id_oficina | nombre    | telefono  |
+------------+-----------+-----------+
|          1 | Madrid    | 123456789 |
|          2 | Barcelona | 987654321 |
+------------+-----------+-----------+
2 rows in set (0.00 sec)
  ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

```mysql
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE id_jefe = 7;

Empty set (0.00 sec)
  ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.

```mysql
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE puesto = "CEO";

+--------+-----------+-----------+----------------------+
| nombre | apellido1 | apellido2 | email                |
+--------+-----------+-----------+----------------------+
| John   | Doe       |           | john.doe@example.com |
+--------+-----------+-----------+----------------------+
1 row in set (0.00 sec)
  ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.

```mysql
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE puesto = "Representante de Ventas";

+---------+-----------+-----------+------------------------------+
| nombre  | apellido1 | apellido2 | email                        
+---------+-----------+-----------+------------------------------+
| David   | Martinez  |           | david.martinez@example.com   |
| Emma    | Garcia    |           | emma.garcia@example.com      |
| William | Lopez     |           | william.lopez@example.com    |
| Olivia  | Rodriguez |           | olivia.rodriguez@example.com |
+---------+-----------+-----------+------------------------------+
4 rows in set (0.00 sec)
  ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

```mysql
SELECT cliente.nombre_cliente
FROM cliente
JOIN cliente_direccion ON cliente.id_cliente = cliente_direccion.id_cliente
JOIN direccion ON cliente_direccion.id_direccion = direccion.id_direccion
JOIN ciudad ON direccion.id_ciudad = ciudad.id_ciudad
JOIN region ON ciudad.id_region = region.id_region
JOIN pais ON region.id_pais = pais.id_pais
WHERE pais.nombre = 'España';

+----------------+
| nombre_cliente |
+----------------+
| Juan           |
| Francisco      |
| María          |
+----------------+
3 rows in set (0.00 sec)
  ```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
   
```mysql
SELECT estado FROM estado_pedido;
+------------+
| estado     |
+------------+
| En proceso |
| En espera  |
| Completado |
| Cancelado  |
+------------+
4 rows in set (0.00 sec)
  ```

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

- YEAR:
```mysql
SELECT DISTINCT id_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

+------------+
| id_cliente |
+------------+
|          7 |
|         11 |
+------------+
2 rows in set (0.00 sec)
  ```

- DATE_FORMAT:
```mysql
SELECT DISTINCT id_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

+------------+
| id_cliente |
+------------+
|          7 |
|         11 |
+------------+
2 rows in set (0.00 sec)
  ```

- Sin utilizar ninguna de las funciones anteriores:
```mysql
SELECT DISTINCT pago.id_cliente
FROM pago
JOIN cliente ON pago.id_cliente = cliente.id_cliente
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';

+------------+
| id_cliente |
+------------+
|          7 |
|         11 |
+------------+
2 rows in set (0.00 sec)
  ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.

```mysql
SELECT p.id_pedido, p.id_cliente, p.fecha_esperada, p.fecha_entrega
FROM pedido as p
JOIN estado_pedido as e ON e.id_estado = p.id_estado 
WHERE e.estado = "no entregado a tiempo";

+-----------+------------+----------------+---------------+
| id_pedido | id_cliente | fecha_esperada | fecha_entrega |
+-----------+------------+----------------+---------------+
|        20 |         20 | 2024-05-10     | 2024-05-10    |
+-----------+------------+----------------+---------------+
1 row in set (0.00 sec)
  ```

