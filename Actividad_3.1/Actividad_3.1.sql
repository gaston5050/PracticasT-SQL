--# Ejercicio
--1 Crear una vista llamada VW_Multas que permita visualizar la información de las
--multas con los datos del agente incluyendo apellidos y nombres, nombre de la
--localidad, patente del vehículo, fecha y monto de la multa.

	create view VW_Multas as 
	select ag.apellidos  APELLIDO_AGENTE, ag.nombres NOMBRES_AGENTE, l.localidad LOCALIDAD, m.patente, m.fechaHORA FECHA, m.monto MONTO    from multas m
	INNER JOIN AGENTES AG ON AG.IdAgente = M.IdAgente 
	INNER JOIN Localidades L ON M.IDLocalidad = L.IDLocalidad

	SELECT * FROM vw_multas



--2 Modificar la vista VW_Multas para incluir el legajo del agente, la antigüedad en años,
--el nombre de la provincia junto al de la localidad y la descripción del tipo de multa.
	GO
	alter view  vw_multas as
	select ag.legajo LEGAJO, DATEDIFF(YEAR, AG.FECHAINGRESO,getdate()) ANTIGUEDAD, ag.apellidos  APELLIDO_AGENTE, ag.nombres NOMBRES_AGENTE, l.localidad LOCALIDAD,P.Provincia PROVINCIA, m.patente PATENTE, m.fechaHORA FECHA, m.monto MONTO, TP.Descripcion DESCRIPCION    from multas m
	INNER JOIN AGENTES AG ON AG.IdAgente = M.IdAgente 
	INNER JOIN Localidades L ON M.IDLocalidad = L.IDLocalidad
	INNER JOIN Provincias P ON P.IDProvincia = L.IDProvincia
	INNER JOIN TipoInfracciones TP ON TP.IdTipoInfraccion = M.IdTipoInfraccion
	GO
		SELECT * FROM vw_multas
		ALTER VIEW VW_MULTAS AS
		DROP VIEW Vw_MULTAS
-- CON PARAMETROS
--CREATE PROCEDURE nombre_SP(
--@nombre VARCHAR(50),
--@edad INT
--)
--AS
--BEGIN
--SELECT @nombre AS Nombre, @edad AS Edad
--END
---------------------
--SIN PARAMETROS
--CREATE PROCEDURE nombre_SP
--AS
--BEGIN
--PRINT 'HOLA MUNDO'
--END


--3 Crear un procedimiento almacenado llamado SP_MultasVehiculo que reciba un
--parámetro que representa la patente de un vehículo. Listar las multas que registra.
--Indicando fecha y hora de la multa, descripción del tipo de multa e importe a abonar.
--También una leyenda que indique si la multa fue abonada o no.
--select convert(char(8), getdate(), 108) as [hh:mm:ss]; X
--select convert(varchar, getdate(), 1) V
 CREATE PROCEDURE  SP_MULTASVEHICULO ( @patente varchar (7) )
 as
 begin 
	select  convert (date, m.fechahora, 1) FECHA,  convert(time, m.fechahora) HORA, tp.descripcion DESCRIPCION,  m.monto MONTO
	from multas m 
	inner join TipoInfracciones tp on tp.IdTipoInfraccion = m.IdTipoInfraccion

 end
 
 --funcion con total de multas pagas y no pagas por patente

 create function fn_multasPagas (
	@patente varchar(9)
	)
returns int
as 
begin

declare @pagas int

select @pagas = count(*) from multas m where m.Patente like @patente and m.Pagada = 1

return  @pagas
end				

create function fn_MULTASNOPAGAS (
	@patente varchar(9)
	)
returns int
as 
begin

declare @pagas int

select @pagas = count(*) from PAGOS P
LEFT JOIN MULTAS M ON P.IDMulta = M.IdMulta
where m.Patente like @patente and m.Pagada = 0

return  @pagas
end				




select dbo.fn_multasPagas(M.Patente) PAGAS, DBO.fn_MULTASNOPAGAS(M.Patente) from multas m

where m.Patente like 'AB123CD'


select * from multas M
ORDER BY M.PATENTE



 go
 create function fn_totalMultas(
	@patente varchar (9)
	)
	returns money
	as 
	begin
	declare @total money
	select @total = isnull(sum(monto), 0) from multas
	where Patente LIKE @patente 
	return @total
	end
	go
	---
	go
	drop function fn_totalPagos
create function fn_totalPagos(
	@patente varchar (9)
	)
	returns money
	as 
	begin 
	declare @total money
	select @total = isnull(sum(p.importe) ,0) from pagos p
	left join multas m on p.IDMulta = m.IdMulta
	where m.Patente LIKE @patente
	return @total
	end
	go

	select distinct m.patente, dbo.fn_totalPagos(m.patente), dbo.fn_totalmultas(m.patente) from multas m

	select m.patente, * from multas group by Multas.Patente
	select m.patente, isnull(sum(p.importe), 0) pago,  isnull(sum(m.monto),0) multa from multas m
	left  join pagos p on m.idmulta = p.idmulta
	group by m.patente




--4 Crear una función que reciba un parámetro que representa la patente de un vehículo
--y devuelva el total adeudado por ese vehículo en concepto de multas.

create function fn_totalMultasActual(
	@patente varchar (9)
	)
returns money
as 
begin 
declare  @total money

select @total = sum(m.monto) from multas m 
where m.Patente like @patente
return @total
end
select dbo.fn_totalMultasactual ('ab123cd')
select * from multas

alter function fn_totalMultasActual(
	@patente varchar (9)
	)
returns money
as 
begin 
declare  @total money

select @total = sum(m.monto) from multas m 
where m.Patente like @patente and m.Pagada = 0
return @total
end
select dbo.fn_totalMultasactual ('ab123cd')
select * from multas
order by Patente asc





--5 Crear una función que reciba un parámetro que representa la patente de un vehículo
--y devuelva el total abonado por ese vehículo en concepto de multas.

	create FUNCTION fn_totalAbonado (
	@patente varchar(9)
	)
	returns money
	as 
	begin
	declare @total money
	select @total = isnull(sum(m.importe),0) from pagos p
	left join multas m on m.IDMulta = p.IDMulta

	where (m.Patente = @patente) and m.Pagada = 1

	return @total
	end


	select m.patente, dbo.fn_totalAbonado (m.Patente) from multas M
	select * from pagos
	update multas  set pagada  = 1
	where idmulta = 1
	select * from multas 
	where patente like 'ab123cd'


--6 Crear un procedimiento almacenado llamado SP_AgregarMulta que reciba
--IDTipoInfraccion, IDLocalidad, IDAgente, Patente, Fecha y hora, Monto a abonar y
--registre la multa.
select * from multas
	alter procedure sp_agregarMulta( 
	@idTipoInfraccion int,
	@idlocalidad int, 
	@idagente int,
	@patente varchar(9),
	@monto money
	)
	as
	begin
		DECLARE @FECHITA DATETIME 
	    SET @FECHITA = GETDATE()
		insert into multas (idtipoinfraccion, idlocalidad, idagente, patente, FechaHora, monto)
		values( @idtipoinfraccion,   @idlocalidad, @idagente, @patente,@FECHITA, @monto)

	end
	SELECT * FROM MULTAS
	DECLARE @FECHITA DATETIME 
	SET @FECHITA = GETDATE()
	exec sp_agregarmulta 4, 12, 1, 'ZAB234', 50


--7 Crear un procedimiento almacenado llamado SP_ProcesarPagos que determine el
--estado Pagada de todas las multas a partir de los pagos que se encuentran
--registrados (La suma de todos los pagos de una multa debe ser igual o mayor al
--monto de la multa para considerarlo Pagado).

select distinct patente from multas
	
--	
exec sp_procesarpagos

	alter procedure SP_procesarPagos
	as 
	begin 
				update multas set pagada = 1
				where idmulta  in (
									select idmulta from (
									select distinct p.idmulta,
									(select sum(m.monto) from multas m 
									where  p.idmulta = m.idmulta) deudaPorMulta,

									(select sum(pa.importe) from pagos pa
									left join multas m on pa.IDMulta = m.idmulta
									where  p.idmulta = m.idmulta) pagoMulta

									from pagos p
									)  aux
									where aux.deudaPorMulta <= aux.pagoMulta
							   	)

		
			
			
	end

		



	--select idmulta from (
	--			select distinct p.idmulta,
	--			(select sum(m.monto) from multas m 
	--			where  p.idmulta = m.idmulta) deudaPorMulta,
	--
	--			(select sum(pa.importe) from pagos pa
	--			left join multas m on pa.IDMulta = m.idmulta
	--			where  p.idmulta = m.idmulta) pagoMulta
	--
	--			from pagos p
	--			)  aux
	--			where aux.deudaPorMulta <= aux.pagoMulta
	--			
	--			
	--
	--
	--use AgenciaTransito
	--select * from multas
	--
	--update multas set pagada = 0
	--where idmulta = 1


-- ESTRUCTURA TRANSACCIon
	--comentar varias lineas de codigo ctrl + k , ctrl + c
	-- descomentar varias lineas de codigo ctrl + k , ctrl + u

		BEGIN TRY
		 BEGIN TRANSACTION
		 COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		 ROLLBACK TRANSACTION
		END TRANSACTION

	