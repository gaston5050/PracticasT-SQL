--use agenciaTransito

--Actividad 2.4
--# Consulta
--1 La patente, apellidos y nombres del agente que labró la multa y monto de aquellas
--multas que superan el monto promedio.
	go
	select avg(m.monto) from multas m
	select *  from multas
	select m.patente, ag.apellidos, ag.nombres, m.monto, (select avg(m.monto) from multas m) prome from agentes ag
	inner join multas m on m.IdAgente = ag.IdAgente
	WHERE m.Monto > (select avg(m.monto) from multas m)
	group by patente, Apellidos, Nombres, monto
--2 Las multas que sean más costosas que la multa más costosa por 'No respetar señal
--de stop'.

go
			select m.* from multas m 
			where m.monto > (select max(mul.monto )  from multas mul
			inner join TipoInfracciones ti on ti.IdTipoInfraccion = mul.IdTipoInfraccion
			where ti.Descripcion like 'No respetar señal de stop')

		
			select * from multas m 
			where IdTipoInfraccion = 4
			order by monto desc

			select top 1 monto from multas
			where IdTipoInfraccion = 4
			order by monto desc

			SELECT MAX(MONTO) FROM MULTAS
			WHERE IdTipoInfraccion = 4

			select * from TipoInfracciones




--3 Los apellidos y nombres de los agentes que no hayan labrado multas en los dos
--primeros meses de 2023.
use AgenciaTransito
go
	select ag.apellidos, ag.nombres, ag.IdAgente from  agentes ag
	where ag.IdAgente not in
	(select idAgente from multas where month(fechahora) = 2 or month(fechahora) = 1 and year(fechahora) =2023)
	group by  ag.nombres, ag.apellidos, ag.IdAgente

	select * from multas 
	order by fechahora desc

	select * from multas 
	order by IdAgente

	go

--4 Los apellidos y nombres de los agentes que no hayan labrado multas por 'Exceso de
--velocidad'.

	select ag.IdAgente,ag.apellidos, ag.nombres from agentes ag
	where ag.IdAgente not in 
	(select m.idagente from multas m
	 inner join TipoInfracciones tp on tp.IdTipoInfraccion = m.IdTipoInfraccion
	 where tp.Descripcion like 'Exceso de velocidad')



--5 Los legajos, apellidos y nombre de los agentes que hayan labrado multas de todos
--los tipos de infracciones existentes.
	select ag.legajo, ag.apellidos, ag.nombres  from agentes ag
	where (
			select count(distinct ti.idtipoinfraccion) from TipoInfracciones ti
			inner join multas m on ti.IdTipoInfraccion = m.IdTipoInfraccion
			where ag.IdAgente = m.IdAgente) = 10
	 
	 
		select count(distinct ti.idtipoinfraccion) from TipoInfracciones ti
			inner join multas m on ti.IdTipoInfraccion = m.IdTipoInfraccion
			where m.IdAgente = 2


	select *  from multas
	where IdAgente = 2



		select legajo from agentes
		inner join agentes ag on ag.IdAgente = multas.IdAgente
		order by ag.IdAgente


--6 Los legajos, apellidos y nombres de los agentes que hayan labrado más cantidad de
--multas que la cantidad de multas generadas por un radar (multas con IDAgente con
--valor NULL)
go
	select ag.legajo,ag.IdAgente, ag.apellidos, ag.nombres from agentes ag
	where (select count(*) from multas m
	where m.IdAgente = ag.idagente)> (
		select count(*) from multas 
		where	IdAgente  is null)
	
	select count(*) from agentes ag
	inner join  multas m on ag.IdAgente = m.IdAgente
	group by ag.IdAgente

go

		select * from multas 
		order by idagente asc
		where	IdAgente  is null
		select * from multas
		alter 

--7 Por cada agente, listar legajo, apellidos, nombres, cantidad de multas realizadas
--durante el día y cantidad de multas realizadas durante la noche.
--NOTA: El turno noche ocurre pasadas las 20:00 y antes de las 05:00.
go
	select isnull(ag.legajo, 0), ag.apellidos, ag.nombres, ag.idagente,
	(select count(*) from multas
	where multas.IdAgente =ag.idagente 
	and 
	(datepart(hour,fechahora) > 20 or datepart(Hour,FechaHora) <5)
	
	
	) multasRealilzadas from agentes ag

	select count(*) from multas where 


	select m.*, datepart(hour, m.fechahora) horita from multas m
	order by m.IdAgente desc

	go
--8 Por cada patente, el total acumulado de pagos realizados con medios de pago no
--electrónicos y el total acumulado de pagos realizados con algún medio de pago
--electrónicos.
--9 La cantidad de agentes que hicieron igual cantidad de multas por la noche que
--durante el día.
--10 Las patentes que, en total, hayan abonado más en concepto de pagos con medios
--no electrónicos que pagos con medios electrónicos. Pero debe haber abonado tanto
--con medios de pago electrónicos como con medios de pago no electrónicos.
--11 Los legajos, apellidos y nombres de agentes que hicieron más de dos multas
--durante el día y ninguna multa durante la noche.
--12 La cantidad de agentes que hayan registrado más multas que la cantidad de multas
--generadas por un radar (multas con IDAgente con valor NULL)