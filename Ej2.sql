CREATE TABLE Proveedor
(
    nroProv varchar(50),
    nomProv varchar(50),
    categoria int,
    ciudadProv varchar(50),
    primary key(nroProv)
)

CREATE TABLE Articulo(
    nroArt varchar(50),
    descripcion varchar(50),
    ciudadArt varchar(50),
    precio int,
    primary key(nroArt)
)

CREATE TABLE Cliente
(
    nroCli varchar(50),
    nomCli varchar(50),
    ciudadCli varchar(50),
    primary key(nroCli)
)

CREATE TABLE Pedido
(
    nroPed varchar(50),
    nroArt varchar(50),
    nroCli varchar(50),
    nroProv varchar(50),
    fechaPedido date,
    cantidad int,
    precioTotal int,
    primary key(nroPed),
    constraint fkArticulo foreign key(nroArt) references Articulo(nroArt) on update cascade,
    constraint fkCliente foreign key(nroCli) references Cliente(nroCli) on update cascade,
    constraint fkProveedor foreign key(nroProv) references Proveedor(nroProv) on update cascade,
)

CREATE TABLE Stock
(
    nroArt varchar(50),
    fecha date,
    cantidad int,
    constraint pkStock primary key(nroArt,fecha),
    constraint fkArt foreign key(nroArt) references Articulo(nroArt) on update cascade
)

INSERT INTO Proveedor VALUES ('p023', 'LUCAS GOMEZ', 4, 'ROSARIO')
INSERT INTO Proveedor VALUES ('p020', 'FABIAN GOMEZ', 4, 'LA PLATA')
INSERT INTO Proveedor VALUES ('p003', 'ROSARIO FERNANDEZ', 4, 'ROSARIO')
INSERT INTO Proveedor VALUES ('p011', 'LEANDRO PEREZ', 4, 'MENDOZA')
INSERT INTO Proveedor VALUES ('p010', 'FABIANA LOPEZ', 4, 'ROSARIO')
INSERT INTO Proveedor VALUES ('p005', 'LILIANA LAMAS', 4, 'JUNIN')
INSERT INTO Proveedor VALUES ('p015', 'LILIANA PEREZ', 6, 'MENDOZA')
INSERT INTO Proveedor VALUES ('p100', 'MIKA GONZALEZ', 6, 'ROSARIO')
INSERT INTO Proveedor VALUES ('p200', 'LUCAS RULLO', 10, 'SANTIAGO DEL ESTERO')

INSERT INTO Articulo VALUES('a146', 'GASEOSA', 'JUNIN', 200)
INSERT INTO Articulo VALUES('a100', 'JABON', 'JUNIN', 150)
INSERT INTO Articulo VALUES('a086', 'CERAMICA', 'MENDOZA', 2000)
INSERT INTO Articulo VALUES('a132', 'ACEITE', 'LA PLATA', 130)
INSERT INTO Articulo VALUES('a023', 'LAVAND INA', 'MISIONES', 100)
INSERT INTO Articulo VALUES('a145', 'CUADERNO', 'LA PLATA', 300)

INSERT INTO Cliente VALUES('c30', 'LUCAS LOPEZ', 'MENDOZA')
INSERT INTO Cliente VALUES('c02', 'LUIS LOPEZ', 'JUNIN')
INSERT INTO Cliente VALUES('c22', 'MATIAS TORNELLO', 'MENDOZA')
INSERT INTO Cliente VALUES('c23', 'JUAN MENDOZA', 'LA PLATA')
INSERT INTO Cliente VALUES('c01', 'EZEQUIEL SOTO', 'ROSARIO')
INSERT INTO Cliente VALUES('c44', 'LUIS CHAVES', 'ROSARIO')
INSERT INTO Cliente VALUES('c50', 'HUGO VAZQUEZ', 'JUNIN')
INSERT INTO Cliente VALUES('c56', 'RAUL DELIA', 'JUNIN')

INSERT INTO Pedido VALUES('123', 'a146', 'c02', 'p023', '2021-12-22', 200, 1000)
INSERT INTO Pedido VALUES('125', 'a146', 'c22', 'p005', '2022-2-3', 150, 700)
INSERT INTO Pedido VALUES('120', 'a100', 'c01', 'p010', '2004-5-2', 100, 350)
INSERT INTO Pedido VALUES('126', 'a023', 'c44', 'p015', '2013-5-6', 10, 1100)
INSERT INTO Pedido VALUES('128', 'a023', 'c23', 'p011', '2006-1-2', 100, 3200)
INSERT INTO Pedido VALUES('200', 'a023', 'c30', 'p011', '2008-2-1', 50, 1600)
INSERT INTO Pedido VALUES('210', 'a146', 'c50', 'p023', '2022-2-12', 100, 500)
INSERT INTO Pedido VALUES('220', 'a145', 'c56', 'p023', '2022-6-8', 200, 1000)
INSERT INTO Pedido VALUES('222', 'a145', 'c22', 'p023', '2022-12-22', 100, 30000)
INSERT INTO Pedido VALUES('135', 'a145', 'c02', 'p011', '2021-2-12', 100, 30000)
INSERT INTO Pedido VALUES('166', 'a086', 'c44', 'p020', '2021-6-7', 100, 15612)
INSERT INTO Pedido VALUES('199', 'a132', 'c44', 'p020', '2004-2-6', 100, 15612)
INSERT INTO Pedido VALUES('201', 'a132', 'c44', 'p023', '2022-4-6', 100, 15612)
INSERT INTO Pedido VALUES('202', 'a023', 'c56', 'p023', '2007-6-1', 100, 15612)
INSERT INTO Pedido VALUES('203', 'a086', 'c02', 'p023', '2005-6-7', 100, 333)
INSERT INTO Pedido VALUES('204', 'a100', 'c22', 'p023', '2022-12-12', 100,216)
INSERT INTO Pedido VALUES('205', 'a146', 'c30', 'p100', '2021-2-2', 1002,2163)
INSERT INTO Pedido VALUES('206', 'a086', 'c30', 'p100', '2021-2-21', 102,213)
INSERT INTO Pedido VALUES('207', 'a145', 'c30', 'p100', '2021-7-12', 12,223)


INSERT INTO Stock VALUES('a146', '2022-2-3', 300)
INSERT INTO Stock VALUES('a100', '2022-4-6', 3000)
INSERT INTO Stock VALUES('a086', '2022-4-6', 100)
INSERT INTO Stock VALUES('a132', '2021-2-2', 50)
INSERT INTO Stock VALUES('a023', '2022-12-12', 500)
INSERT INTO Stock VALUES('a145', '2004-5-2', 3000)
INSERT INTO Stock VALUES('a146', '2021-12-22', 50)


/* Ejercicio 1 
Hallar el código (nroProv) de los proveedores que proveen el artículo a146. 
*/

SELECT nroProv From Pedido where nroArt='a146'


/* Ejercicio 2
Hallar los clientes (nomCli) que solicitan artículos provistos por p015.
*/

select nomCli from cliente where nroCli in
(
	SELECT nroCli from Pedido where nroProv='p015'
)

/* Ejercicio 3
Hallar los clientes que solicitan algún item provisto por proveedores con categoría mayor que 4.
*/

select *from Cliente where nroCli in
(
	select nroCli from Pedido where nroProv in
	(
		select nroProv from Proveedor where categoria>4 
	)
)

/* Ejercicio 4
Hallar los pedidos en los que un cliente de Rosario solicita artículos producidos en la ciudad de Mendoza
*/


select *from Pedido where nroCli in
(

	select nroCli from Cliente where ciudadCli ='Rosario'

)
INTERSECT
select *from Pedido where nroArt in
(

	select nroArt from Articulo where ciudadArt='Mendoza'

)

/* Ejercicio 5
Hallar los pedidos en los que el cliente c23 solicita artículos solicitados por el cliente c30
*/

select nroPed from pedido where nroCli='c23' AND nroArt in
(

 select nroArt from pedido where nroCli='c30'

)

/* Ejercicio 6
Hallar los proveedores que suministran todos los artículos cuyo precio es superior
al precio promedio de los artículos que se producen en La Plata.
*/

select *from Proveedor prov where not exists
(
	
	select 1 from Articulo art where precio > all(select *from precioPromPlata)
	
	and not exists
	(
		select 1 from Pedido ped where prov.nroProv= ped.nroProv AND ped.nroArt=art.nroArt   
	)
)

create view precioPromPlata(precio) as
select avg(precio) from articulo where ciudadArt='La Plata'

/* Ejercicio 7
Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee a todos los clientes de Junín
*/

create view ArtProvCliejun(nroArt) as
select nroArt from pedido where nroProv in 
(
	select nroProv from Proveedor prov where not exists
	(
		select 1 from cliente clie where ciudadCli = 'Junin'
		and not exists
		(
			select 1 from Pedido ped where prov.nroProv = ped.nroProv AND ped.nroCli = clie.nroCli 
		)
	)
)

intersect 

select nroArt from pedido where nroCli in
(
	select nroCli from cliente clie where ciudadCli = 'Junin'
)

select count(nroArt) from ArtProvCliejun 

/* Ejercicio 8
Hallar los nombres de los proveedores cuya categoría sea mayor que la de todos los proveedores que proveen el artículo cuaderno
*/

create view categoriaProv(nroProv, categoria)as

select nroProv, categoria from Proveedor where nroProv in
(
	select nroProv from Pedido where nroArt in
	(
		select nroArt from Articulo where descripcion='cuaderno'
	)
)

select *from proveedor where categoria > all(select  categoria from categoriaProv where categoria=(select max(categoria) from categoriaProv)) 

/* Ejercicio 9
Hallar los proveedores que han provisto más de 1000 unidades entre los artículos A001 (a145) y A100.
*/
	
create view proveArtCant(nroProv,cantidad) as	

	select ped.nroProv, sum(ped.cantidad) from Pedido ped where nroArt ='a145' group by ped.nroProv	
	union
	select ped.nroProv, sum(ped.cantidad) from Pedido ped where nroArt ='a100' group by ped.nroProv

create view proveArtFin(nroProv,cantidad)as
select nroProv , sum(cantidad) from proveArtCant where nroProv in
(
	select ped.nroProv from Pedido ped where nroArt ='a145' 	
	intersect
	select ped.nroProv from Pedido ped where nroArt ='a100'
)
group by(nroProv)

select  nroProv from proveArtFin where cantidad > 1000

/* Ejercicio 10
Listar la cantidad y el precio total de cada artículo que han pedido los Clientes a sus proveedores 
entre las fechas 01-01-2004  y 31-03-2004 (se requiere visualizar Cliente, Articulo, Proveedor, Cantidad y Precio).
*/ 

select *from Pedido  where fechaPedido between '2004-01-01' and '2004-03-31'


/* Ejercicio 11
Idem anterior y que además la Cantidad sea mayor o igual a 1000 o el Precio sea mayor a $ 1000.
*/
select *from Pedido  where fechaPedido between '2004-01-01' and '2004-03-31' and cantidad >=1000
union
select *from pedido where precioTotal >1000

/* Ejercicio 12
Listar la descripción de los artículos en donde se hayan pedido en el día más del stock existente para ese mismo día.
*/

select descripcion from Articulo  where nroArt in
(
	select sto.nroArt from Stock sto, Pedido ped where sto.nroArt = ped.nroArt and sto.cantidad < ped.cantidad and sto.fecha =ped.fechaPedido  
)


/* Ejercicio 13
Listar los datos de los proveedores que hayan pedido de todos los artículos en un mismo día. Verificar sólo en el último mes de pedidos.
*/

select *from Proveedor prov where not exists
(
	select 1 from Articulo art where not exists
	(
		select 1 from Pedido ped where ped.nroProv = prov.nomProv and ped.nroArt=art.nroArt and ped.fechaPedido <'2022-10-1'
	)
)
/* Ejercicio 14
Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el último mes, 
pero sí se les haya pedido en el mismo mes del año anterior.
*/

select nroProv from Proveedor 
except
select nroProv from Pedido where fechaPedido < '2022-09-30' and fechaPedido between '2021-09-1' and '2021-09-30'

/* Ejercicio 15
Listar los nombres de los clientes que hayan solicitado más de un artículo cuyo
precio sea superior a $100 y que correspondan a proveedores de Capital Federal.
Por ejemplo, se considerará si se ha solicitado el artículo a2 y a3, pero no si
solicitaron 5 unidades del articulo a2
*/

create view clieEj15(nroCli,nroArt) as
select nroCli,nroArt from pedido where nroArt in
(
	select nroArt from Articulo where precio>100 and nroArt in 
	(
		select nroArt from pedido where nroProv in
		(
			select nroProv from Proveedor where ciudadProv='rosario'
		)
	)
)

select nomCli from Cliente where nroCli in
(
	select  clie1.nroCli from  clieEj15 clie1 cross join clieEj15 clie2 where clie1.nroCli = clie2.nroCli and clie1.nroArt <>  clie2.nroArt
)








