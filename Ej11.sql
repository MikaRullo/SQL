create database Ej11
create table pelicula
(
	codPel int primary key,
	titulo varchar(30),
	duracion int,
	codGenero int,
	idDirector int,
	constraint fkGen foreign key(codGenero) references genero(id) on update cascade,
	constraint fkDir foreign key(idDirector) references director(id) on update cascade
)

create table genero
(
	id int primary key,
	nomGenero varchar (30)
)

create table director
(
	id int primary key,
	NyA varchar(50)
)

create table ejemplar
(
	nroEjem int,
	codPel int,
	estado int,
	primary key(nroEjem,codPel),
	constraint fkPel foreign key(codPel) references pelicula(codPel) on update cascade
)

create table cliente 
(
	codCli int primary key,
	NyA varchar(50),
	direccion varchar(30),
	tel int,
	email varchar(50),
	borrado int,
)

create table alquiler
(
	id int primary key,
	nroEjem int,
	codPel int,
	codCli int,
	fAlg date,
	fDev date,
	constraint fkEjem foreign key(nroEjem, codPel) references ejemplar(nroEjem, codPel) on update cascade,
	constraint fkClie foreign key(codCli) references cliente(codCli) on update cascade,
)
 
insert into cliente values(1,'Maria Pia','Calle 1',123,'mapi@gmail.com',1)
insert into cliente values(2,'Lucas Rullo','Calle 1',123,'lr@gmail.com',1)
insert into cliente values(3,'Emma Gomez','Calle 2',456,'emg@gmail.com',2)
insert into cliente values(4,'Mika Pia','Calle 3',465,'mirp@gmail.com',2)
insert into cliente values(5,'Berpi stark','Calle 4',782,'bsk@gmail.com',1)

insert into genero values(01,'Accion')
insert into genero values(02,'Aventura')
insert into genero values(03,'Baile')
insert into genero values(04,'Romantico')
insert into genero values(05,'Infantil')


insert into director values(01,'Juan Perez')
insert into director values(02,'Juan Lucas')
insert into director values(03,'Juan Gomez')
insert into director values(04,'Enri Hugo')
insert into director values(05,'J Martin')
insert into director values(06,'Mia Gomez')

insert into pelicula values(001,'Rey Leon',2,05,01)
insert into pelicula values(002,'El niño',3,01,01)
insert into pelicula values(003,'Pocajontas',1,02,02)
insert into pelicula values(004,'Charlie',5,03,03)
insert into pelicula values(005,'La Muerte',2,02,04)
insert into pelicula values(006,'La Vida',7,01,06)
insert into pelicula values(007,'Los Gatos',3,01,06)
insert into pelicula values(008,'Enemigos',6,04,05)
insert into pelicula values(009,'Moana',2,04,01)
insert into pelicula values(010,'Cars',1,02,06)


insert into ejemplar values(1,001,1)
insert into ejemplar values(2,002,1)
insert into ejemplar values(3,003,1)
insert into ejemplar values(4,004,0)
insert into ejemplar values(5,005,1)
insert into ejemplar values(6,006,1)
insert into ejemplar values(7,007,0)
insert into ejemplar values(8,008,1)
insert into ejemplar values(9,009,1)
insert into ejemplar values(10,010,1)
insert into ejemplar values(11,001,0)
insert into ejemplar values(12,009,0)


insert into alquiler values(1,1,001,1,'2022-10-19','2022-10-20')
insert into alquiler values(2,2,002,1,'2022-10-2','2022-10-3')
insert into alquiler values(3,3,003,2,'2022-10-1','2022-10-2')
insert into alquiler values(4,4,004,2,'2022-10-10','2022-10-11')
insert into alquiler values(5,5,005,3,'2022-10-12','2022-10-13')
insert into alquiler values(6,6,006,3,'2022-10-19','2022-10-20')
insert into alquiler values(7,7,007,4,'2022-10-5','2022-10-6')
insert into alquiler values(8,8,008,5,'2022-10-2','2022-10-20')
insert into alquiler values(9,9,009,5,'2022-10-19','2022-10-22')
insert into alquiler values(10,10,010,2,'2022-10-17','2022-10-20')
insert into alquiler values(11,11,001,2,'2022-10-2','2022-10-5')
insert into alquiler values(12,12,009,3,'2022-9-19','2022-10-1')
insert into alquiler values(13,1,001,4,'2022-9-11','2022-10-2')
insert into alquiler values(14,2,002,5,'2022-9-12','2022-10-3')
insert into alquiler values(15,8,008,5,'2022-8-5','2022-10-1')

--3 Agregue el atributo “año” en la tabla Película.

alter table pelicula add anio date

--4 Actualice la tabla película para que incluya el año de lanzamiento de las películas en stock.

select *from pelicula

update pelicula set anio='2001' where codPel=1
update pelicula set anio='2005' where codPel=2
update pelicula set anio='2015' where codPel=3
update pelicula set anio='2010' where codPel=4
update pelicula set anio='2004' where codPel=5
update pelicula set anio='1997' where codPel=6
update pelicula set anio='1993' where codPel=7
update pelicula set anio='2022' where codPel=8
update pelicula set anio='2013' where codPel=9
update pelicula set anio='2012' where codPel=10

--5 Queremos que al momento de eliminar una película se eliminen todos los ejemplares de la misma.

ALTER TABLE EJEMPLAR
DROP CONSTRAINT fkEkemplar

ALTER TABLE EJEMPLAR ADD
CONSTRAINT fkEkemplar FOREIGN KEY(codPel) REFERENCES PELICULA(codPel)ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE ALQUILER
DROP CONSTRAINT fkEjemAlq

ALTER TABLE ALQUILER ADD
CONSTRAINT fkEjemAlq FOREIGN KEY(nroEj, codPel) REFERENCES EJEMPLAR(nroEj, codPel) ON DELETE CASCADE ON UPDATE CASCADE

DELETE FROM Pelicula  WHERE titulo LIKE 'Rey Leon'