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


--6 Listado con el promedio de antig�edad de los agentes que se encuentren activos.
	select datediff(year,fechaingreso, getdate()) from agentes

	select avg (datediff(year,fechaingreso, getdate())*1.0) from agentes
	where activo = 1
	select * from Agentes

--7 Listado con el monto m�s elevado que se haya registrado en una multa.
	select max(monto) from multas
	select * from multas
	order by monto desc
	


--8 Listado con el importe de pago m�s peque�o que se haya registrado.
	select min(monto) from multas
--9 Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que
--registraron.
	select ag.legajo, ag.apellidos, ag.nombres,count (m.IdAgente) cantidad from  agentes ag
	inner join multas m on m.IdAgente = ag.IdAgente
	group by legajo, apellidos, nombres
	
	


--10 Por cada tipo de infracci�n, listar la descripci�n y el promedio de montos de las
--multas asociadas a dicho tipo de infracci�n.
select * from  multas
order by IdTipoInfraccion
	select ti.descripcion, avg(m.monto*1.0)  from TipoInfracciones ti
	inner join multas m on m.IdTipoInfraccion = ti.IdTipoInfraccion
	group by Descripcion
	

--11 Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de
--pagos realizados. Solamente mostrar la informaci�n de las multas que hayan sido
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


--12 Listar todos los datos de las multas que hayan registrado m�s de un pago.
	
	select * from multas
	order by idmulta
	select * from MediosPago
	select * from pagos

--13 Listar todos los datos de todos los agentes que hayan registrado multas con un
--monto que en promedio supere los $10000
	
	select ag.*,  from multas ag

	create view promediosXAgente
	as
	select m.idAgente, avg(m.monto) monti from multas m 
	group by m.IdAgente

	select * from promediosXAgente
	where monti > 15000
	order by idAgente desc

	having avg(m.monto) >17000

	create trigger 

--14 Listar el tipo de infracci�n que m�s cantidad de multas haya registrado.
	select m.idtipoinfraccion, count (*) from multas m
	group by IdTipoInfraccion




--15 Listar por cada patente, la cantidad de infracciones distintas que se cometieron.

	select m.patente, count(*) from multas m
	group by Patente

	select * from multas
	where patente like 'AB123CD'







--16 Listar por cada patente, el texto literal 'Multas pagadas' y el monto total de los pagos
--registrados por esa patente. Adem�s, por cada patente, el texto literal 'Multas por
--pagar' y el monto total de lo que se adeuda.

	SELECT M.PATENTE,
	'PAGADAS', 
	(SELECT ISNULL(SUM(MUL.MONTO),0)  FROM MULTAS MUL
	WHERE MUL.PAGADA <> 0 AND MUL.PATENTE = M.Patente
	) MULTASPAGADAS,
	'NO PAGADAS',(
	SELECT   isnull(SUM(MUL.MONTO), 0)FROM MULTAS MUL
	WHERE PAGADA = 0 AND MUL.Patente = M.Patente
	
	)  MULTASpORPAGAR

	FROM MULTAS M
	GROUP BY PATENTE
	UPGRADE 
		--use AgenciaTransito



--17 Listado con los nombres de los medios de pagos que se hayan utilizado m�s de 3
--veces.
	--select * from MediosPago
	--select * from pagos
	--SELECT * FROM Multas
	--
	SELECT MP.NOMBRE FROM MediosPago MP
	INNER JOIN PAGOS P ON P.IDMedioPago = MP.IDMedioPago
	WHERE P.IDMedioPago IN 
	(SELECT PA.IDMEDIOPAGO MP FROM PAGOS PA
    GROUP BY IDMedioPago
	HAVING COUNT(P.IDMedioPago) >3)


	SELECT P.IDMEDIOPAGO MP FROM PAGOS P

	SELECT MP.NOMBRE FROM MediosPago MP
	INNER JOIN PAGOS P ON P.IDMedioPago = MP.IDMedioPago
    GROUP BY P.IDMedioPago, MP.NOMBRE
	HAVING COUNT(P.IDMedioPago) >3


	--OBTENGO LOS ID DE LOS MP QUE SE USARON MAS DE 3 VECES
	SELECT P.IDMEDIOPAGO MP FROM PAGOS P
    GROUP BY IDMedioPago

	SELECT P.IDMEDIOPAGO MP FROM PAGOS P
    GROUP BY IDMedioPago
	HAVING COUNT(P.IDMedioPago) >3




--18 Los legajos, apellidos y nombres de los agentes que hayan labrado m�s de 2 multas
--con tipos de infracciones distintas.
select * from multas 
order by idAgente asc
 select * from agentes

 SELECT ag.idagente, AG.LEGAJO, AG.NOMBRES, AG.APELLIDOS WFROM AGENTES AG
 where (
 SELECT DISTINCT COUNT(t.IDTIPOINFRACcION) FROM TipoInfracciones t
 inner join multas m on m.IdTipoInfraccion = t.IdTipoInfraccion
 where m.IdAgente = ag.IdAgente
 ) >2

 SELECT * FROM TipoInfracciones 

--19 El total recaudado en concepto de pagos discriminado por nombre de medio de
--pago.

	 SELECT MP.NOMBRE, SUM(P.IMPORTE) FROM PAGOS P
	 INNER JOIN MediosPago MP ON MP.IDMedioPago = P.IDMedioPago
	 GROUP BY MP.NOMBRE ,P.IDMedioPago



--20 Un listado con el siguiente formato:



--Descripci�n Tipo Recaudado
-------------------------------------------------
--Tigre Localidad $xxxx
--San Fernando Localidad $xxxx
--Rosario Localidad $xxxx
--Buenos Aires Provincia $xxxx
--Santa Fe Provincia $xxxx
--Argentina Pa�s $xxxx


SELECT L.Localidad AS Descripci�n, 'Localidad' AS Tipo, SUM(P.Importe) AS Recaudado
FROM Localidades L
INNER JOIN Multas M ON M.IDLocalidad = L.IDLocalidad
INNER JOIN Pagos P ON P.IDMulta = M.IDMulta
GROUP BY L.Localidad
UNION
SELECT PR.Provincia AS Descripci�n, 'Provincia' AS Tipo, SUM(P.Importe) AS Recaudado
FROM Provincias PR
INNER JOIN Localidades L ON L.IDProvincia = PR.IDProvincia
INNER JOIN Multas M ON M.IDLocalidad = L.IDLocalidad
INNER JOIN Pagos P ON P.IDMulta = M.IDMulta
GROUP BY PR.Provincia
UNION
SELECT 'Argentina' AS Descripci�n, 'Pa�s' AS Tipo, SUM(P.Importe) AS Recaudado
FROM Pagos P


select l.localidad, 'Localidad', sum(m.monto) 
from localidades l
inner join Multas m on m.IDLocalidad = l.IDLocalidad
group by l.Localidad




SELECT * FROM LOCALIDADES
SELECT * FROM PAGOS
SELECT * FROM MULTAS