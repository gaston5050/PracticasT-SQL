use master
go 
drop database pruebaDerIntergrador
go

create database pruebaDerIntergrador
go 


create table Actividades (
ID_Actividad int not null primary key identity,
Nombre varchar(50) not null,
FechaDisponibleDesde datetime not null,
CostoActividad money not null check (CostoActividad >0) ,
Estado bit not null
)

create table Socios (
ID_Socio int not null primary key identity,
Apellidos varchar(50) not null,
Nombres varchar(50) not null,
FechaNacimiento datetime not null,
FechaAsociacion datetime not null,
Estado bit not null
)

alter table ActividadesxSocio (
ID_Socio int not null foreign key references Socios(ID_Socio),
ID_Actividad int not null foreign key references Actividades(ID_Actividad),
FechaInscripcion datetime not null,
primary key(ID_Socio, ID_Actividad)
)





alter table cargo
alter column idcargo int not null
alter table cargo
add constraint pk_cargo primary key (idcargo) 








create table PlantaDocente(
ID int primary key identity,
legajo int unique,
id_materia int,
id_cargo int foreign key references cargo(idcargo),
año int
)