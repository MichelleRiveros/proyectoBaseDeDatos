
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
(1, 'Juan', 'Pérez', 'González', '123456789', 10, 5000.00, 1),
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
('2024-05-07', '2024-05-10', '2024-05-10', 'Cancelado', 4, 1),
('2024-05-07', '2024-05-10', '2024-01-10', 'Completado', 3, 2),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 3),
('2024-05-07', '2024-05-10', '2024-05-10', 'Cancelado', 4, 4),
('2024-05-07', '2024-05-10', '2024-05-10', 'Cancelado', 4, 5),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 6),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 7),
('2024-05-07', '2024-05-10', '2024-05-10', 'Cancelado', 4, 8),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 9),
('2024-05-07', '2024-05-10', '2024-05-10', 'Cancelado', 4, 10),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 11),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 12),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 13),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 14),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 15),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 16),
('2024-05-07', '2024-05-10', '2024-05-10', 'Pedido en proceso', 1, 17),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 18),
('2024-05-07', '2024-05-10', '2024-05-10', 'Completado', 3, 19),
('2024-05-07', '2024-05-10', '2024-05-10', 'No entregado a tiempo', 5, 20);

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