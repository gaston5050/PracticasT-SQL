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

 CREATE PROCEDURE  SP_MULTASVEHICULO ( @patente varchar (7) )
 as
 begin 
	select  datefromparts (m.fechahora), datepart(hour, m.fechahora), tp.descripcion,  m.monto
	from multas m 
	inner join TipoInfracciones tp on tp.IdTipoInfraccion = m.IdTipoInfraccion

 end
 




	CREATE PROCEDURE SP_NOMBREAGENTE(
	@IDAGENTE INT )
	AS 
	BEGIN 
	SELECT AG.NOMBRES FROM AGENTES AG
	WHERE AG.IdAgente = @IDAGENTE
	END 
	EXEC SP_NOMBREAGENTE 4




	

--4 Crear una función que reciba un parámetro que representa la patente de un vehículo
--y devuelva el total adeudado por ese vehículo en concepto de multas.



--5 Crear una función que reciba un parámetro que representa la patente de un vehículo
--y devuelva el total abonado por ese vehículo en concepto de multas.
--6 Crear un procedimiento almacenado llamado SP_AgregarMulta que reciba
--IDTipoInfraccion, IDLocalidad, IDAgente, Patente, Fecha y hora, Monto a abonar y
--registre la multa.
--7 Crear un procedimiento almacenado llamado SP_ProcesarPagos que determine el
--estado Pagada de todas las multas a partir de los pagos que se encuentran
--registrados (La suma de todos los pagos de una multa debe ser igual o mayor al
--monto de la multa para considerarlo Pagado).