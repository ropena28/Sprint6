--tipos de clientes 
CREATE TABLE Tipos_Cliente(
    TCLI_id INTEGER PRIMARY KEY,
    TCLI_tipo Text NOT NULL UNIQUE,
    TCLI_limites_tranf REAL DEFAULT(0),
    TCLI_comision_tranf REAL DEFAULT(1),
    TCLI_Tarjeta_limit INTEGER DEFAULT(1) CHECK(TCLI_Tarjeta_limit<6)
);

--tipòs de cuentas
CREATE TABLE Tipos_Cuenta(
    TCU_id INTEGER PRIMARY KEY,
    TCU_tipo Text NOT NULL UNIQUE,
    TCU_dinero REAL DEFAULT(0)
);

--marcas de tarjetas
CREATE TABLE Marcas_Tarjeta(
    MT_id INTEGER PRIMARY KEY,
    MT_nombre TEXT UNIQUE NOT NULL
);

CREATE TABLE Tipo_tarjeta(
    Tipo_tarjeta_id Integer PRIMARY KEY,
    Tipo text UNIQUE NOT NULL
);

-- DROP TABLE tarjeta;
CREATE TABLE tarjeta(
    Numero CHAR(20) NOT NULL PRIMARY KEY,
    CVV INTEGER CHECK(CVV<1000) NOT NULL,
    F_Otorgamiento DATETIME NOT NULL DEFAULT (datetime('now','localtime')),
    F_Vencimiento DATETIME NOT NULL,
    fk_Tipo INTEGER NOT NULL,
    fk_Marca INTEGER NOT NULL,
    fk_cliente Integer NOT NULL,
    FOREIGN KEY (fk_Tipo) REFERENCES Tipo_tarjeta(Tipo_tarjeta_id),
    FOREIGN KEY (fk_Marca) REFERENCES Marcas_Tarjeta(MT_id),
    FOREIGN KEY (fk_cliente) REFERENCES cliente(customer_id)
);


-- Generate Marcas tarjetas
INSERT INTO Marcas_Tarjeta (MT_nombre) VALUES('ITBANK CLASSIC');
INSERT INTO Marcas_Tarjeta (MT_nombre) VALUES('ITBANK GOLD');
INSERT INTO Marcas_Tarjeta (MT_nombre) VALUES('ITBANK PLATINUM');
-- Generate Tipos tarjetas 
INSERT INTO Tipo_tarjeta(Tipo) VALUES('CREDITO');
INSERT INTO Tipo_tarjeta(Tipo) VALUES('DEBITO');

CREATE TABLE direcciones(
    direccion_id Integer PRIMARY KEY,
    calle text not null,
    numero text not null,
    ciudad text not null,
    provincia text not null,
    pais text not null,
);
