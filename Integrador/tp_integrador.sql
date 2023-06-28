select * from votaciones
select * from concursos

--Resolver:
--1) Hacer un procedimiento almacenado llamado SP_Ranking que a partir de un
--IDParticipante se pueda obtener las tres mejores fotografías publicadas (si las hay).
--Indicando el nombre del concurso, apellido y nombres del participante, el título de la
--publicación, la fecha de publicación y el puntaje promedio obtenido por esa
--publicación.

SELECT * FROM FOTOGRAFIAS



SELECT P.NOMBRES, P.APELLIDOS, F.TITULO, V.PUNTAJE, C.TITULO NOMBRECONCURSO FROM FOTOGRAFIAS F
INNER JOIN VOTACIONES V ON V.IDFotografia = F.ID
INNER JOIN Participantes P ON P.ID = F.IDParticipante
INNER JOIN CONCURSOS C ON C.ID = F.IDConcurso

exec sp_ranking 2

Exec SP_Ranking2 2

	alter procedure SP_RANKING (
		 @IDPARTICIPANTE INT )
		AS
		BEGIN

	select top 3 c.titulo nombreConcurso, p.apellidos APELLIDO, p.nombres NOMBRE,  f.titulo TITULO, f.Publicacion, avg(v.puntaje) prome
	FROM concursos c 
	inner join fotografias f on f.IDConcurso = c.ID
	inner join votaciones v on v.IDFotografia  = f.ID
	inner join Participantes p on p.ID = f.IDParticipante
	where IDParticipante = @IDPARTICIPANTE
	group by c.titulo , p.apellidos , p.nombres,  f.titulo, f.Publicacion
	order by prome desc
--	order by avg(v.puntaje) desc

		END


		create Procedure SP_Ranking2(
    @IDParticipante bigint
)
As
Begin
    Select Top 3 With Ties C.Titulo As Concurso, P.Apellidos, P.Nombres, F.Titulo, F.Publicacion, AVG(V.Puntaje) as PProm
    From Concursos C
    Inner Join Fotografias F ON C.ID = F.IDConcurso
    Inner Join Participantes P ON P.ID = F.IDParticipante
    Inner Join Votaciones V ON F.ID = V.IDFotografia
    Where P.ID = @IDParticipante
    Group By C.Titulo, P.Apellidos, P.Nombres, F.Titulo, F.Publicacion
    Order by PProm Desc
End

	

--2) Hacer un procedimiento almacenado llamado SP_Descalificar que reciba un ID de
--fotografía y realice la descalificación de la misma. También debe eliminar todas las
--votaciones registradas a la fotografía en cuestión. Sólo se puede descalificar una
--fotografía si pertenece a un concurso no finalizado.
--(20 puntos)
 use AgenciaTransito
 drop database ExamenIntegrador

 select * from fotografias
 select * from votaciones
 select  * from concursos


	exec SP_descalificar 3
	exec SP_Descalificar2 1
	select * from 
	create procedure SP_descalificar
	(
	 @idfotografia int )
	 as 
	 begin

		declare @noFinalizo int
	

		


		select @noFinalizo = count(*) from Concursos c
		inner join fotografias f on f.IDConcurso =  c.id
		where @idfotografia = f.ID  and convert(date, getdate()) <= c.Fin


		if  @noFinalizo = 1 
		begin
			begin try
					begin transaction
						
						update fotografias set descalificada = 1
						where id = @idfotografia
						
						delete from votaciones where idfotografia = @idfotografia

						print @nofinalizo

					commit transaction
			end try


			begin catch
					rollback transaction
					raiserror('error de sistema', 16,1)


			end catch

		end
		else begin
			raiserror( 'el torneo no ha finalizado', 16, 1)

		end

		print 'contador de transacciones'
		print @@trancount
	

		
	 end

	
	update concursos set fin = cast (
	where id = 1

	use master
	drop database examenintegrador
















--3) Al insertar una fotografía verificar que el usuario creador de la fotografía tenga el
--ranking suficiente para participar en el concurso. También se debe verificar que el
--concurso haya iniciado y no finalizado. Si ocurriese un error, mostrarlo con un
--mensaje aclaratorio. De lo contrario, insertar el registro teniendo en cuenta que la
--fecha de publicación es la fecha y hora del sistema.
--(30 puntos)



	go
	alter trigger tr_verificar on fotografias
	instead of insert 
	as
	begin 
			
			declare @idparticipante int
			declare @idconcurso int
			declare @concursovigente int
			declare @rankingParticipante decimal (5,2)
			declare @rankingMinimo decimal (5,2)


			select @idconcurso = idconcurso, @idparticipante = idparticipante from inserted

			
			select @concursovigente = count(*) from concursos c
			where @idconcurso = c.ID and getdate() between c.Inicio and c.Fin

			select @rankingMinimo = c.rankingminimo from concursos c
			where @idconcurso = c.ID

			select @rankingParticipante = isnull(avg(v.puntaje), 0) from votaciones v
			inner join fotografias f on f.ID = V.IDFotografia
			where f.IDParticipante = @idparticipante


			if @concursovigente = 0
			begin
				raiserror( 'concurso finalizado', 16 , 1)
				return 

			end
			
			if @rankingParticipante < @rankingMinimo
			begin
					raiserror( 'ranking insuficiente' , 16, 1)
					return 
			end
			
			
			insert into fotografias 
			select idparticipante, idconcurso, titulo, 0, getdate() from inserted
					



	end
	go	


	select * from Concursos
	set dateformat dmy
	update concursos set fin = cast ('29-06-2023' as datetime)
	where id = 1
	select * from Fotografias



insert into Fotografias(IDParticipante, IDConcurso, Titulo, Descalificada, Publicacion)
Values(1, 2, 'No deberia guardarlo', 0, getdate())

insert into Fotografias(IDParticipante, IDConcurso, Titulo, Descalificada, Publicacion)
Values(1, 1, 'No le da el ranking', 0, getdate())

 select IDParticipante, Isnull(AVG(v.Puntaje),0)  
 FROM Votaciones v JOIN Fotografias f on v.IDFotografia = f.ID 
  group by IDParticipante

  update concursos set rankingminimo = 9  where id = 1


--4) Al insertar una votación, verificar que el usuario que vota no lo haga más de una vez
--para el mismo concurso ni se pueda votar a sí mismo. Tampoco puede votar una
--fotografía descalificada. Si ninguna validación lo impide insertar el registro de lo
--contrario, informarlo con un mensaje de error.
--(20 puntos)
	
	select * from Votaciones
	select * from Fotografias
Insert into Votaciones(IDVotante, IDFotografia, Fecha, Puntaje)
Values (1, 2, getdate(), 10)

Insert into Votaciones(IDVotante, IDFotografia, Fecha, Puntaje)
Values (1, 6, getdate(), 10)


	alter trigger tr_votacion on votaciones 
	after insert 
	as 
	begin
		
		declare @cantvotos int
		declare @idvotante int
		declare @idfotografia int
		
		select @idvotante = idvotante, @idfotografia = idfotografia from inserted
		
		select @cantvotos = COUNT(*) from Votaciones v
		where @idvotante = IDVotante


		begin try 
			begin transaction
		if @cantvotos > 1 
		begin
			raiserror('son muchos votos', 16,1)
	
		end

		if   (select COUNT(*) from votaciones v inner join Fotografias f on
		f.ID = v.IDFotografia
		where @idvotante = v.IDVotante
		) > 0
		begin
			raiserror('no se puede votar a uno mismo', 16,1)
		
		end


			commit transaction
		end try 
		begin catch
			
			rollback transaction
			raiserror('no te pases de listo', 16,1)
		end catch
			
		

	end
	Insert into Votaciones(IDVotante, IDFotografia, Fecha, Puntaje)
Values (1, 1, getdate(), 10)






--5) Hacer un listado en el que se obtenga: ID de participante, apellidos y nombres de los
--participantes que hayan registrado al menos dos fotografías descalificadas.
--(10 puntos)



SELECT p.id, p.apellidos, p.nombres from Participantes p
where (select COUNT(*) from Fotografias f where f.IDParticipante = p.ID and Descalificada <>0) >1



select p.id, p.apellidos, p.nombres, COUNT(*) descalificadas from Fotografias f
inner join Participantes p on p.ID = f.IDParticipante
where f.Descalificada = 1
group by p.ID,p.Apellidos, p.nombres
having COUNT(*)  > 2

select * from Fotografias

update Fotografias set Descalificada = 1 
where ID = 10002