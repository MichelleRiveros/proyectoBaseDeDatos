
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