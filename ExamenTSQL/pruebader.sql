go
create database pruebaDerIntergrador
go 
create table cargo (
idcargo int,
nombre varchar(50)
)
alter table cargo
modify idcargo int primary key


create table PlantaDocente(
ID int primary key identity,
legajo int unique,
id_materia int,
id_cargo int foreign key references cargo(idcargo),
año int
)