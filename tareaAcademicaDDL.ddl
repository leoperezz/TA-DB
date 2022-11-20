-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2022-11-20 18:31:42 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE boleta (
    id_comprobante NUMBER(8) NOT NULL,
    id_boleta      NUMBER(8) NOT NULL,
    monto_total    NUMBER(10, 2) NOT NULL
);

ALTER TABLE boleta ADD CONSTRAINT boleta_pk PRIMARY KEY ( id_comprobante );

ALTER TABLE boleta ADD CONSTRAINT boleta_pkv1 UNIQUE ( id_boleta );

CREATE TABLE cargo (
    id_cargo CHAR(5 BYTE) NOT NULL,
    nombre   VARCHAR2(20 BYTE) NOT NULL
);

COMMENT ON COLUMN cargo.id_cargo IS
    'Identificador del cargo:
C -> cocinero
S -> seguridad
L -> Limpieza
CJ -> CAJERO
G -> GERENTE';

COMMENT ON COLUMN cargo.nombre IS
    'Nombre del cargo';

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE carta (
    id_carta    NUMBER(8) NOT NULL,
    fecha       DATE NOT NULL,
    id_platillo NUMBER(8) NOT NULL,
    id_sucursal NUMBER(3) NOT NULL
);

ALTER TABLE carta ADD CONSTRAINT carta_pk PRIMARY KEY ( id_carta );

CREATE TABLE cliente (
    id_cliente NUMBER(8) NOT NULL,
    nombre     VARCHAR2(20 BYTE) NOT NULL,
    ap_materno VARCHAR2(20 BYTE) NOT NULL,
    ap_paterno VARCHAR2(20 BYTE) NOT NULL,
    telefono   VARCHAR2(9 BYTE) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE compra (
    id_sucursal NUMBER(3) NOT NULL,
    id_compra   NUMBER(10) NOT NULL,
    fecha       DATE NOT NULL
);

ALTER TABLE compra ADD CONSTRAINT compra_pk PRIMARY KEY ( id_compra );

CREATE TABLE compra_x_ingred (
    id_compra      NUMBER(10) NOT NULL,
    id_ingrediente NUMBER(8, 2) NOT NULL,
    cantidad       NUMBER(10, 2) NOT NULL
);

ALTER TABLE compra_x_ingred ADD CONSTRAINT compra_x_ingred_pk PRIMARY KEY ( id_compra,
                                                                            id_ingrediente );

CREATE TABLE comprobante_de_pago (
    id_comprobante   NUMBER(8) NOT NULL,
    fecha            DATE NOT NULL,
    total_a_pagar    NUMBER(10, 2) NOT NULL,
    tipo_comprobante CHAR(1 BYTE) NOT NULL,
    id_orden         NUMBER(8) NOT NULL,
    id_cliente       NUMBER(8) NOT NULL
);

COMMENT ON COLUMN comprobante_de_pago.tipo_comprobante IS
    'B -> Boleta
F -> Factura';

CREATE UNIQUE INDEX comprobante_de_pago__idx ON
    comprobante_de_pago (
        id_orden
    ASC );

ALTER TABLE comprobante_de_pago ADD CONSTRAINT comprobante_de_pago_pk PRIMARY KEY ( id_comprobante );

CREATE TABLE empleado (
    id_empleado NUMBER(8) NOT NULL,
    nombre      VARCHAR2(20 BYTE) NOT NULL,
    ap_materno  VARCHAR2(20 BYTE) NOT NULL,
    ap_paterno  VARCHAR2(20 BYTE) NOT NULL,
    id_cargo    CHAR(5 BYTE) NOT NULL,
    id_sucursal NUMBER(3) NOT NULL
);

COMMENT ON COLUMN empleado.id_empleado IS
    'Identificador de cada empleado';

COMMENT ON COLUMN empleado.nombre IS
    'Nombre(s) del empleado';

COMMENT ON COLUMN empleado.ap_materno IS
    'Apellido materno del empleado';

COMMENT ON COLUMN empleado.ap_paterno IS
    'Apellido paterno del empleado';

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE factura (
    id_comprobante NUMBER(8) NOT NULL,
    id_factura     NUMBER(8) NOT NULL,
    monto_total    NUMBER(10, 2) NOT NULL,
    ruc            VARCHAR2(11 BYTE) NOT NULL,
    razon_social   VARCHAR2(20 BYTE) NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_comprobante );

ALTER TABLE factura ADD CONSTRAINT factura_pkv1 UNIQUE ( id_factura );

CREATE TABLE historial_laboral (
    id_historial    NUMBER(8) NOT NULL,
    fecha_ingreso   DATE NOT NULL,
    puesto_inicial  VARCHAR2(50 BYTE) NOT NULL,
    salario_inicial NUMBER(5, 2) NOT NULL,
    salario_actual  NUMBER(5, 2) NOT NULL,
    id_empleado     NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX historial_laboral__idx ON
    historial_laboral (
        id_empleado
    ASC );

ALTER TABLE historial_laboral ADD CONSTRAINT historial_laboral_pk PRIMARY KEY ( id_historial );

CREATE TABLE ingrediente (
    id_ingrediente  NUMBER(8, 2) NOT NULL,
    precio_unitario NUMBER(4, 2) NOT NULL,
    id_unidad       VARCHAR2(50 BYTE) NOT NULL
);

COMMENT ON COLUMN ingrediente.id_ingrediente IS
    'Identificador de cada ingrediente';

COMMENT ON COLUMN ingrediente.precio_unitario IS
    'Precio por unidad del ingrediente';

ALTER TABLE ingrediente ADD CONSTRAINT ingrediente_pk PRIMARY KEY ( id_ingrediente );

CREATE TABLE jornada_laboral (
    id_jornada  NUMBER(8) NOT NULL,
    hora_inicio DATE NOT NULL,
    hora_fin    DATE NOT NULL,
    id_empleado NUMBER(8) NOT NULL
);

COMMENT ON COLUMN jornada_laboral.id_jornada IS
    'Id de la jornada';

ALTER TABLE jornada_laboral ADD CONSTRAINT jornada_laboral_pk PRIMARY KEY ( id_jornada );

CREATE TABLE mesa (
    id_mesa     NUMBER(2) NOT NULL,
    capacidad   NUMBER(2) NOT NULL,
    id_sucursal NUMBER(3) NOT NULL
);

COMMENT ON COLUMN mesa.id_mesa IS
    'Identificador de cada mesa';

ALTER TABLE mesa ADD CONSTRAINT mesa_pk PRIMARY KEY ( id_mesa );

CREATE TABLE orden (
    id_orden    NUMBER(8) NOT NULL,
    id_mesa     NUMBER(2) NOT NULL,
    monto_total NUMBER(10, 2) NOT NULL
);

ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden );

CREATE TABLE pedido (
    id_pedido    NUMBER(8) NOT NULL,
    fecha_pedido DATE NOT NULL,
    id_mesa      NUMBER(2) NOT NULL,
    id_orden     NUMBER(8) NOT NULL
);

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE pedido_x_platillo (
    id_pedido   NUMBER(8) NOT NULL,
    id_platillo NUMBER(8) NOT NULL,
    dia         DATE NOT NULL,
    cantidad    NUMBER(2) NOT NULL,
    nombre      VARCHAR2(30 BYTE) NOT NULL
);

ALTER TABLE pedido_x_platillo ADD CONSTRAINT pedido_x_platillo_pk PRIMARY KEY ( id_pedido,
                                                                                id_platillo );

CREATE TABLE plat_x_ingred (
    id_producto    NUMBER(8) NOT NULL,
    id_ingrediente NUMBER(8, 2) NOT NULL,
    cantidad       NUMBER(10, 2) NOT NULL
);

ALTER TABLE plat_x_ingred ADD CONSTRAINT plat_x_ingred_pk PRIMARY KEY ( id_producto,
                                                                        id_ingrediente );

CREATE TABLE platillo (
    id_platillo NUMBER(8) NOT NULL,
    nombre      VARCHAR2(30 BYTE) NOT NULL,
    precio      NUMBER(4, 2) NOT NULL,
    descripción VARCHAR2(50 BYTE) NOT NULL,
    stock       NUMBER(3) NOT NULL
);

COMMENT ON COLUMN platillo.id_platillo IS
    'Identificador del platillo';

COMMENT ON COLUMN platillo.precio IS
    'Precio del platillo';

COMMENT ON COLUMN platillo.descripción IS
    'Descripción de lo que contiene el producto';

COMMENT ON COLUMN platillo.stock IS
    'Cantida del producto por día';

ALTER TABLE platillo ADD CONSTRAINT platillo_pk PRIMARY KEY ( id_platillo );

CREATE TABLE proveedor (
    id_proveedor NUMBER(8) NOT NULL,
    nombre       VARCHAR2(30 BYTE) NOT NULL,
    ruc          VARCHAR2(11 BYTE) NOT NULL,
    telefono     VARCHAR2(9 BYTE) NOT NULL,
    id_compra    NUMBER(10) NOT NULL
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id_proveedor );

CREATE TABLE suc_x_ingred (
    id_sucursal    NUMBER(3) NOT NULL,
    id_ingrediente NUMBER(8, 2) NOT NULL,
    cantidad       NUMBER(10, 2) NOT NULL
);

ALTER TABLE suc_x_ingred ADD CONSTRAINT suc_x_ingred_pk PRIMARY KEY ( id_sucursal,
                                                                      id_ingrediente );

CREATE TABLE sucursal (
    id_sucursal NUMBER(3) NOT NULL,
    nombre      VARCHAR2(50 BYTE) NOT NULL,
    direccion   VARCHAR2(50 BYTE) NOT NULL,
    telefono    VARCHAR2(9 BYTE) NOT NULL,
    ruc         VARCHAR2(11 BYTE) NOT NULL
);

COMMENT ON COLUMN sucursal.id_sucursal IS
    'Identifcador de cada sucursal';

COMMENT ON COLUMN sucursal.nombre IS
    'Nombre de cada sucursal existente';

COMMENT ON COLUMN sucursal.direccion IS
    'Dirección de cada sucursal';

COMMENT ON COLUMN sucursal.telefono IS
    'Telefono de la sucursal';

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( id_sucursal );

CREATE TABLE unidad_divisoria (
    id_unidad    VARCHAR2(50 BYTE) NOT NULL,
    nombre       VARCHAR2(50 BYTE) NOT NULL,
    id_dimension CHAR(1 BYTE) NOT NULL
);

ALTER TABLE unidad_divisoria ADD CONSTRAINT unidad_divisoria_pk PRIMARY KEY ( id_unidad );

ALTER TABLE boleta
    ADD CONSTRAINT boleta_comprobante_de_pago_fk FOREIGN KEY ( id_comprobante )
        REFERENCES comprobante_de_pago ( id_comprobante );

ALTER TABLE carta
    ADD CONSTRAINT carta_platillo_fk FOREIGN KEY ( id_platillo )
        REFERENCES platillo ( id_platillo );

ALTER TABLE carta
    ADD CONSTRAINT carta_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE compra
    ADD CONSTRAINT compra_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE compra_x_ingred
    ADD CONSTRAINT compra_x_ingred_compra_fk FOREIGN KEY ( id_compra )
        REFERENCES compra ( id_compra );

ALTER TABLE compra_x_ingred
    ADD CONSTRAINT compra_x_ingred_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES ingrediente ( id_ingrediente );

ALTER TABLE comprobante_de_pago
    ADD CONSTRAINT comprobante_de_pago_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE comprobante_de_pago
    ADD CONSTRAINT comprobante_de_pago_orden_fk FOREIGN KEY ( id_orden )
        REFERENCES orden ( id_orden );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE factura
    ADD CONSTRAINT factura_comprobante_de_pago_fk FOREIGN KEY ( id_comprobante )
        REFERENCES comprobante_de_pago ( id_comprobante );

ALTER TABLE historial_laboral
    ADD CONSTRAINT historial_laboral_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE ingrediente
    ADD CONSTRAINT ingred_uni_div_fk FOREIGN KEY ( id_unidad )
        REFERENCES unidad_divisoria ( id_unidad );

ALTER TABLE jornada_laboral
    ADD CONSTRAINT jornada_laboral_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE mesa
    ADD CONSTRAINT mesa_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE orden
    ADD CONSTRAINT orden_mesa_fk FOREIGN KEY ( id_mesa )
        REFERENCES mesa ( id_mesa );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_mesa_fk FOREIGN KEY ( id_mesa )
        REFERENCES mesa ( id_mesa );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_orden_fk FOREIGN KEY ( id_orden )
        REFERENCES orden ( id_orden );

ALTER TABLE pedido_x_platillo
    ADD CONSTRAINT pedido_x_platillo_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE pedido_x_platillo
    ADD CONSTRAINT pedido_x_platillo_platillo_fk FOREIGN KEY ( id_platillo )
        REFERENCES platillo ( id_platillo );

ALTER TABLE plat_x_ingred
    ADD CONSTRAINT plat_x_ingred_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES ingrediente ( id_ingrediente );

ALTER TABLE plat_x_ingred
    ADD CONSTRAINT plat_x_ingred_platillo_fk FOREIGN KEY ( id_producto )
        REFERENCES platillo ( id_platillo );

ALTER TABLE proveedor
    ADD CONSTRAINT proveedor_compra_fk FOREIGN KEY ( id_compra )
        REFERENCES compra ( id_compra );

ALTER TABLE suc_x_ingred
    ADD CONSTRAINT suc_x_ingred_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES ingrediente ( id_ingrediente );

ALTER TABLE suc_x_ingred
    ADD CONSTRAINT suc_x_ingred_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

CREATE OR REPLACE TRIGGER arc_fkarc_1_boleta BEFORE
    INSERT OR UPDATE OF id_comprobante ON boleta
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_comprobante
    INTO d
    FROM
        comprobante_de_pago a
    WHERE
        a.id_comprobante = :new.id_comprobante;

    IF ( d IS NULL OR d <> 'B' ) THEN
        raise_application_error(-20223, 'FK BOLETA_COMPROBANTE_DE_PAGO_FK in Table BOLETA violates Arc constraint on Table COMPROBANTE_DE_PAGO - discriminator column TIPO_COMPROBANTE doesn''t have value ''B'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_factura BEFORE
    INSERT OR UPDATE OF id_comprobante ON factura
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_comprobante
    INTO d
    FROM
        comprobante_de_pago a
    WHERE
        a.id_comprobante = :new.id_comprobante;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223, 'FK FACTURA_COMPROBANTE_DE_PAGO_FK in Table FACTURA violates Arc constraint on Table COMPROBANTE_DE_PAGO - discriminator column TIPO_COMPROBANTE doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             2
-- ALTER TABLE                             49
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
