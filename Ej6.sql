create table vuelo
(
	nroVuelo varchar(20),
	desde varchar(20),
	hasta varchar(20),
	fecha date,
	primary key(nroVuelo),
)

create table avion
(
	nroVuelo varchar(20),
	tAvion varchar(20),
	nroAvion varchar(20),
	primary key(nroVuelo),
	constraint fkAv foreign key (nroVuelo) references vuelo(nroVuelo)on update cascade
)

create table pasajeros
(
	nroVuelo varchar(20),
	docuemto int,
	nombre varchar(30),
	origen varchar(20),
	destino varchar(20),
	primary key(nroVuelo,docuemto),
	constraint fkAvi foreign key (nroVuelo) references vuelo(nroVuelo)on update cascade
)

INSERT INTO vuelo VALUES('V001','a','f','1999-12-22')
INSERT INTO Vuelo VALUES('V002','D','C','2021-11-21')
INSERT INTO Vuelo VALUES('V003','B','P','2022-11-2')
INSERT INTO Vuelo VALUES('V004','F','A','2021-10-21')
INSERT INTO Vuelo VALUES('V005','C','L','2017-6-5')
INSERT INTO Vuelo VALUES('V006','L','C','2022-1-18')
INSERT INTO Vuelo VALUES('V007','L','B','2022-1-18')

INSERT INTO Avion VALUES('V001','V-777','A001')
INSERT INTO Avion VALUES('V002','B-777','A001')
INSERT INTO Avion VALUES('V003','B-777','A002')
INSERT INTO Avion VALUES('V004','B-999','A003')
INSERT INTO Avion VALUES('V005','A-555','A005')
INSERT INTO Avion VALUES('V006','C-777','A007')
INSERT INTO Avion VALUES('V007','D-777','A007')

INSERT INTO Pasajeros VALUES('V001','4344762','Lucas','A','B')
INSERT INTO Pasajeros VALUES('V002','4124762','Mika','B','P')
INSERT INTO Pasajeros VALUES('V003','4345262','Tulio','C','L')
INSERT INTO Pasajeros VALUES('V004','4344122','Julio','L','F')
INSERT INTO Pasajeros VALUES('V005','4341162','Claudia','A','P')
INSERT INTO Pasajeros VALUES('V006','4244762','Sebastian','B','L')
INSERT INTO Pasajeros VALUES('V007','4244122','Sofia','A','F')
INSERT INTO Pasajeros VALUES('V007','1234567','Ayelen','A','D')
INSERT INTO Pasajeros VALUES('V006','7654321','Berpi','B','L')
INSERT INTO Pasajeros VALUES('V001','7654320','Daemon','T','H')
INSERT INTO Pasajeros VALUES('V003','4244762','Sebastian','C','L')
INSERT INTO Pasajeros VALUES('V001','1234567','Ayelen','A','B')



--1 Hallar los números de vuelo desde el origen A hasta el destino F.select nroVuelo from pasajeros where origen='a' and destino='f'--2 Hallar los tipos de avión que no son utilizados en ningún vuelo que pase por B.select tAvion from avion where nroVuelo in(	select nroVuelo from vuelo 	except	select nroVuelo from vuelo where desde='b' or hasta='b')--3 Hallar los pasajeros y números de vuelo para aquellos pasajeros que viajan desde A a D pasando por B.select nroVuelo, docuemto from pasajeros where origen='a' and destino='d' and nroVuelo in(	select nroVuelo from vuelo where desde='b' or hasta='b')--4 Hallar los tipos de avión que pasan por C. select tAvion from avion where nroVuelo in(	select nroVuelo from vuelo where desde='c' or hasta='c')--5 Hallar por cada Avión la cantidad de vuelos distintos en que se encuentra registrado.select nroAvion, count(nroAvion) as cantidadDeVuelos from avion group by nroAvion --6 Listar los distintos tipo y nro. de avión que tienen a H como destino.select  nroAvion, tAvion from avion where nroVuelo in(	select nroVuelo from pasajeros where destino='h')--7 Hallar los pasajeros que han volado más frecuentemente en el último año.create view Frecuente(documento,cant) asselect docuemto, count(nroVuelo)  from pasajeros where nroVuelo in(	select nroVuelo from vuelo where fecha between '2022-01-01' and '2022-12-31')group by(docuemto)select *from Frecuente where cant=all(select max(cant) from Frecuente)--8 Hallar los pasajeros que han volado la mayor cantidad de veces posible en un B-777.create view Vub777(documento, cant) asselect docuemto, count(nroVuelo) from pasajeros where nroVuelo in(	select nroVuelo from avion where tAvion='b-777')group by docuemtoselect documento from Vub777 where cant =all( select max(cant) from Vub777) --9 Hallar los aviones que han transportado más veces al pasajero más antiguo.select nroAvion from avion where nroVuelo in(	select nroVuelo from pasajeros where docuemto =all(select min(docuemto) from pasajeros))--10 Listar la cantidad promedio de pasajeros transportados por los aviones de la compañía, por tipo de avión.create view cantXvuelos(nroVuelo,cant) asselect nroVuelo,count(nroVuelo) from pasajeros  group by nroVuelocreate view SumXtAv(tAvion,cant) asselect a.tAvion, sum(c.cant) from avion a inner join cantXvuelos c on a.nroVuelo=c.nroVuelo group by(a.tAvion)select avg(cant) as Prom from SumXtAv --11 Hallar los pasajeros que han realizado una cantidad de vuelos dentro del 10% en --más o en menos del promedio de vuelos de todos los pasajeros de la compañía.