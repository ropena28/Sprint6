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

-- DROP TABLE tarjeta;

CREATE TABLE Tipo_tarjeta(
    Tipo_tarjeta_id Integer PRIMARY KEY,
    Tipo text UNIQUE NOT NULL
);

CREATE TABLE tarjeta(
    Numero CHAR(20) NOT NULL PRIMARY KEY,
    CVV INTEGER CHECK(CVV<1000) NOT NULL,
    F_Otorgamiento DATETIME NOT NULL DEFAULT (datetime('now','localtime')),
    F_Vencimiento DATETIME NOT NULL,
    Tipo INTEGER NOT NULL,
    FOREIGN KEY (Tipo) REFERENCES Tipo_tarjeta(Tipo_tarjeta_id)
);

-- SELECT datetime('now');