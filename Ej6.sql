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



--1 Hallar los n�meros de vuelo desde el origen A hasta el destino F.