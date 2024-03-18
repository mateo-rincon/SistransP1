create sequence bancAndes_seq;

CREATE TABLE usuario(
  login VARCHAR(20) PRIMARY KEY,
  clave VARCHAR(20) NOT NULL,
  documento_identidad VARCHAR(20) UNIQUE NOT NULL,
  tipo_documento_identidad VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(20) NOT NULL,
  direccion_electronica VARCHAR(20) NOT NULL, 
  telefono VARCHAR(20) NOT NULL
);

ALTER TABLE usuario 
ADD CONSTRAINT check_tipo_documento_identidad 
CHECK (tipo_documento_identidad IN ('CC','CE','TI'));

CREATE TABLE clientes(
    login VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (login) REFERENCES usuario(login)
);

CREATE TABLE gerente_general(
    login VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (login) REFERENCES usuario(login)
);

CREATE TABLE direcciones_f(
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    PRIMARY KEY (direccion, ciudad, departamento)
)

CREATE TABLE oficinas(
    id_oficina NUMBER GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    num_atencion_posibles INT,
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    CONSTRAINT oficinas_pk PRIMARY KEY (id_oficina),
    FOREIGN KEY (direccion, ciudad, departamento) REFERENCES direcciones_f(direccion, ciudad, departamento)
)

CREATE TABLE empleados(
    login VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (login) REFERENCES usuario(login),
    tipo VARCHAR(20) NOT NULL,
    CONSTRAINT check_tipo_empleado CHECK (tipo IN ('gerente oficina', 'cajero')),
    oficina VARCHAR(20) NOT NULL,
    FOREIGN KEY (oficina) REFERENCES oficinas(id_oficina)
)


CREATE TABLE direccion_usuario(
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    departamento VARCHAR(50),
    login VARCHAR(20),
    FOREIGN KEY (direccion, ciudad, departamento) REFERENCES direcciones_f(direccion, ciudad, departamento),
    FOREIGN KEY (login) REFERENCES usuario(login)
)

CREATE TABLE Productos (
    id_producto NUMBER PRIMARY KEY,
    fechaDeCreacion DATE NOT NULL,
    id_cliente NUMBER NOT NULL,
    id_oficina NUMBER NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id)
)

CREATE TABLE Cuentas (
    id_cuenta NUMBER PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL,
    saldo NUMBER NOT NULL,
    estado VARCHAR2(50) NOT NULL,
    id_producto NUMBER,
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES Producto(id)
)

CREATE TABLE Prestamos (
    id_prestamo NUMBER PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL,
    valor_total NUMBER NOT NULL,
    saldo_pendiente NUMBER NOT NULL,
    cuotas NUMBER NOT NULL,
    cuotas_pendientes NUMBER NOT NULL,
    valor_cuota NUMBER NOT NULL,
    dia_corte NUMBER NOT NULL,
    interes NUMBER NOT NULL,
    id_producto NUMBER,
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES Producto(id),
    CONSTRAINT ck_dia_corte CHECK (dia_corte >= 0),
    CONSTRAINT ck_interes CHECK (interes >= 0)
)

CREATE TABLE Operaciones (
    id_operacion NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    monto NUMBER NOT NULL,
    saldo_final_salida NUMBER NOT NULL,
    saldo_final_entrada NUMBER NOT NULL,
    id_cuenta_llegada NUMBER,
    id_producto_salida NUMBER,
    punto_atencion VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_cuenta_llegada FOREIGN KEY (id_cuenta_llegada) REFERENCES Cuentas(id),
    CONSTRAINT fk_producto_salida FOREIGN KEY (id_producto_salida) REFERENCES Producto(id)
)

CREATE TABLE PuntosAtencion (
    id_punto NUMBER PRIMARY KEY,
    direccion VARCHAR2(100) NOT NULL
)

CREATE TABLE PuntosFisicos (
    id_puntofisico NUMBER PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL,
    oficina NUMBER,
    CONSTRAINT fk_oficina FOREIGN KEY (oficina) REFERENCES Oficina(id)
)

CREATE TABLE PortalesWeb (
    id_portal_web NUMBER PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('web', 'app')),
    id_puntofisico NUMBER NOT NULL,
    CONSTRAINT fk_puntosfisicos FOREIGN KEY (id_puntofisico) REFERENCES PuntosFisicos(id)
)
;
