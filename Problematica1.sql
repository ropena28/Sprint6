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
    TCU_tipo Text NOT NULL UNIQUE
);
-- TCU_dinero REAL DEFAULT(0)
-- DROP TABLE Tipos_Cuenta;

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
INSERT INTO Marcas_Tarjeta (MT_nombre) 
    VALUES
        ('ITBANK CLASSIC')
        ('ITBANK GOLD'),
        ('ITBANK PLATINUM')
;
-- Generate Tipos tarjetas 
INSERT INTO Tipo_tarjeta(Tipo) 
    VALUES
        ('CREDITO'),
        ('DEBITO')
;

-- DROP TABLE direcciones;
CREATE TABLE direcciones(
    direccion_id Integer PRIMARY KEY,
    calle text not null,
    ciudad text not null,
    provincia text not null,
    pais text not null,
    fk_client_id INTEGER,
    FOREIGN KEY (fk_client_id) REFERENCES cliente(customer_id)
);


-- Modificacion tabla de cuenta para identificar tipo
BEGIN TRANSACTION;
DROP TABLE IF EXISTS new_cuenta;
CREATE TABLE new_cuenta(
    account_id INTEGER PRIMARY KEY NOT NULL,
    customer_id INTEGER NOT NULL,
    balance INTEGER NOT NULL,
    iban text,
    tipo_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES cliente(customer_id),
    FOREIGN KEY (tipo_id) REFERENCES Tipos_Cuenta(TCU_id)
);

ALTER TABLE cuenta ADD tipo_id integer;
INSERT INTO new_cuenta SELECT * FROM cuenta;

DROP TABLE IF EXISTS cuenta;
ALTER TABLE new_cuenta RENAME TO cuenta;

COMMIT;

-- Añadir aleatoriamente un tipo de cuenta a cada registro en cuenta
--    Insertamos los valores que no teniamos
INSERT INTO Tipos_Cuenta (TCU_tipo) 
    VALUES
        ('Caja de ahorro en pesos'),
        ('Caja de ahorro en dólares'),
        ('Cuenta Corriente')
;


UPDATE cuenta SET tipo_id = (
    CASE
        WHEN tipo_id IS NULL THEN abs(random()) % ( SELECT count(*) from Tipos_Cuenta  ) + 1
        ELSE tipo_id
    END
);

-- cambiar formato employee_hire_date tabla empleado
UPDATE empleado set employee_hire_date =(
select 
    substr(employee_hire_date,7, 4) ||'/'|| 
    substr(employee_hire_date,4, 2) ||'/'|| 
    substr(employee_hire_date,1, 2)
);