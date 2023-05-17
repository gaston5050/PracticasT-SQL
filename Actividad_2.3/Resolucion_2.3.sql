--# Consulta
--1 Listado con la cantidad de agentes
--	select * from agentes
--	select count(Legajo) from agentes
--2 Listado con importe de referencia promedio de los tipos de infracciones

--	select   idtipoinfraccion, avg(monto) from multas
--	group by IdTipoInfraccion
--	order by idTipoInfraccion asc


	
	


--3 Listado con la suma de los montos de las multas. Indistintamente de si fueron
--pagadas o no.

	select idtipoinfraccion, sum(monto) from multas
	group by IdTipoInfraccion


--4 Listado con la cantidad de pagos que se realizaron.
--5 Listado con la cantidad de multas realizadas en la provincia de Buenos Aires.
--NOTA: Utilizar el nombre 'Buenos Aires' de la provincia.
--6 Listado con el promedio de antigüedad de los agentes que se encuentren activos.
--7 Listado con el monto más elevado que se haya registrado en una multa.
--8 Listado con el importe de pago más pequeño que se haya registrado.
--9 Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que
--registraron.
--10 Por cada tipo de infracción, listar la descripción y el promedio de montos de las
--multas asociadas a dicho tipo de infracción.
--11 Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de
--pagos realizados. Solamente mostrar la información de las multas que hayan sido
--pagadas en su totalidad.
--12 Listar todos los datos de las multas que hayan registrado más de un pago.
--13 Listar todos los datos de todos los agentes que hayan registrado multas con un
--monto que en promedio supere los $10000
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