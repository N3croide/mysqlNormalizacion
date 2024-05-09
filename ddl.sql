create table pais(
    id int auto_increment primary key,
    nombre varchar(100) not null
);

create table region(
	id int auto_increment primary key,
	nombre varchar(100) not null,
    id_pais int not null,
    constraint FK_id_pais foreign key(id_pais) references pais(id)
);

create table ciudad(
	id int auto_increment primary key,
	nombre varchar(100) not null,
	id_region int  not null,
	constraint FK_id_region foreign key(id_region) references region(id)
);

create table oficina(
	id int auto_increment primary key,
    cod_postal int(6) not null,
    linea_d1 varchar(100) not null,
    linea_d2 varchar(100),
    id_ciudad int,
    constraint FK_id_ciudad_oficina foreign key(id_ciudad) references ciudad(id)
);

create table empleado(
	cedula int not null primary key,
    nombre varchar(100) not null,
    apellido1 varchar(100) not null,
    apellido2 varchar(100),
    extension int(5) not null,
    puesto varchar(100),
    email varchar(100) not null,
    jefe int,
    id_oficina int,
    constraint FK_cedula_jefe foreign key(jefe) references empleado(cedula),
    constraint FK_id_oficina foreign key(id_oficina) references oficina(id)
);

create table cliente(
    cedula int(10) primary key,
	nombre varchar(100) not null,
	linea_d1 varchar(100) not null,
    linea_d2 varchar(100),
    id_ciudad int not null,
    cedula_empleado int,
    constraint FK_id_ciudad_cliente foreign key(id_ciudad) references ciudad(id),
    constraint FK_id_empleado foreign key(cedula_empleado) references empleado(cedula)
);

create table proveedor(
	nit int(9) primary key,
    nombre varchar(100) not null
);

create table sucursal(
	id int auto_increment primary key,
    direccion varchar(100) not null,
    nit_proveedor int not null,
    id_ciudad int not null,
    constraint FK_nit_proveedor_sucursal foreign key(nit_proveedor) references proveedor(nit),
    constraint FK_id_ciudad_sucursal foreign key(id_ciudad) references ciudad(id)
);

create table tipo_telefono(
	id int auto_increment primary key,
    descripcion varchar(100) not null
);

create table telefono(
    id int auto_increment primary key,
    numero int(15) not null,
    prefijo int(5) not null,
    cedula_cliente int(10) null,
    id_tipo_telefono int not null,
    nit_proveedor int(9) null,
    id_oficina int null,
    constraint FK_id_oficina_telefono foreign key(id_oficina) references oficina(id),
    constraint FK_cedula_cliente_telefono foreign key(cedula_cliente) references cliente(cedula),
    constraint FK_nit_proveedor_telefono foreign key(nit_proveedor) references proveedor(nit),
    constraint FK_id_tipo_telefono foreign key(id_tipo_telefono) references tipo_telefono(id)
);

create table tipo_pago(
	id int auto_increment primary key,
    descripcion varchar(100) not null
);

create table pago(
	id int auto_increment primary key,
    fecha date not null,
    total double not null,
    cedula_cliente int(10) not null,
    id_tipo_pago int not null,
    constraint FK_cedula_cliente_pago foreign key(cedula_cliente) references cliente(cedula),
    constraint FK_id_tipo_pago foreign key(id_tipo_pago) references tipo_pago(id)
);

create table contacto(
	id int auto_increment primary key,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    email varchar(50) null,
    cedula_cliente int(10) null,
    nit_proveedor int(9) null,
    constraint FK_cedula_cliente_contacto foreign key(cedula_cliente) references cliente(cedula),
    constraint FK_nit_proveedor_contacto foreign key(nit_proveedor) references proveedor(nit)
);

create table estado_pedido(
	id int auto_increment primary key,
    descripcion varchar(100) not null 
);

create table gamma_producto(
	id int auto_increment primary key,
    descripcion_txt varchar(200) not null,
    descripcion_html varchar(200) not null,
    imagen varchar(100) not null
);

create table dimensiones(
	id int auto_increment primary key,
    largo int(4) not null,
    ancho int(4) not null,
    alto int(4) null
);

create table producto(
	id int auto_increment primary key,
    nombre varchar(100) not null,
    descripcion varchar(200) null,
    precio_venta double not null,
    precio_proveedor double null,
    id_gamma_producto int not null,
    id_dimensiones int null,
    nit_proveedor int(9) null,
    constraint FK_id_gamma_producto foreign key(id_gamma_producto) references gamma_producto(id),
    constraint FK_id_dimensiones foreign key(id_dimensiones) references dimensiones(id),
    constraint FK_nit_proveedor_prodcuto foreign key(nit_proveedor) references proveedor(nit)
);

create table inventario(
	id int auto_increment primary key,
    stock_mininmo int(6) null,
    stock_maximo int(6) null,
    stock_actual int(6) not null,
    id_producto int not null,
    constraint FK_id_producto_inventario foreign key(id_producto) references producto(id)
);

create table pedido(
	id int auto_increment primary key,
    fecha_pedido date not null,
    fecha_esperada date not null,
    fecha_entrega date null,
    comentarios varchar(200) null,
    id_estado_pedido int not null,
    cedula_cliente int(10) not null,
    constraint FK_cedula_cliente_peido foreign key(cedula_cliente) references cliente(cedula),
    constraint FK_id_estado_pedido foreign key(id_estado_pedido) references estado_pedido(id)
);

create table detalle_pedido(
	id_producto int not null,
    id_pedido int not null,
    cantidad int(6) not null,
    precio_unidad double not null,
    numero_linea int(6) not null,
    primary key(id_producto,id_pedido),
    constraint FK_id_producto_detalle_pedido foreign key(id_producto) references producto(id),
    constraint FK_id_pedido_detalle_pedido foreign key(id_pedido) references pedido(id)
);
