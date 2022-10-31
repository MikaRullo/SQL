CREATE TABLE Proveedor
(
    codProveedor int,
    razonSocial varchar(100),
    fechaInicio date,
    CONSTRAINT PKPROVEEDOR PRIMARY KEY (codProveedor)
)

CREATE TABLE Producto
(
    codProducto int,
    descripcion varchar(100),
    codProveedor int,
    stockActual int,
    CONSTRAINT PKPRODUCTO PRIMARY KEY(codProducto),
    CONSTRAINT FKPRODUCTO FOREIGN KEY (codProveedor) REFERENCES Proveedor(codProveedor)  ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Stock
(
    nro int,
    fecha date,
    codProducto int,
    cantidad int,
    
    CONSTRAINT PKSTOCK PRIMARY KEY (nro, fecha, codProducto),
    CONSTRAINT FKSTOCK FOREIGN KEY (codProducto) REFERENCES Producto(codProducto) ON DELETE CASCADE ON UPDATE CASCADE
)


INSERT INTO Proveedor VALUES(1, 'Razon01', '2022-10-17')
INSERT INTO Proveedor VALUES(2, 'Razon02', '2020-10-17')
INSERT INTO Proveedor VALUES(3, 'Razon03', '2021-10-17')
INSERT INTO Proveedor VALUES(4, 'Razon04', '2020-10-17')

select * from Proveedor

INSERT INTO Producto VALUES(1, 'Descripcion01', 1, 0)
INSERT INTO Producto VALUES(2, 'Descripcion02', 2, 10)
INSERT INTO Producto VALUES(3, 'Descripcion03', 3, 5)
INSERT INTO Producto VALUES(4, 'Descripcion04', 4, 10)
INSERT INTO Producto VALUES(5, 'Descripcion05', 1, 2)

select * from Producto

INSERT INTO Stock VALUES(1, '2022-10-10', 1, 10)
INSERT INTO Stock VALUES(2, '2022-10-10', 2, 0)
INSERT INTO Stock VALUES(3, '2022-10-10', 3, 10)
INSERT INTO Stock VALUES(4, '2022-10-10', 4, 50)
INSERT INTO Stock VALUES(5, '2022-10-20', 5, 20)
INSERT INTO Stock VALUES(5, '2022-10-20', 3, 30)


SELECT * FROM STOCK

--1 p_EliminaSinstock(): Realizar un procedimiento que elimine los productos que no poseen stock.


create or alter procedure P_EliminaSinstock
as
begin
			delete from producto where stockActual=0
end

exec P_EliminaSinstock

select *from Producto

/*
2 p_ActualizaStock(): Para los casos que se presenten inconvenientes en los
datos, se necesita realizar un procedimiento que permita actualizar todos los
Stock_Actual de los productos, tomando los datos de la entidad Stock. Para ello,
se utilizar� como stock v�lido la �ltima fecha en la cual se haya cargado el stock.
*/

/**
    crear vista con fecha maxima
**/
CREATE VIEW stockUltimasFechas(codProd, fecha)
AS
SELECT STO.codProducto, MAX(STO.FECHA)  FROM STOCK STO GROUP BY STO.codProducto
/**
    creo vista con todos los campos
**/
CREATE VIEW stockUlt (nro, fecha, cosProducto, cantidad)
as
SELECT stoc.nro, stoc.fecha, stoc.codProducto, stoc.cantidad   
FROM stockUltimasFechas stUlt, Stock stoc WHERE stUlt.codProd = stoc.codProducto AND stUlt.fecha = stoc.fecha 

CREATE OR ALTER PROCEDURE p_ActualizaStock
AS
BEGIN 
    BEGIN
        UPDATE Producto SET stockActual = sto.cantidad FROM stockUlt sto
        WHERE Producto.codProducto = sto.cosProducto
    END
END

exec p_ActualizaStock

select *from Producto


/**
    3- p_DepuraProveedor(): Realizar un procedimiento que permita depurar todos los
    proveedores de los cuales no se posea stock de ning�n producto provisto desde
    hace m�s de 1 a�o.
**/
CREATE OR ALTER PROCEDURE p_DepuraProveedor
as
BEGIN
    DELETE FROM Proveedor WHERE codProveedor IN
    (
        SELECT prod.codProveedor FROM Producto prod WHERE codProducto IN
        (
        SELECT sto.codProducto FROM Stock sto WHERE sto.cantidad = 0 --sto.fecha between '2020-1-1' and '2021-12-31' 
        )
    )
END

SELECT * FROM Producto

EXEC p_DepuraProveedor

-- 4 p_InsertStock(nro,fecha,prod,cantidad): Realizar un procedimiento que permita agregar stocks de productos. Al realizar la inserci�n se deber� validar que:
SELECT * FROM Stock

CREATE OR ALTER PROC p_InsertStock(@nro int, @fecha date, @codProd int, @cantidad int)
AS
BEGIN
    DECLARE @IDNUM INT
    SET @IDNUM = (SELECT MAX(NRO) FROM Stock) + 1
    
    DECLARE @PROD INT 
    SET @PROD = (SELECT codProducto FROM Producto WHERE @codProd = codProducto);
    
    IF @cantidad <= 0
        SELECT 'LA CANTIDAD DEBE SER MAYOR A CERO.'
    ELSE
    BEGIN
        IF @nro = @IDNUM AND @PROD IS NOT NULL
            BEGIN
                INSERT INTO STOCK VALUES(@nro, @fecha, @codProd, @cantidad)
            END
        ELSE
            SELECT 'ERROR'
    END
END
SELECT *FROM Stock

EXEC p_InsertStock 10, '2002-1-1', 41, 100


/**
    5-tg_CrearStock: Realizar un trigger que permita autom�ticamente agregar un
    registro en la entidad Stock, cada vez que se inserte un nuevo producto. El stock
    inicial a tomar, ser� el valor del campo Stock_Actual.
**/

CREATE OR ALTER TRIGGER tg_CrearStock ON Producto AFTER INSERT
AS 
BEGIN
    DECLARE @CODSTOCK INT
    SET @CODSTOCK = (SELECT MAX(nro) FROM Stock) + 1

    DECLARE @CODPROD INT
    SET @CODPROD = (select codProducto from inserted)

    DECLARE @CANTIDAD INT
    SET @CANTIDAD = (select stockActual from inserted)

    INSERT INTO Stock VALUES (@CODSTOCK, GETDATE(), @CODPROD, @CANTIDAD)
END

INSERT INTO Producto VALUES (10, 'Descripcion07', 4, 5)

SELECT * FROM PRODUCTO
SELECT * FROM Stock


/**
    6- p_ListaSinStock(): Crear un procedimiento que permita listar los productos que
    no posean stock en este momento y que no haya ingresado ninguno en este
    �ltimo mes. De estos productos, listar el c�digo y nombre del producto, raz�n
    social del proveedor y stock que se ten�a al mes anterior
**/

CREATE OR ALTER PROCEDURE p_ListaSinStock
AS 
BEGIN
    SELECT prod.codProducto, prod.descripcion, prov.razonSocial, stoc.cantidad FROM Producto prod , Stock stoc, Proveedor prov 
    where prod.stockActual = 0 AND prod.codProveedor = stoc.codProducto AND prov.codProveedor = prod.codProveedor ---AND stoc.fecha < '2022-09-1'
END


exec p_ListaSinStock


-- 7 p_ListaStock(): Realizar un procedimiento que permita generar el siguiente reporte:

--8 p_EliminaSinstock(): Realizar un procedimiento que elimine los productos que no poseen stock.

CREATE VIEW menor
as
SELECT sto.fecha, count(sto.codProducto)  as 'men' FROM Stock sto WHERE sto.cantidad > 10 GROUP BY sto.fecha

CREATE VIEW mayor
as
SELECT sto.fecha, count(sto.codProducto)  as 'may' FROM Stock sto WHERE sto.cantidad < 10 GROUP BY sto.fecha

CREATE VIEW igual
as
SELECT sto.fecha, count(sto.codProducto)  as 'igu' FROM Stock sto WHERE sto.cantidad = 0 GROUP BY sto.fecha


CREATE OR ALTER PROC p_ListaStock
AS 
BEGIN
    SELECT stoc.fecha, isnull(men.men, 0) may, isnull(may.may, 0) men, isnull(ig.igu, 0) igual FROM Stock stoc
    LEFT JOIN menor men ON stoc.fecha = men.fecha
    LEFT JOIN mayor may ON stoc.fecha = may.fecha
    LEFT JOIN igual ig ON stoc.fecha = ig.fecha
    GROUP BY stoc.fecha, men.men, may.may, ig.igu
END
SELECT * FROM STOCK

exec p_ListaStock



create or alter procedure P_EliminaSinstock
as
begin
			delete from producto where stockActual=0
end

exec P_EliminaSinstock

select *from Producto


/*
8. El siguiente requerimiento consiste en actualizar el campo stock actual de la
entidad producto, cada vez que se altere una cantidad (positiva o negativa) de ese
producto. El stock actual reflejar� el stock que exista del producto, sabiendo que
en la entidad Stock se almacenar� la cantidad que ingrese o egrese. Adem�s, se
debe impedir que el campo �Stock actual� pueda ser actualizado manualmente. Si
esto sucede, se deber� dar marcha atr�s a la operaci�n indicando que no est�
permitido.
*/

CREATE OR ALTER TRIGGER verProd ON Producto AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @STOCK INT
    SET @STOCK = (SELECT stockActual FROM inserted)

    DECLARE @CODPROD INT 
    SET  @CODPROD = (SELECT codProducto FROM inserted)

    IF @STOCK IS NOT NULL
    BEGIN
        SELECT 'ERROR'
    END
END

INSERT INTO Producto VALUES(12, 'Descripcion05', 1, 2)


CREATE OR ALTER TRIGGER actProducto ON Stock AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @NUM INT
    SET @NUM = (SELECT MAX(nro) FROM Stock) + 1
    PRINT @NUM
    IF @NUM != (SELECT nro from inserted )
        BEGIN
            DECLARE @COD INT
            SET @COD = (SELECT CODPRODUCTO FROM inserted)

            DECLARE @STO INT
            SET @STO = (SELECT cantidad FROM inserted) + (SELECT stockActual FROM Producto WHERE codProducto = @COD)

            UPDATE Producto SET stockActual = @STO WHERE codProducto = @COD
        END
    ELSE
        SELECT 'ERROR NUM'
END

INSERT INTO Stock VALUES(18, '2022-10-20', 3, 30)
INSERT INTO Stock VALUES(10, '2022-10-20', 3, -30)

SELECT * FROM Producto 
SELECT * FROM Stock 


