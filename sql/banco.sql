#Creación de la base de datos banco
CREATE DATABASE banco;

#Selección de la base de datos sobre la cual se van a hacer modificaciones
USE banco;

#-------------------------------------------------------------------------

#Creación de tablas para las Entidades y Relaciones.
    
    CREATE TABLE Ciudad (
        cod_postal SMALLINT unsigned NOT NULL,
        nombre VARCHAR(45) NOT NULL,
        check (cod_postal<10000),

        CONSTRAINT pk_Ciudad
        PRIMARY KEY (cod_postal)
    ) ENGINE = InnoDB;

    CREATE TABLE Sucursal (
        nro_suc SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
        nombre VARCHAR(45) NOT NULL, 
        direccion VARCHAR(45) NOT NULL,
        telefono VARCHAR(20) NOT NULL, 
        horario VARCHAR(50) NOT NULL,  
        cod_postal SMALLINT UNSIGNED NOT NULL, 
         
        CONSTRAINT pk_Sucursal
        PRIMARY KEY (nro_suc),

        CONSTRAINT FK_Sucursal_cod_postal 
        FOREIGN KEY (cod_postal) REFERENCES Ciudad (cod_postal) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;

    CREATE TABLE Empleado (
        legajo SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
        apellido VARCHAR(45) NOT NULL,
        nombre VARCHAR(45) NOT NULL,
        tipo_doc VARCHAR(20) NOT NULL, 
        nro_doc INT UNSIGNED NOT NULL,
        direccion VARCHAR(45) NOT NULL,
        telefono VARCHAR(20) NOT NULL,
        cargo VARCHAR(45) NOT NULL,
        password VARCHAR(32) NOT NULL,
        nro_suc SMALLINT UNSIGNED NOT NULL,
        check(nro_doc<100000000),
        
        CONSTRAINT pk_Empleado
        PRIMARY KEY (legajo),

        CONSTRAINT FK_Empleado_nro_suc
        FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Cliente (
        nro_cliente MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT, 
        apellido VARCHAR(45) NOT NULL, 
        nombre VARCHAR(45) NOT NULL, 
        tipo_doc VARCHAR(20) NOT NULL, 
        nro_doc INT UNSIGNED NOT NULL, 
        direccion VARCHAR(45) NOT NULL,
        telefono VARCHAR(20) NOT NULL, 
        fecha_nac DATE NOT NULL,  
        check(nro_doc<100000000),
         
        CONSTRAINT pk_Cliente
        PRIMARY KEY (nro_cliente)
    ) ENGINE=InnoDB;

    CREATE TABLE Plazo_Fijo (
        nro_plazo INT UNSIGNED NOT NULL AUTO_INCREMENT,
        capital DECIMAL(16,2) UNSIGNED NOT NULL,
        fecha_inicio DATE NOT NULL,
        fecha_fin DATE NOT NULL,
        tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL,
        interes DECIMAL(16,2) UNSIGNED NOT NULL,
        nro_suc SMALLINT UNSIGNED NOT NULL,

        CONSTRAINT pk_Plazo_Fijo
        PRIMARY KEY (nro_plazo),

        CONSTRAINT FK_Plazo_Fijo_nro_suc
        FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Tasa_Plazo_Fijo (
        periodo SMALLINT UNSIGNED NOT NULL, 
        monto_inf DECIMAL(16,2) UNSIGNED NOT NULL, 
        monto_sup DECIMAL(16,2) UNSIGNED NOT NULL, 
        tasa DECIMAL(4,2) UNSIGNED NOT NULL, 
        check(periodo<1000),
       
        CONSTRAINT pk_Taza_Plazo_Fijo
        PRIMARY KEY (periodo,monto_inf,monto_sup)
    ) ENGINE=InnoDB;
    
    CREATE TABLE Plazo_Cliente (
        nro_plazo INT UNSIGNED NOT NULL,
        nro_cliente MEDIUMINT UNSIGNED NOT NULL,

        CONSTRAINT pk_Plazo_Cliente
        PRIMARY KEY (nro_plazo,nro_cliente),

        CONSTRAINT FK_Plazo_Cliente_nro_plazo
        FOREIGN KEY (nro_plazo) REFERENCES Plazo_Fijo (nro_plazo)
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Plazo_Cliente_nro_cliente
        FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Prestamo (
        nro_prestamo INT UNSIGNED NOT NULL AUTO_INCREMENT, 
        fecha DATE NOT NULL,
        cant_meses TINYINT UNSIGNED NOT NULL,
        monto DECIMAL(10,2) UNSIGNED NOT NULL, 
        tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL, 
        interes DECIMAL(9,2) UNSIGNED NOT NULL, 
        valor_cuota DECIMAL(9,2) UNSIGNED NOT NULL, 
        legajo SMALLINT UNSIGNED NOT NULL,
        nro_cliente MEDIUMINT(5) UNSIGNED NOT NULL, 
        check(cant_meses<100),
         
        CONSTRAINT pk_Prestamo
        PRIMARY KEY (nro_prestamo),

        CONSTRAINT FK_Prestamo_legajo 
        FOREIGN KEY (legajo) REFERENCES Empleado (legajo) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Prestamo_nro_cliente 
        FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;   

    CREATE TABLE Pago (
        nro_prestamo INT UNSIGNED NOT NULL,
        nro_pago TINYINT UNSIGNED NOT NULL,
        fecha_venc DATE NOT NULL,
        fecha_pago DATE,
        check(nro_pago<100),

        CONSTRAINT pk_Pago
        PRIMARY KEY (nro_prestamo,nro_pago),

        CONSTRAINT FK_Pago_nro_prestamo
        FOREIGN KEY (nro_prestamo) REFERENCES Prestamo (nro_prestamo)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Tasa_Prestamo (
        periodo SMALLINT UNSIGNED NOT NULL, 
        monto_inf DECIMAL(10,2) UNSIGNED NOT NULL, 
        monto_sup DECIMAL(10,2) UNSIGNED NOT NULL, 
        tasa DECIMAL(4,2) UNSIGNED NOT NULL, 
        check(periodo<1000),
       
        CONSTRAINT pk_Taza_Prestamo
        PRIMARY KEY (periodo,monto_inf,monto_sup)
    ) ENGINE=InnoDB;   

    CREATE TABLE Caja_Ahorro (
        nro_ca INT UNSIGNED NOT NULL AUTO_INCREMENT,
        CBU BIGINT UNSIGNED NOT NULL,
        saldo DECIMAL(16,2) UNSIGNED NOT NULL,
        check(CBU<1000000000000000000),
        
        CONSTRAINT pk_Caja_Ahorro
        PRIMARY KEY (nro_ca)
    ) ENGINE = InnoDB;
    
    CREATE TABLE Cliente_CA (
        nro_cliente MEDIUMINT UNSIGNED NOT NULL, 
        nro_ca INT UNSIGNED NOT NULL,
       
        CONSTRAINT pk_Cliente_CA
        PRIMARY KEY (nro_cliente,nro_ca),
        
        CONSTRAINT FK_Cliente_CA_nro_cliente
        FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
            ON DELETE RESTRICT ON UPDATE CASCADE,
            
        CONSTRAINT FK_Cliente_CA_nro_ca
        FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro (nro_ca)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=INNODB;

    CREATE TABLE Tarjeta (
        nro_tarjeta BIGINT unsigned NOT NULL AUTO_INCREMENT,
        PIN VARCHAR(32) NOT NULL, 
        CVT VARCHAR(32) NOT NULL,
        fecha_venc DATE NOT NULL,
        nro_cliente MEDIUMINT unsigned NOT NULL,
        nro_ca INT unsigned NOT NULL,
        
        CONSTRAINT pk_Tarjeta
        PRIMARY KEY (nro_tarjeta),

        CONSTRAINT FK_Tarjeta_nro_cliente_nro_ca
        FOREIGN KEY (nro_cliente,nro_ca) REFERENCES Cliente_CA (nro_cliente,nro_ca)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Caja (
        cod_caja MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,  
       
        CONSTRAINT pk_Caja
        PRIMARY KEY (cod_caja)
    ) ENGINE=InnoDB;

    CREATE TABLE Ventanilla (
        cod_caja MEDIUMINT UNSIGNED NOT NULL,
        nro_suc SMALLINT UNSIGNED NOT NULL,

        CONSTRAINT pk_Ventanilla
        PRIMARY KEY (cod_caja),

        CONSTRAINT FK_Ventanilla_cod_caja
        FOREIGN KEY (cod_caja) REFERENCES Caja (cod_caja)
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Ventanilla_nro_suc
        FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE ATM (
        cod_caja MEDIUMINT UNSIGNED NOT NULL,  
        cod_postal SMALLINT UNSIGNED NOT NULL, 
        direccion VARCHAR(20) NOT NULL,
       
        CONSTRAINT pk_ATM
        PRIMARY KEY (cod_caja),

        CONSTRAINT FK_ATM_cod_caja
        FOREIGN KEY (cod_caja) REFERENCES Caja (cod_caja) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_ATM_cod_postal
        FOREIGN KEY (cod_postal) REFERENCES Ciudad (cod_postal) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;

    CREATE TABLE Transaccion (
        nro_trans BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, 
        fecha DATE NOT NULL, 
        hora TIME NOT NULL,
        monto DECIMAL(16,2) UNSIGNED NOT NULL,

        CONSTRAINT pk_Transaccion
        PRIMARY KEY (nro_trans)
    ) ENGINE = InnoDB;

    CREATE TABLE Debito (
        nro_trans BIGINT UNSIGNED NOT NULL,  
        descripcion TINYTEXT,
        nro_cliente MEDIUMINT UNSIGNED NOT NULL, 
        nro_ca INT UNSIGNED NOT NULL, 
       
        CONSTRAINT pk_Debito
        PRIMARY KEY (nro_trans),
        
        CONSTRAINT FK_Debito_nro_trans
        FOREIGN KEY (nro_trans) REFERENCES Transaccion (nro_trans)
            ON DELETE RESTRICT ON UPDATE CASCADE,
       
        CONSTRAINT FK_Debito_nro_cliente_nro_ca
        FOREIGN KEY (nro_cliente, nro_ca) REFERENCES Cliente_CA (nro_cliente, nro_ca) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;   

    CREATE TABLE Transaccion_por_caja (
        nro_trans BIGINT unsigned NOT NULL,  
        cod_caja MEDIUMINT unsigned NOT NULL,

        CONSTRAINT pk_Transaccion_por_caja
        PRIMARY KEY (nro_trans),

        CONSTRAINT FK_Transaccion_por_caja_nro_trans
        FOREIGN KEY (nro_trans) REFERENCES Transaccion (nro_trans)
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Transaccion_por_caja_cod_caja
        FOREIGN KEY (cod_caja) REFERENCES Caja (cod_caja)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Deposito (
        nro_trans BIGINT UNSIGNED NOT NULL,  
        nro_ca INT UNSIGNED NOT NULL, 
       
        CONSTRAINT pk_Deposito
        PRIMARY KEY (nro_trans),

        CONSTRAINT FK_Deposito_nro_trans
        FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja (nro_trans) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Deposito_nro_ca
        FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro (nro_ca) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;   

    CREATE TABLE Extraccion (
        nro_trans BIGINT UNSIGNED NOT NULL,  
        nro_cliente MEDIUMINT UNSIGNED NOT NULL,
        nro_ca INT unsigned NOT NULL,

        CONSTRAINT pk_Extraccion
        PRIMARY KEY (nro_trans),

        CONSTRAINT FK_Extraccion_nro_trans
        FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja (nro_trans)
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Extraccion_nro_cliente_nro_ca
        FOREIGN KEY (nro_cliente,nro_ca) REFERENCES Cliente_CA (nro_cliente,nro_ca)
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE = InnoDB;

    CREATE TABLE Transferencia (
        nro_trans BIGINT UNSIGNED NOT NULL,  
        nro_cliente MEDIUMINT UNSIGNED NOT NULL, 
        origen INT UNSIGNED NOT NULL, 
        destino INT UNSIGNED NOT NULL, 
       
        CONSTRAINT pk_Transferencia
        PRIMARY KEY (nro_trans),

        CONSTRAINT FK_Transferencia_nro_trans
        FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja (nro_trans) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Transferencia_nro_cliente_origen
        FOREIGN KEY (nro_cliente, origen) REFERENCES Cliente_CA (nro_cliente, nro_ca) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        CONSTRAINT FK_Transferencia_destino
        FOREIGN KEY (destino) REFERENCES Caja_Ahorro (nro_ca) 
            ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB;     
    
#-------------------------------------------------------------------------

#Creación de vistas.

	CREATE VIEW debitos AS
    SELECT nro_ca, saldo, nro_trans, fecha, hora, "Debito" AS tipo, monto, NULL AS cod_caja, nro_cliente, tipo_doc, nro_doc, nombre, apellido, NULL AS destino
    FROM ((Debito NATURAL JOIN Caja_Ahorro) NATURAL JOIN Transaccion) NATURAL JOIN Cliente;

    CREATE VIEW transferencias AS
    SELECT nro_ca, saldo, nro_trans, fecha, hora, "Transferencia" AS tipo, monto, cod_caja, nro_cliente, tipo_doc, nro_doc, nombre, apellido, destino
    FROM ((((Transferencia NATURAL JOIN Cliente_CA) NATURAL JOIN Transaccion) NATURAL JOIN Cliente) NATURAL JOIN transaccion_por_caja) NATURAL JOIN Caja_Ahorro
	 WHERE origen = nro_ca;

    CREATE VIEW extracciones AS
    SELECT nro_ca, saldo, nro_trans, fecha, hora, "Extraccion" AS tipo, monto, cod_caja, nro_cliente, tipo_doc, nro_doc, nombre, apellido, NULL AS destino
    FROM (((Extraccion NATURAL JOIN Caja_Ahorro) NATURAL JOIN Transaccion) NATURAL JOIN Cliente) NATURAL JOIN Transaccion_por_caja;
    
    CREATE VIEW depositos AS
    SELECT nro_ca, saldo, nro_trans, fecha, hora, "Deposito" AS tipo, monto, cod_caja, NULL AS nro_cliente, NULL AS tipo_doc, NULL AS nro_doc, NULL AS nombre, NULL AS apellido, NULL AS destino
    FROM ((Deposito NATURAL JOIN Caja_Ahorro) NATURAL JOIN Transaccion) NATURAL JOIN Transaccion_por_caja;

    #Unión de todas las subvistas anteriores
    CREATE VIEW trans_cajas_ahorro AS 
    (SELECT DISTINCT * FROM debitos UNION ALL SELECT * FROM transferencias UNION ALL SELECT * FROM extracciones UNION ALL SELECT * FROM depositos);

#-------------------------------------------------------------------------

#Creación de stored procedures.

delimiter !
CREATE PROCEDURE transferir(IN caja_origen INT, IN caja_destino INT, IN monto DECIMAL(16,2),IN codigoATM mediumint)
BEGIN
    DECLARE saldo_actual_origen DECIMAL(16,2);
    DECLARE nro_cliente_origen MEDIUMINT;
    DECLARE id_trans BIGINT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
        SELECT 'SQLEXCEPTION, transaccion abortada' AS resultado;
        ROLLBACK;
    END;
    START TRANSACTION;
    IF EXISTS (SELECT * FROM Caja_Ahorro WHERE nro_ca = caja_origen) AND 
       EXISTS (SELECT * FROM Caja_Ahorro WHERE nro_ca = caja_destino) THEN
        SELECT saldo INTO saldo_actual_origen
        FROM Caja_Ahorro 
        WHERE nro_ca = caja_origen FOR UPDATE;
   
        IF saldo_actual_origen >= monto THEN   
            UPDATE Caja_Ahorro SET saldo = saldo - monto WHERE nro_ca = caja_origen;
            UPDATE Caja_Ahorro SET saldo = saldo + monto WHERE nro_ca = caja_destino;
            SELECT nro_cliente INTO nro_cliente_origen 
            FROM CLIENTE_CA 
            WHERE nro_ca = caja_origen;
            INSERT INTO Transaccion(fecha,hora,monto) VALUES(CURDATE(),CURTIME(),monto);
            SELECT DISTINCT LAST_INSERT_ID() INTO id_trans;
            INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(id_trans,codigoATM);
            INSERT INTO Transferencia(nro_trans,nro_cliente,origen,destino) VALUES(id_trans,nro_cliente_origen,caja_origen,caja_destino);
            INSERT INTO DEPOSITO(nro_trans,nro_ca) VALUES(id_trans,caja_destino);
			SELECT 'Transferencia Exitosa' AS resultado;
        ELSE
            SELECT 'Saldo insuficiente para realizar la transferencia' AS resultado;
        END IF;
    ELSE  
        SELECT 'Error: cuenta inexistente.' AS resultado;
    END IF;
    COMMIT;
END; !

CREATE PROCEDURE extraer(IN caja INT, IN monto DECIMAL(16,2),IN codigoATM mediumint)
BEGIN
    DECLARE saldo_actual DECIMAL(16,2);
    DECLARE nro_cliente_actual MEDIUMINT;
    DECLARE id_trans BIGINT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
        SELECT 'SQLEXCEPTION, transaccion abortada' AS resultado;
        ROLLBACK;
    END;
    START TRANSACTION;
    IF EXISTS (SELECT * FROM Caja_Ahorro WHERE nro_ca = caja) THEN
        SELECT saldo INTO saldo_actual
        FROM Caja_Ahorro 
        WHERE nro_ca = caja FOR UPDATE;
   
        IF saldo_actual >= monto THEN   
            UPDATE Caja_Ahorro SET saldo = saldo - monto WHERE nro_ca = caja;
            SELECT nro_cliente INTO nro_cliente_actual 
            FROM CLIENTE_CA 
            WHERE nro_ca = caja;
            INSERT INTO Transaccion(fecha,hora,monto) VALUES(CURDATE(),CURTIME(),monto);
            SELECT DISTINCT LAST_INSERT_ID() INTO id_trans;
            INSERT INTO TRANSACCION_POR_CAJA(nro_trans,cod_caja) VALUES(id_trans,codigoATM);
            INSERT INTO EXTRACCION(nro_trans,nro_cliente,nro_ca) VALUES(id_trans,nro_cliente_actual,caja);
            SELECT 'Extraccion Exitosa' AS resultado;
        ELSE
            SELECT 'Saldo insuficiente para realizar la extraccion' AS resultado;
        END IF;
    ELSE  
        SELECT 'Error: cuenta inexistente.' AS resultado;
    END IF;
    COMMIT;
END; !

CREATE TRIGGER crear_pagos
AFTER INSERT ON Prestamo
FOR EACH ROW
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= NEW.cant_meses DO
       INSERT INTO Pago(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES(NEW.nro_prestamo, i, DATE_ADD(NEW.fecha, interval i month), NULL);
       SET i = i + 1;
    END WHILE;
END; !

delimiter ;

#-------------------------------------------------------------------------

#Creación de usuarios y otorgamiento de privilegios.

#Usuario admin.

    #CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
    GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

#Usuario empleado.

    #CREATE USER 'empleado'@'%' IDENTIFIED BY 'empleado';
    GRANT SELECT ON banco.Empleado TO 'empleado'@'%';
    GRANT SELECT ON banco.Sucursal TO 'empleado'@'%';
    GRANT SELECT ON banco.Tasa_Plazo_Fijo TO 'empleado'@'%';
    GRANT SELECT ON banco.Tasa_Prestamo  TO 'empleado'@'%';

    GRANT SELECT, INSERT ON banco.Prestamo TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.Plazo_Fijo TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.Plazo_Cliente TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.Caja_Ahorro TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.Tarjeta TO 'empleado'@'%';

    GRANT SELECT, INSERT, UPDATE ON banco.Cliente_CA TO 'empleado'@'%';
    GRANT SELECT, INSERT, UPDATE ON banco.Cliente TO 'empleado'@'%';
    GRANT SELECT, INSERT, UPDATE ON banco.Pago TO 'empleado'@'%';

#Usuario atm.

    #CREATE USER 'atm'@'%' IDENTIFIED BY 'atm';
    GRANT SELECT ON banco.trans_cajas_ahorro TO 'atm'@'%';
    GRANT SELECT ON banco.Caja_Ahorro TO 'atm'@'%'; #Para el metodo obtenerSaldo de ModeloATMImpl 
    GRANT SELECT, UPDATE ON banco.Tarjeta TO 'atm'@'%';
    GRANT EXECUTE ON PROCEDURE banco.transferir to 'atm'@'%';
    GRANT EXECUTE ON PROCEDURE banco.extraer to 'atm'@'%';
    
    