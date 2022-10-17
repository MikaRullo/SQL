create table Persona
(
	dni int primary key,
	nomPerso varchar(30),
	tel int,
)

create table Empresa
(
	nomEmp varchar(100) primary key,
	tel int,
)

create table Vive
(
	dni int,
	calle varchar(100),
	ciudad varchar(100),
	constraint pkVive primary key (dni),
	constraint fkViv foreign key(dni) references Persona(dni) on update cascade
)

create table Trabaja
(
	dni int,
	nomEmp varchar(100),
	salario float,
	fIng date,
	fEgre date,
	constraint pkTrab primary key(dni),
	constraint fkPer foreign key(dni) references Persona(dni) on update cascade,
	constraint fkEmp foreign key(nomEmp) references Empresa(nomEmp) on update cascade
)

create table SituadaEn
(
	nomEmp varchar(100),
	ciudad varchar(100),
	constraint fkEm primary key(nomEmp),
	constraint fkEmpr foreign key(nomEmp) references Empresa(nomEmp) on update cascade
)

create table Supervisa
(
	dniPer int,
	dniSup int,
	
	constraint pkSuper primary key(dniPer,dniSup),
	constraint fkPers foreign key(dniPer) references Persona(dni),
	constraint fkPe foreign key(dniSup) references Persona(dni),
)

insert into Persona values(43666521,'Maria Pia',22365)
insert into Persona values(48555213,'Mika Gonzales',3349)
insert into Persona values(14556982,'Ema Gomez',485123)
insert into Persona values(7759213,'Lucas Rullo',145236)
insert into Persona values(75222965,'Tony Stark',147592)
insert into Persona values(42333651,'Claudia Manda',751236)
insert into Persona values(12336547,'Salma Lujan',745123)


insert into Empresa values('Bancelco', 123)
insert into Empresa values('Telecom', 456)
insert into Empresa values('Paulinas', 789)
insert into Empresa values('Clarin', 134)
insert into Empresa values('Sony', 781)


insert into Vive values(43666521,'Calle 1','Caballito')
insert into Vive  values(48555213,'Calle 1','Caballito')
insert into Vive  values(14556982,'Calle 5','San Justo')
insert into Vive  values(7759213,'Calle 25','La Plata')
insert into Vive  values(75222965,'Calle 7','La Plata')
insert into Vive  values(42333651,'Calle 5','Lomas')
insert into Vive  values(12336547,'Calle 5','Huergo')


insert into Trabaja values(43666521,'Bancelco',4000,'2022-10-15', NULL)
insert into Trabaja  values(48555213,'Telecom',1000,'2000-10-15',NULL)
insert into Trabaja  values(14556982,'Paulinas',200,'2000-01-10','2000-01-13')
insert into Trabaja  values(7759213,'Bancelco',50,'2015-02-05','2018-10-15')
insert into Trabaja  values(75222965,'Clarin',4201,'2021-09-11','2002-02-15')
insert into Trabaja  values(42333651,'Clarin',15720,'2022-09-07','2022-10-05')
insert into Trabaja  values(12336547,'Telecom',112541,'2004-02-02','2005-10-15')


insert into SituadaEn values('Bancelco', 'Caballito')
insert into SituadaEn values('Telecom','San Justo')
insert into SituadaEn values('Paulinas', 'Hornos')
insert into SituadaEn values('Clarin', 'La Plata')
insert into SituadaEn values('Sony', 'Caballito')

insert into Supervisa values(43666521, 48555213)
insert into Supervisa values(14556982, 7759213)
insert into Supervisa values(75222965,42333651)
insert into Supervisa values(12336547, 43666521)
insert into Supervisa values(7759213,43666521)

/* Ejercicio 1
Encontrar el nombre de todas las personas que trabajan en la empresa “Banelco”
*/

select nomPerso from Persona where dni in
(
	select dni from Trabaja where nomEmp='Bancelco'
)

/* Ejercicio 2
Localizar el nombre y la ciudad de todas las personas que trabajan para la empresa “Telecom”.
*/

select per.nomPerso, viv.ciudad from Vive viv, Persona per where viv.dni = per.dni and per.dni in
(
    select dni from Trabaja WHERE nomEmp Like 'Telecom'
)

/* Ejercicio 3
Buscar el nombre, calle y ciudad de todas las personas que trabajan para la empresa “Paulinas” y ganan más de $1500. (150)
*/

select per.nomPerso, viv.calle,viv.ciudad from Vive viv, Persona per where viv.dni = per.dni and per.dni in
(
	select dni from Trabaja WHERE nomEmp Like 'Paulinas' and salario > 150 
)

/* Ejercicio 4
Encontrar las personas que viven en la misma ciudad en la que se halla la empresa en donde trabajan.
*/

select viv.dni from Trabaja trab, SituadaEn sit, Vive viv 
where sit.nomEmp = trab.nomEmp and trab.dni= viv.dni and  sit.ciudad =viv.ciudad

/* Ejercicio 5
Hallar todas las personas que viven en la misma ciudad y en la misma calle que su supervisor.
*/

create view perso(dni,calle,ciudad) as
select *from Vive where dni in
(
	select dniPer from Supervisa 
)

create view sup(dni,calle,ciudad) as
select *from Vive where dni in
(
	select dniSup from Supervisa 
)

select per.dni,su.dni from perso per cross join sup su where per.dni <> su.dni and per.calle = su.calle and per.ciudad = su.ciudad


/* Ejercicio 6
Encontrar todas las personas que ganan más que cualquier empleado de la empresa “Clarín”.
*/

select dni from Trabaja where salario >(select max(salario) from Trabaja where nomEmp='clarin')


/* Ejercicio 7
Localizar las ciudades en las que todos los trabajadores que vienen en ellas ganan más de $1000.
*/

select ciudad from Vive where dni in 
(
	select dni from Trabaja where salario >1000
)

/* Ejercicio 8
Listar los primeros empleados que la compañía “Sony” contrató. (clarin)
*/

select dni from trabaja where fIng = (select min(fIng) from Trabaja where nomEmp='clarin')

select dni, min(fIng) from Trabaja where nomEmp='clarin' group by(dni)

