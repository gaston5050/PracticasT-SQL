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




	alter procedure SP_descalificar (
	 @idfotografia int )




	as begin
		begin try
	
			declare @vigencia int
			declare @idfotografia int 
			set @idfotografia = 2

			select @vigencia = count(*) from concursos c
			inner join Fotografias f on f.IDConcurso = c.ID
			where @idfotografia = f.ID and c.Fin > getdate()

			print @vigencia 
		
		
			begin transaction 

	
				begin

					update fotografias set Descalificada = 1
					where id= @idfotografia

					delete from votaciones where IDFotografia = @idfotografia

					commit transaction

			
				end
				else begin
			print 'llega'
			raiserror( 'no sirve', 16,1)
			end

					
				
				end try
		begin catch
			if @@TRANCOUNT > 0
			begin
			rollback transaction
			--raiserror( 'NO SE PUEDE BORRAR ESTA FOTOGRAFIA', 16, 1)
			end
			print error_message()






		end catch
		

	end

	select *  from fotografias f  (cast(gETDATE() as date))  <= (select c.fin from concursos c
					inner join fotografias f on f.idconcurso = c.id)


					select * from Fotografias
	exec SP_descalificar 11
--3) Al insertar una fotografía verificar que el usuario creador de la fotografía tenga el
--ranking suficiente para participar en el concurso. También se debe verificar que el
--concurso haya iniciado y no finalizado. Si ocurriese un error, mostrarlo con un
--mensaje aclaratorio. De lo contrario, insertar el registro teniendo en cuenta que la
--fecha de publicación es la fecha y hora del sistema.
--(30 puntos)
--4) Al insertar una votación, verificar que el usuario que vota no lo haga más de una vez
--para el mismo concurso ni se pueda votar a sí mismo. Tampoco puede votar una
--fotografía descalificada. Si ninguna validación lo impide insertar el registro de lo
--contrario, informarlo con un mensaje de error.
--(20 puntos)
--5) Hacer un listado en el que se obtenga: ID de participante, apellidos y nombres de los
--participantes que hayan registrado al menos dos fotografías descalificadas.
--(10 puntos)