--2) Haciendo uso de las tablas realizadas en el punto anterior resolver la siguiente
--consulta de selección: Listar todos los datos de todos los socios que hayan
--realizado todas las actividades que ofrece el club.

	declare @cantActividades int
	select @cantActividades = count(*) from Actividades
	--print @cantActividades
	
	select * from socios s where (select count(*) from ActividadesxSocio axs
	inner join Actividades a on a.ID_Actividad = axs.ID_Actividad
	where s.ID_Socio = axs.ID_Socio) = @cantActividades

	insert into Actividades (Nombre, FechaDisponibleDesde, CostoActividad, Estado)
	values ('gaston', getdate(),1405, 1)
	insert into Actividades (Nombre, FechaDisponibleDesde, CostoActividad, Estado)
	values ('katate', '2023-05-06',1405, 1)
	insert into Actividades (Nombre, FechaDisponibleDesde, CostoActividad, Estado)
	values ('ninjutsu', '2023-03-06',1405, 1)
	insert into Actividades (Nombre, FechaDisponibleDesde, CostoActividad, Estado)
	values ('cocina', '2023-03-06',6, 0)
	insert into Actividades (Nombre, FechaDisponibleDesde, CostoActividad, Estado)
	values ('arte', '2023-09-06',145, 1)

	insert into socios (apellidos, Nombres, FechaNacimiento, FechaAsociacion, estado)
	values 
	('gaston', 'ayala', '1985-10-14',GETDATE(), 1),
	('benitez', 'ivan', '1985-09-10',GETDATE(), 1),
	('lizondo', 'cristian', '1985-11-12',GETDATE(), 1)
	select * from socios
	select * from Actividades
	select * from ActividadesxSocio
	--drop table actividadesxsocio
	select s.id_socio, s.nombres, a.nombre from socios s
	inner join ActividadesxSocio axs on axs.ID_Socio = s.ID_Socio
	inner join Actividades a on a.ID_Actividad = axs.ID_Actividad
	where s.ID_Socio = 2
	order by a.ID_Actividad asc

insert into ActividadesxSocio (ID_Socio, ID_Actividad, FechaInscripcion)
VALUES
(1,1,getdate()),
(1,2,getdate()),
(1,3,getdate()),
(1,4,getdate()),
(1,5,getdate()),
(2,1,getdate()),
(2,2,getdate()),
(2,3,getdate()),
(2,4,getdate()),
(3,1,getdate()),
(3,2,getdate()),
(3,3,getdate()),
(3,4,getdate()),
(3,5,getdate())


--3) Haciendo uso de la base de datos que se encuentra en el Campus Virtual
--resolver:
--Hacer un trigger que al ingresar un registro no permita que un docente pueda
--tener una materia con el cargo de profesor (IDCargo = 1) si no tiene una
--antigüedad de al menos 5 años. Tampoco debe permitir que haya más de un
--docente con el cargo de profesor (IDCargo = 1) en la misma materia y año. Caso
--contrario registrar el docente a la planta docente.
go
 alter trigger  tr_IngresarDocente on plantadocente
 instead of insert
 as
 begin
	
	declare @antiguedad int
	declare @legajo int 
	declare @idcargo int
	declare @año int
	declare @idmateria int

	select @idmateria = id_materia from inserted
	select @año = año from inserted
	select @idcargo = Id_cargo from inserted
	select @legajo = legajo from inserted 
	select @antiguedad = (select year(getdate())- d.añoIngreso from docentes d
	where d.Legajo = @legajo)

	print @antiguedad

	if @antiguedad < 5 
	begin
		raiserror('poca antiguedad', 16,1)
		declare @error  varchar(239)
		set @error = error_message()
		print @error

	return
	end
	if(select count(*) from plantadocente p 
	where p.año = @año and p.id_materia = @idmateria and p.id_cargo = @idcargo) > 0
	begin

		raiserror('ya hay docente de esta materia en este año', 16,1)
		declare @error2  varchar(239)
		set @error2 = error_message()
		print @error2
		return 

	end


	insert into PlantaDocente
	select legajo, id_materia,id_cargo, año from inserted




 end
 go
 select * from PlantaDocente
 insert into PlantaDocente (legajo, ID_Materia,ID_Cargo, año)
 values (2,3,1,2021)

select * , (select year(getdate()) - AñoIngreso) antiguedad from docentes d
select * from docentes 
select * from cargos




--4) Haciendo uso de la base de datos que se encuentra en el Campus Virtual
--resolver:
--Hacer una función SQL que a partir de un legajo docente y un año devuelva la
--cantidad de horas semanales que dedicará esa persona a la docencia ese año.
--La cantidad de horas es un número entero >= 0.
--NOTA: No hace falta multiplicarlo por la cantidad de semanas que hay en un año.
--20

select * from docentes
select * from PlantaDocente
order by legajo asc
select * from materias
select d.legajo, sum(m.horasSemanales) from docentes d
inner join PlantaDocente pd on pd.Legajo = D.Legajo
inner join materias m on m.ID_Materia = PD.ID_Materia
where año = 2021
GROUP BY D.Legajo

SELECT  d.legajo , dbo.fn_cantHorasxdocente(d.Legajo, 2021) from docentes d


where d.legajo = 1


inner join PlantaDocente pd on d.Legajo = pd.Legajo



alter function fn_cantHorasxdocente(
	@id_legajo int,
	@año int
	)
returns int 
begin
	declare @total int
	select @total = isnull(sum(m.horasSemanales), 0) from materias m
	inner join plantadocente pd on pd.ID_Materia = m.ID_Materia
	where @id_legajo = pd.Legajo  and @año = pd.Año


	return @total
end


 create function fn_cantidadHoras (
	@id_legajo varchar(9)
	)
returns int
as 
begin

declare @pagas int

select @pagas = count(*) from multas m where m.Patente like @patente and m.Pagada = 1

return  @pagas
end	


--5) Haciendo uso de la base de datos que se encuentra en el Campus Virtual
--resolver:
--Hacer un procedimiento almacenado que reciba un ID de Materia y liste la

--cantidad de docentes distintos que han trabajado en ella.

alter procedure sp_cantidadDocentes (
	@id_materia int 
	)
as 
begin

	
	select count(distinct p.legajo) from PlantaDocente p
	where p.id_Materia = @id_materia

	
	
end

select count(distinct p.legajo) from PlantaDocente p
group by p.ID_Materia
exec sp_cantidadDocentes 7


