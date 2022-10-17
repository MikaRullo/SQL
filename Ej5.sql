create database Ej05

create table rubro
(
	codRubro int primary key,
	nomRubro varchar(50),
)

create table pelicula 
(
	codPel int primary key,
	titulo varchar(100),
	duracion int,
	a�o int,
	codRubro int,
	constraint fkRub foreign key(codRubro) references rubro(codRubro) on update cascade 
)

create table ejemplar
(
	codEjemplar int,
	codPel int,
	estado varchar(50),
	ubicacion varchar(50),
	primary key(codEjemplar,codPel),
	constraint fkpel foreign key(codPel) references pelicula(codpel) on update cascade,
)

create table cliente
(
	codCliente int primary key,
	nombre varchar(50),
	apellido varchar(50),
	direccion varchar(50),
	tel int,
	mail varchar(30),
)

create table prestamo
(
    codPrestamo int,
    codEjemplar int,
    codPel int,
    codCliente int,
    fPrest date,
    fDev date,
    constraint pkPrest primary key(codPrestamo),
    constraint fkEjem foreign key(codEjemplar, codPel) references ejemplar(codEjemplar, codPel) on update cascade ,
    constraint fkclien foreign key(codCliente) references cliente(codCliente) on update cascade,
)

insert into rubro values (1,'Policial')
insert into rubro values (2,'Drama')
insert into rubro values (3,'Romance')
insert into rubro values (4,'Comedia')
insert into rubro values (5,'Familiar')
insert into rubro values (6,'Accion')

insert into pelicula values(1,'Rey Leon',2,2008,5)
insert into pelicula values(2,'Terminator',3,2005,6)
insert into pelicula values(3,'Harry potter',2,2004,4)
insert into pelicula values(4,'jurassic park 3',3,2001,2)
insert into pelicula values(5,'Policias',3,2022,1)

insert into ejemplar values(1,1,'Libre','a')
insert into ejemplar values(2,1,'ocupado','a')
insert into ejemplar values(3,2,'ocupado','b')
insert into ejemplar values(4,2,'libre','b')
insert into ejemplar values(5,5,'libre','c')
insert into ejemplar values(6,3,'libre','d')
insert into ejemplar values(7,4,'ocupado','e')

insert into cliente values(1,'Maria','Pia','Calle 1',123,'mapi@gmail.com')
insert into cliente values(2,'Lucas','Rullo','Calle 1',123,'lr@gmail.com')
insert into cliente values(3,'Emma','Gomez','Calle 2',456,'emg@gmail.com')
insert into cliente values(4,'Mika','Pia','Calle 3',465,'mirp@gmail.com')
insert into cliente values(5,'Berpi','stark','Calle 4',782,'bsk@gmail.com')

insert into prestamo values(1,1,1,2,'2022-10-17',NULL)
insert into prestamo values(2,2,1,3,'2022-09-10','2022-09-15')
insert into prestamo values(3,5,5,5,'2022-05-08','2022-05-20')
insert into prestamo values(4,5,5,1,'2022-10-16','2022-10-17')
insert into prestamo values(5,7,4,4,'2021-10-17',NULL)
insert into prestamo values(6,2,1,3,'2022-09-17','2022-09-25')
insert into prestamo values(7,3,2,2,'2022-10-01','2022-10-05')
insert into prestamo values(8,6,3,2,'2022-10-01','2022-10-05')
insert into prestamo values(9,7,4,2,'2022-10-01','2022-10-05')
insert into prestamo values(10,5,5,2,'2022-10-01','2022-10-05')

/*Ejercicio 1
Listar los clientes que no hayan reportado pr�stamos del rubro �Policial�.*/

select codCliente from cliente
except 
select codCliente from prestamo where codPel in
(
	select codPel from pelicula where codRubro in
	(
		select codRubro from rubro where nomRubro='policial'
	)
)

/*Ejercicio 2
Listar las pel�culas de mayor duraci�n que alguna vez fueron prestadas.*/

select codPel from prestamo where codPel in
(
	select codPel from pelicula where duracion =all(select max(duracion) from pelicula)
)

/*Ejercicio 3
Listar los clientes que tienen m�s de un pr�stamo sobre la misma pel�cula (listarCliente, Pel�cula y cantidad de pr�stamos).*/

select pres1.codCliente,pres1.codPel,count(pres1.codPrestamo) as cantidadPrestamos from prestamo pres1 , prestamo pres2 
where pres1.codCliente=pres2.codCliente and pres1.codPrestamo<> pres2.codPrestamo and pres1.codPel=pres2.codPel
group by pres1.codCliente,pres1.codPel

/*Ejercicio 4
Listar los clientes que han realizado pr�stamos del t�tulo �Rey Le�n� y �Terminador3� (Ambos).*/

select codCliente from prestamo where codPel in
(
	select codPel from pelicula where titulo='rey leon'
)

intersect

select codCliente from prestamo where codPel in
(
	select codPel from pelicula where titulo='Terminator'
)

/*Ejercicio 5
Listar las pel�culas m�s vistas en cada mes (Mes, Pel�cula, Cantidad de Alquileres).*//*Ejercicio 6
Listar los clientes que hayan alquilado todas las pel�culas del video.*/select codCliente from cliente clie where not exists(		select 1 from pelicula pel where not exists	(		select 1 from prestamo pres where pres.codCliente=clie.codCliente and pres.codPel=pel.codPel 	))/*Ejercicio 7
Listar las pel�culas que no han registrado ning�n pr�stamo a la fecha.*/select codPel from prestamo where fPrest < '2022-10-17' and not exists
(
    select codPel from pelicula
)

/*Ejercicio 8
Listar los clientes que no han efectuado la devoluci�n de ejemplares.*/

select codCliente from prestamo where fDev is null


/*Ejercicio 9
Listar los t�tulos de las pel�culas que tienen la mayor cantidad de pr�stamos.*/create view PelCant(codPel,cantPrestamos) asselect codPel,count(codPel) from prestamo group by(codPel)select codPel from PelCant where cantPrestamos = all(select max(cantPrestamos) from PelCant)/*Ejercicio 10
 Listar las pel�culas que tienen todos los ejemplares prestados.*/select *from pelicula pel where not exists(		select 1 from ejemplar eje where not exists	(		select 1 from prestamo pres  where pres.codPel=pel.codPel and pres.codEjemplar=eje.codEjemplar	))