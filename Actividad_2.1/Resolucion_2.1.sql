--use AgenciaTransito
--select * from localidades
--select * from agentes
--select * from multas
--select *  from tipoInfracciones


--#
--Consulta
--1
--Apellido, nombres y fecha de ingreso de todos los agentes

--select ag.legajo, ag.apellidos, ag.nombres, ag.fechaIngreso from agentes ag
--order by legajo asc
--2
--Apellido, nombres y antigüedad de todos los agentes
--select ag.apellidos, ag.nombres, datediff(year,ag.fechaIngreso, getdate()) antiguedad from agentes ag
--3
--Apellido y nombres de aquellos colaboradores que no estén activos.
--select ag.Apellidos APELLIDOS, AG.NOMBRES NOMBRES  from agentes ag
--WHERE AG.Activo = 0;
--4
--Apellido y nombres y antigüedad de aquellos colaboradores cuyo sueldo sea entre 50000 y 100000.
--select ag.apellidos, ag.nombres.  datediff(year,ag.fechaIngreso, getdate()) antiguedad, ag.sueldo from agentes ag
--where ag.sue
--5
--Apellidos y nombres y edad de los colaboradores con legajos A001, A005 y A015
--select ag.apellidos, ag.nombres, datediff(YEAR,ag.fechaNacimiento, getdate()) edad from agentes ag
--where  LEGAJO LIKE 'A001' OR LEGAJO LIKE 'A005' OR LEGAJO LIKE 'A015'

--6
--Todos los datos de todas las multas ordenadas por monto de forma descendente.
--SELECT * FROM Multas 
--ORDER BY MONTO DESC
--7
--Todos los datos de las multas realizadas en el mes 02 de 2023.
--	SELECT * FROM MULTAS
--	WHERE  MONTH(FechaHora) =2 and year(fechahora) = 2023

--8
--Todos los datos de todas las multas que hayan superado el monto de $20000.
--	select * from multas
--	where monto > 20000

--9
--Apellido y nombres de los agentes que no hayan registrado teléfono.
	--select ag.nombres, ag.apellidos, ag.Telefono from agentes ag
	--where Telefono is null
--10
--Apellido y nombres de los agentes que hayan registrado mail pero no teléfono.
	--select ag.Apellidos, ag.nombres, ag.email mail , ag. telefono from agentes ag 
	--where email is not null and telefono is null
	
--11
--Apellidos, nombres y datos de contacto de todos los agentes.
--select ag.apellidos, ag.nombres, ag.email, ag.telefono, ag.celular,
--concat(ag.email ,'    ' ,ag.Telefono ,'    ',ag.celular) contacto
--from agentes ag
 
--Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el número de teléfono fijo y si no tiene este último el mail. En caso de no tener ninguno de los tres debe figurar 'Incontactable'.
	
--12
--Apellidos, nombres y medio de contacto de todos los agentes. Si tiene celular debe figurar 'Celular'. Si no tiene celular pero tiene teléfono
--fijo debe figurar 'Teléfono fijo' de lo contrario y si tiene Mail debe figurar 'Email'. Si no posee ninguno de los tres debe figurar NULL.
	
	--select ag.apellidos, ag.nombres,
	--case
	--when ag.celular is not null then 'celular'
	--when ag.telefono is not null then 'telefono fijo'
	--when ag.email is not null then'email'
	--else 'null'
	--
	--end contacto
	--
	--
	--from agentes ag


--13
--Todos los datos de los agentes que hayan nacido luego del año 2000
	--select * from agentes
	--order by FechaNacimiento desc
	--where year(FechaNacimiento) <2000




--14
--Todos los datos de los agentes que hayan nacido entre los meses de Enero y Julio (inclusive)
	--SELECT * FROM AGENTES	
	--WHERE MONTH(FechaNacimiento) >=1 AND MONTH (FECHANACIMIENTO) <=7

--15
--Todos los datos de los agentes cuyo apellido finalice con vocal
	--SELECT AG.* FROM AGENTES AG
	--WHERE AG.APELLIDOS LIKE '%[AEIOU]'
--16
--Todos los datos de los agentes cuyo nombre comience con 'A' y contenga al menos otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc
--	SELECT AG.* FROM AGENTES AG
--	WHERE NOMBRES LIKE 'V%A%'

--17
--Todos los agentes que tengan más de 10 años de antigüedad.
	--select ag.* from agentes ag
	--where datediff(year, ag.fechaIngreso, getdate()) >10

--18
--Las patentes, sin repetir, que hayan registrado multas
	--select distinct m.patente from multas m



--19
--Todos los datos de todas las multas labradas en el mes de marzo de 2023 con un recargo del 25% en una columna llamada NuevoImporte.
	--SELECT M.*, 
	--(M.MONTO * 1.25) NUEVOMONTO 	
	--FROM MULTAS M
	--WHERE YEAR(M.FECHAHORA) = 2023 AND MONTH(M.FECHAHORA) = 3

--20
--Todos los datos de todos los colaboradores ordenados por apellido ascendentemente en primera instancia y por nombre descendentemente en segunda instancia.

	--SELECT AG.* FROM AGENTES AG
	--ORDER BY NOMBRES ASC , APELLIDOS DESC

