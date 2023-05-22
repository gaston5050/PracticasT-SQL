--# Consulta
--1 Listado con la cantidad de agentes
--	select * from agentes
--	select count(Legajo) from agentes
--2 Listado con importe de referencia promedio de los tipos de infracciones

--	select   idtipoinfraccion, avg(monto) from multas
--	group by IdTipoInfraccion
--	order by idTipoInfraccion asc
select * from mediosPago
select * from Pagos

	
	


--3 Listado con la suma de los montos de las multas. Indistintamente de si fueron
--pagadas o no.

	select idtipoinfraccion, sum(monto) from multas
	group by IdTipoInfraccion


--4 Listado con la cantidad de pagos que se realizaron.
		select * from multas 
		where pagada = 0

--5 Listado con la cantidad de multas realizadas en la provincia de Buenos Aires.
--NOTA: Utilizar el nombre 'Buenos Aires' de la provincia.
	select * from Localidades
	select * from provincias
	select m.* from multas m
	inner join Localidades l on m.IDLocalidad = l.IDLocalidad
	inner join Provincias p on p.IDProvincia = l.IDProvincia
	where p.Provincia = 'Buenos Aires'


--6 Listado con el promedio de antigüedad de los agentes que se encuentren activos.
	select datediff(year,fechaingreso, getdate()) from agentes

	select avg (datediff(year,fechaingreso, getdate())*1.0) from agentes
	where activo = 1
	select * from Agentes

--7 Listado con el monto más elevado que se haya registrado en una multa.
	select max(monto) from multas
	select * from multas
	order by monto desc
	


--8 Listado con el importe de pago más pequeño que se haya registrado.
	select min(monto) from multas
--9 Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que
--registraron.
	select ag.legajo, ag.apellidos, ag.nombres,count (m.IdAgente) cantidad from  agentes ag
	inner join multas m on m.IdAgente = ag.IdAgente
	group by legajo, apellidos, nombres
	
	


--10 Por cada tipo de infracción, listar la descripción y el promedio de montos de las
--multas asociadas a dicho tipo de infracción.
select * from  multas
order by IdTipoInfraccion
	select ti.descripcion, avg(m.monto*1.0)  from TipoInfracciones ti
	inner join multas m on m.IdTipoInfraccion = ti.IdTipoInfraccion
	group by Descripcion
	

--11 Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de
--pagos realizados. Solamente mostrar la información de las multas que hayan sido
--pagadas en su totalidad.
		
		select m.FechaHora, m.Patente, m.Monto, count( p.idpago) 
		from multas m
		inner join pagos p on p.IDMulta = m.IdMulta

		select * from pagos

		--update multas
		--set pagada = 1 
		--where IdMulta = 3
		---SELECT * FROM MULTAS
	--insert into multas( IdTipoInfraccion,IDLocalidad,IdAgente,Patente,FechaHora,Monto,Pagada)
	--values(2,16,3,'abc333',getdate(),666,1)


--12 Listar todos los datos de las multas que hayan registrado más de un pago.
	
	select * from multas
	order by idmulta
	select * from MediosPago
	select * from pagos

--13 Listar todos los datos de todos los agentes que hayan registrado multas con un
--monto que en promedio supere los $10000
	
	select ag.idAgente from multas ag

			

--14 Listar el tipo de infracción que más cantidad de multas haya registrado.
--15 Listar por cada patente, la cantidad de infracciones distintas que se cometieron.
--16 Listar por cada patente, el texto literal 'Multas pagadas' y el monto total de los pagos
--registrados por esa patente. Además, por cada patente, el texto literal 'Multas por
--pagar' y el monto total de lo que se adeuda.
--17 Listado con los nombres de los medios de pagos que se hayan utilizado más de 3
--veces.
--18 Los legajos, apellidos y nombres de los agentes que hayan labrado más de 2 multas
--con tipos de infracciones distintas.
--19 El total recaudado en concepto de pagos discriminado por nombre de medio de
--pago.
--20 Un listado con el siguiente formato:
--Descripción Tipo Recaudado
-------------------------------------------------
--Tigre Localidad $xxxx
--San Fernando Localidad $xxxx
--Rosario Localidad $xxxx
--Buenos Aires Provincia $xxxx
--Santa Fe Provincia $xxxx
--Argentina País $xxxx