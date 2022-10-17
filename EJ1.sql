create table Almacen
( 
	Nro int not null primary key,
	Responsable varchar(100)
)

create table Articulo
(
	CodArticulo int not null primary key,
	Descripcion varchar(20),
	Precio float
)

create table Material
(
   CodMaterial int not null primary key,
   Descripcion varchar(20),

)
create table Proveedor
(
	CodProveedor int not null primary key,
	Nombre varchar(30),
	Domicilio varchar(20),
	Ciudad varchar(20),

)
create table Tiene
(
	NroAlm int not null,
	CodArt int not null, 
	constraint pkTiene primary key(NroAlm,CodArt),
	constraint fkAlmacen foreign key(NroAlm) references Almacen(Nro) on update cascade,
	constraint fkArticulo foreign key(CodArt) references Articulo(CodArticulo) on update cascade
)
create table CompuestoPor
(
	CodArt int not null,
	CodMat int not null,
	constraint pkCompuestoPor primary key(CodArt, CodMat),
	constraint fkArt1 foreign key(CodArt) references Articulo(CodArticulo) on update cascade,
	constraint fkMat1 foreign key(CodMat) references Material(CodMaterial) on update cascade,
)
create table ProvistoPor
(
	CodMat int not null,
	CodProv int not null,
	constraint pkProvistoPor primary key(CodMat, CodProv),
	constraint fkMate foreign key(CodMat) references Material(CodMaterial) on update cascade,
	constraint fkProve foreign key(CodProv) references Proveedor(CodProveedor) on update cascade, 
)

/*
punto 1)  Listar los nombres de los proveedores de la ciudad de La Plata.
*/
select *from proveedor
insert into Proveedor values(10,'Juan Perez','Av Libertador 1993','La Plata')
INSERT INTO Proveedor VALUES(15,'Raul Abduzcan', 'Av. Libertador 2001', 'La Plata')
INSERT INTO Proveedor VALUES(20,'Marcelo Casio', 'Rio do Janeiro 911', 'Caballito')
INSERT INTO Proveedor VALUES(30,'Maria Pia', 'Av. La Plata 2005 ', 'Caballito')
INSERT INTO Proveedor VALUES(40,'Marcos Medina', 'Av. Rivadavia 4005 ', 'Caballito')
INSERT INTO Proveedor VALUES(50,'Antonio Lopez', 'Av. Libertador 1995', 'La Plata')
INSERT INTO Proveedor VALUES(55,'Lucas Perez', 'Cordoba 55', 'Pergamino')
INSERT INTO Proveedor VALUES(60,'Marcela Paz', 'Cordoba 44', 'Pergamino')
INSERT INTO Proveedor VALUES(65,'Luis Perez', 'Cordoba 55', 'Pergamino')
INSERT INTO proveedor VALUES(70,'Micaela Ramos', 'San Justo 1', 'Rosario')
INSERT INTO proveedor VALUES(75,'Emanuel Ringo', 'Palacios 10', 'Rosario')



select prov.Nombre from Proveedor prov where prov.Ciudad like 'La Plata'

/*
punto 2) Listar los números de artículos cuyo precio sea inferior a $10
*/

select *from Articulo
INSERT INTO Articulo VALUES(1,'Galletitas', 50)
INSERT INTO Articulo VALUES(2, 'GASEOSA', 5)
INSERT INTO Articulo VALUES(3, 'LAVANDINA', 4)
INSERT INTO Articulo VALUES(4, 'JABON', 1)
INSERT INTO Articulo VALUES(5, 'BANANA', 2)
INSERT INTO Articulo VALUES(6, 'PERA', 30)
INSERT INTO Articulo VALUES(7, 'UVAS', 150)
INSERT INTO Articulo VALUES(8, 'ESCOBA', 101)


select art.CodArticulo from Articulo art where art.Precio < 10 

/*
punto 3)  Listar los responsables de los almacenes.
*/
select *from Almacen
INSERT INTO Almacen VALUES(1, 'FREDDIE MERCURY')
INSERT INTO Almacen VALUES(2, 'ADAM LEVINE')
INSERT INTO Almacen VALUES(3, 'BRUNO MARS')
INSERT INTO Almacen VALUES(4, 'ADAM LAMBERT')
INSERT INTO Almacen VALUES(5, 'Martín Gómez')


select alm.Responsable from Almacen alm
select Responsable from Almacen

/*
punto 4)
Listar los códigos de los materiales que provea el proveedor 10 y no los provea el
proveedor 15.
*/
select *from Material
INSERT INTO Material VALUES(1,'DESC01')
INSERT INTO Material VALUES(2,'DESC02')
INSERT INTO Material VALUES(3,'DESC03')
INSERT INTO Material VALUES(4,'DESC04')
INSERT INTO Material VALUES(5,'DESC05')
INSERT INTO Material VALUES(6,'DESC06')

select *from ProvistoPor
INSERT INTO ProvistoPor VALUES(1, 10)
INSERT INTO ProvistoPor VALUES(1, 15)
INSERT INTO ProvistoPor VALUES(1, 20)
INSERT INTO ProvistoPor VALUES(1, 30)
INSERT INTO ProvistoPor VALUES(2, 20)
INSERT INTO ProvistoPor VALUES(2, 10)
INSERT INTO ProvistoPor VALUES(3, 10)
INSERT INTO ProvistoPor VALUES(4, 10)
INSERT INTO ProvistoPor VALUES(5, 30)
INSERT INTO ProvistoPor VALUES(6, 70)
INSERT INTO ProvistoPor VALUES(1, 75)
INSERT INTO ProvistoPor VALUES(2, 50)

INSERT INTO ProvistoPor VALUES(1, 50)
INSERT INTO ProvistoPor VALUES(3, 50)
INSERT INTO ProvistoPor VALUES(4, 50)
INSERT INTO ProvistoPor VALUES(5, 50)
INSERT INTO ProvistoPor VALUES(6, 50)




select  prov10.CodMat from ProvistoPor prov10 where prov10.CodProv = 10
except 
select  prov15.CodMat from ProvistoPor prov15 where prov15.CodProv = 15

/*
punto 5) Listar los números de almacenes que almacenan el artículo A.
*/
select *from Tiene
INSERT INTO Tiene VALUES(1, 1)
INSERT INTO Tiene VALUES(1, 2)
INSERT INTO Tiene VALUES(1, 5)
INSERT INTO Tiene VALUES(1, 4)
INSERT INTO Tiene VALUES(2, 1)
INSERT INTO Tiene VALUES(2, 2)
INSERT INTO Tiene VALUES(3, 5)
INSERT INTO Tiene VALUES(4, 4)
INSERT INTO Tiene VALUES(4, 5)
INSERT INTO Tiene VALUES(4, 6)
INSERT INTO Tiene VALUES(5, 3)



select alm.NroAlm from Tiene alm where alm.CodArt=1

/*
punto 6)Listar los proveedores de Pergamino que se llamen Pérez.
*/

select prov.CodProveedor from Proveedor prov where prov.Ciudad like 'Pergamino' and prov.Nombre like '%Perez'

/*
punto 7)Listar los almacenes que contienen los artículos A y los artículos B (ambos).
*/

select alm1.NroAlm from Tiene alm1 where alm1.CodArt=1
union 
select alm2.NroAlm from Tiene alm2 where alm2.CodArt=2

/*
punto 8)
Listar los artículos que cuesten más de $100 o que estén compuestos por el material M1(1).
*/

select *from Articulo
select *from CompuestoPor 
INSERT INTO CompuestoPor VALUES(7, 4)
INSERT INTO CompuestoPor VALUES(7, 1)
INSERT INTO CompuestoPor VALUES(8, 1)
INSERT INTO CompuestoPor VALUES(1, 3)
INSERT INTO CompuestoPor VALUES(6, 2)
INSERT INTO CompuestoPor VALUES(6, 1)
INSERT INTO CompuestoPor VALUES(2, 1)
INSERT INTO CompuestoPor VALUES(2, 4)
INSERT INTO CompuestoPor VALUES(2, 3)
INSERT INTO CompuestoPor VALUES(3, 1)

INSERT INTO CompuestoPor VALUES(4, 1)
INSERT INTO CompuestoPor VALUES(4, 2)
INSERT INTO CompuestoPor VALUES(4, 3)
INSERT INTO CompuestoPor VALUES(4, 4)
INSERT INTO CompuestoPor VALUES(4, 5)
INSERT INTO CompuestoPor VALUES(4, 6)


SELECT artc.CodArticulo FROM Articulo artc WHERE artc.Precio > 100
UNION
SELECT art1.CodArt FROM CompuestoPor art1 WHERE ART1.CodMat = 1

/*
punto 9)Listar los materiales, código y descripción, provistos por proveedores de la ciudad
de Rosario.
*/
select *from Material
select *from Proveedor
select *from ProvistoPor


SELECT * FROM Material
WHERE CodMaterial in
(
    SELECT CodMat
    FROM ProvistoPor
    WHERE CodProv in
    (
        SELECT CodProveedor
        FROM Proveedor
        WHERE Ciudad = 'Rosario'
    )
)

/*
punto 10)Listar el código, descripción y precio de los artículos que se almacenan en A1.
*/

select *from Articulo
where CodArticulo in
(
	select CodArt
	from Tiene
	where CodArt=1
)

/*
punto 11) Listar la descripción de los materiales que componen el artículo B(2).
*/
select *from CompuestoPor

create view mat2
as
select comp.CodMat from CompuestoPor comp where comp.CodArt=2

select *from mat2

select mat.Descripcion from material mat, mat2 mata2 where mat.CodMaterial = mata2.CodMat

/*
punto 12) Listar los nombres de los proveedores que proveen los materiales al almacén que Martín Gómez tiene a su cargo.
*/

SELECT PROV.Nombre FROM Proveedor PROV WHERE PROV.CodProveedor IN
(
    SELECT prov.CodProv FROM ProvistoPor prov WHERE prov.CodMat IN
    (
        SELECT comp.CodMat FROM CompuestoPor comp WHERE comp.CodArt IN
        (
            SELECT tie.CodArt FROM Tiene tie WHERE tie.NroAlm IN 
            (
                SELECT ALM.Nro  From Almacen ALM WHERE ALM.Responsable = 'Martín Gómez'
            )
        )
    )
)

/*
punto 13) Listar códigos y descripciones de los artículos compuestos por al menos un material provisto por el proveedor López.
*/


SELECT art.CodArticulo, art.Descripcion  FROM Articulo art WHERE art.CodArticulo IN
(
	SELECT comp.CodArt FROM CompuestoPor comp WHERE comp.CodMat IN
	(
		SELECT provpor.CodMat FROM ProvistoPor provpor WHERE provpor.CodProv IN
		(
			SELECT prov.CodProveedor FROM  Proveedor prov WHERE prov.Nombre  LIKE '%Lopez'
		)
	)
)

/*
punto 14) Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo 
cuyo precio es mayor a $100.
*/
SELECT CodProveedor, Nombre FROM Proveedor WHERE CodProveedor IN 
(
    SELECT CodProv FROM ProvistoPor WHERE CodMat IN
    (
        SELECT CodMat FROM CompuestoPor WHERE CodArt IN 
        (
            SELECT CodArticulo FROM Articulo WHERE Precio > 100 
        )
    )
)

/*
punto 15)Listar los números de almacenes que tienen todos los artículos que incluyen el
material con código 123(1)
*/

SELECT * FROM Almacen alm WHERE NOT EXISTS
(
	SELECT 1 FROM Articulo art WHERE CodArticulo IN
	(
		SELECT CodArticulo FROM CompuestoPor WHERE CodMat=1
	)
	AND NOT EXISTS
	(
		SELECT 1 FROM Tiene t where t.CodArt=art.CodArticulo AND t.NroAlm = alm.Nro
	)
)

/*
punto 16)Listar los proveedores de Capital Federal(Caballito) que sean únicos proveedores de algún material.
*/
/**
    Primero creo la vista ProvistoPorXProvistoPor
**/
    CREATE VIEW ProvistoPorXProvistoPor(cod1, codP1, cod2, codP2) AS 
    SELECT * FROM ProvistoPor prov1 CROSS JOIN ProvistoPor p

/**
    Sacamos el unicoProveedor
**/
    CREATE VIEW unicoProveedor(codMat, codProv) AS
    SELECT * FROM ProvistoPor
    EXCEPT
    SELECT prov.cod1, prov.codP1 FROM ProvistoPorXProvistoPor prov WHERE prov.codp1 <> prov.codP2 and prov.cod1 = prov.cod2
    /**
    10 10 30 70
    **/
/**
    Interseccion solo con los de Caballito(Cap. fed)
**/

    SELECT CodProveedor FROM Proveedor WHERE Ciudad LIKE 'Caballito'  
    intersect
    SELECT codProv FROM unicoProveedor 


/*
punto 17) Listar el/los artículo/s de mayor precio.
*/
  Select art.CodArticulo, art.Precio From Articulo art WHERE art.Precio =(SELECT MAX(Precio) FROM Articulo)

 /*
punto 18) Listar el/los artículo/s de menor precio.
*/
Select art.CodArticulo, art.Precio From Articulo art WHERE art.Precio =(SELECT MIN(Precio) FROM Articulo)

 /*
punto 19) Listar el promedio de precios de los artículos en cada almacén.
*/

CREATE VIEW articuloTiene(codArt, precio, nroAlm) AS
SELECT alm.CodArticulo, alm.Precio, tie.NroAlm FROM Articulo alm, Tiene tie WHERE alm.CodArticulo = tie.CodArt
    
SELECT arT1.nroAlm, AVG(art2.precio) FROM articuloTiene arT1 CROSS JOIN articuloTiene art2 WHERE arT1.nroAlm = art2.nroAlm GROUP BY(arT1.nroAlm)

select *from articulo
select*from tiene


 
 /*
punto 20)  Listar los almacenes que almacenan la mayor cantidad de artículos.
*/

SELECT tie.NroAlm, COUNT(tie.NroAlm) FROM Tiene tie GROUP BY tie.NroAlm


/*
punto 21) Listar los artículos compuestos por al menos 2 materiales.
*/

SELECT comp1.CodArt FROM CompuestoPor comp1 CROSS JOIN CompuestoPor  comp2 WHERE comp1.CodArt = comp2.CodArt AND comp1.CodMat <> comp2.CodMat

/*
punto 22) Listar los artículos compuestos por exactamente 2 materiales.
*/

CREATE VIEW almenosDos(CodArt, CodMat) AS
SELECT comp1.CodArt, comp1.CodMat FROM CompuestoPor comp1 CROSS JOIN CompuestoPor  comp2 WHERE comp1.CodArt = comp2.CodArt AND comp1.CodMat <> comp2.CodMat

CREATE VIEW almenosTres(CodArt, CodMat) AS
SELECT comp1.CodArt, comp1.CodMat FROM CompuestoPor comp1, CompuestoPor comp2 , CompuestoPor comp3
WHERE comp1.CodArt = comp2.CodArt  AND comp2.CodArt = comp3.CodArt  AND
comp1.CodMat <> comp2.CodMat AND comp2.CodMat <> comp3.CodMat AND comp1.CodMat <> comp3.CodMat

SELECT *FROM almenosDos 
EXCEPT 
SELECT *FROM almenosTres

/*
punto 23) Listar los artículos compuestos por exactamente 2 materiales.
*/

SELECT comp.CodArt, COUNT(comp.CodArt) FROM CompuestoPor comp  GROUP BY comp.CodArt HAVING COUNT(comp.CodArt) <=2

/*
punto 24) Listar los artículos compuestos por todos los materiales.
*/

SELECT * FROM Articulo art WHERE NOT EXISTS
 (
	 SELECT 1 FROM Material mat WHERE NOT EXISTS
	 (
		SELECT 1 FROM CompuestoPor comp WHERE comp.CodMat = mat.CodMaterial AND comp.CodArt = art.CodArticulo
	 )
)

/*
punto 25) Listar las ciudades donde existan proveedores que provean todos los materiales.
*/

SELECT prove.Ciudad FROM Proveedor prove  WHERE NOT EXISTS
(
	SELECT 1 FROM Material mat WHERE NOT EXISTS
	(
		SELECT 1 FROM ProvistoPor prov WHERE prov.CodMat = mat.CodMaterial AND prov.CodProv = prove.CodProveedor
	)
)