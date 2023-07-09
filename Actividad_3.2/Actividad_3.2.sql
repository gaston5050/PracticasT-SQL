--Actividad 3.2

--#
--Ejercicio
--1
--Hacer un trigger que al eliminar un Agente su estado Activo pase de True a False.
	select * from agentes
	delete from agentes 
	where idagente = 2
	drop trigger tr_eliminarAgente

	alter trigger tr_eliminarAgente on agentes
	instead of delete
	as 
	begin
		declare @idAgente int
		select @idAgente =  idAgente from deleted
		print @idagente
		update agentes set Activo = 0
		where IdAgente = @idAgente
	end















	SELECT * FROM AGENTES
	SELECT * FROM MULTAS
	delete from Agentes where 
	IdAgente = 11
	 drop trigger tr_eliminar_agente
	 create trigger tr_eliminar_agente on agentes
	 instead of delete
	 as 
	 begin
		update Agentes set Activo =0
		where IdAgente  = (select IdAgente from deleted)
	 end


	




--2
--Modificar el trigger anterior para que al eliminar un Agente y si su estado Activo ya 
--se encuentra
--previamente en False entonces realice las siguientes acciones:
--Cambiar todas las multas efectuadas por ese agente y establecer el valor 
--NULL al campo IDAgente.
--Eliminar físicamente al agente en cuestión.
--Utilizar una transacción


 alter trigger tr_eliminaragente
 on agentes
 instead of delete
 as
 begin
	
		declare @idAgente int
		declare @activo bit 
			
		select @idAgente = idagente from deleted
		select @activo = activo from deleted

		begin try
			begin transaction
				if @activo = 0 begin

					update multas set IdAgente = null
					where IdAgente = @idAgente
					
					delete from agentes where IdAgente = @idAgente

				  	commit transaction
				end
				else begin
					update agentes set activo = 0
					where IdAgente = @idAgente
				end





		end try
		begin catch

			rollback transaction
		end catch


 end


 SELECT * FROM MULTAS














select * from agentes

alter trigger tr_eliminar_agente on agentes
	 instead of delete
	 as 
	 begin
	 if(select activo from deleted ) = 0 begin 
		begin try
				begin transaction 
				update multas set IdAgente = NULL
				where  IdAgente = (select IdAgente from deleted)

				delete from Agentes  where
				IdAgente = (select IdAgente from deleted)
				
			commit transaction

		end try

			begin catch
				rollback transaction 
				raiserror('no funciono' , 16, 1)

			end catch
			end
		 else begin 
		update Agentes set Activo = 0
		where IdAgente  = (select IdAgente from deleted)
	 end
	 end





	 select * from agentes

	 select * from multas
	 where IdAgente = 1
		--update Agentes set Activo =0
		--where IdAgente  = (select IdAgente from deleted)
	 end

	delete from Agentes where IdAgente = 5

	SELECT * FROM MULTAS WHERE IdAgente = 5



--3
--Hacer un trigger que al insertar una multa realice las siguientes acciones:
--No permitir su ingreso si el Agente asociado a la multa no se encuentra Activo. 
--Indicarlo con un mensaje claro que sea considerado una excepción.
--Establecer el Monto de la multa a partir del tipo de infracción.
--Aplicar un recargo del 20% al monto de la multa si no es la primera multa del vehículo en el año.
--Aplicar un recargo del 25% al monto de la multa si no es la primera multa del mismo tipo de infracción del vehículo en el año.
--Establecer el estado Pagada como False.


		create trigger tr_insertarMulta on multas
		instead of insert
		as
		begin

			begin try
				if 
			end try
			begin catch
			end catch

		end


		
--		Case 
--    When Email Is null And Celular is null and Telefono is null then 'Incontactable'
--    When Email Is null And Celular is null then Telefono
--    When Email Is null Then Celular
--    Else Email
--End As DatosContacto

		select * from  multas
		where  Patente like 'zab234'
		order by IdMulta desc
		select * from agentes

		select * from TipoInfracciones

		insert into multas (idtipoinfraccion, idlocalidad, idagente, patente, FechaHora, monto,PAGADA)
		values( 4,  12,4, 'ZAB234',GETDATE(), 11, 0)

		--exec sp_agregarmulta 4, 12,3, 'ZAB234', 666


	 ALTER trigger tr_inserta_multa on multas
	 AFTER insert
	 as 
	 begin


					declare @monto money
					declare @idtipoInfra int
					declare @idmulta int
					declare @patente varchar(10)
					declare @fecha int
					declare @idagente int


					select @idagente = idagente from inserted
					print 'nada'
		print @idagente
					Select @idtipoInfra = idtipoinfraccion from inserted
					select @idmulta = idmulta from inserted
					select @patente = patente from inserted
					select @fecha =  year (fechahora) from inserted 


					set @monto = (select ti.importeReferencia from TipoInfracciones ti
					where  ti.IdTipoInfraccion = @idtipoInfra)

		declare @activo  bit
		select @activo = ag.activo from Agentes ag
		
		where ag.IdAgente = @idagente

		print 'nada'
		print @idagente
		print @activo
		print 'nada'


		
		if  @activo = 1 begin	

			begin try 

					begin transaction

					if  (select count(*) from multas where idmulta <>  @idmulta and Patente like @patente  and year(fechahora) = @fecha ) > 1

					begin
					set @monto = @monto * 1.2

					end

					if  (select count(*) from multas where idmulta <>  @idmulta and Patente like @patente  and year(fechahora) = @fecha  and idtipoinfraccion = @idtipoInfra) >1

					begin
					set @monto = @monto * 1.25

					end
					update multas set monto = @monto where IdMulta = @idmulta
					update multas set pagada = 0 where IdMulta = @idmulta






				

					 

										
					commit transaction					
				
			end try

			begin catch

				--declare @mensajeError varchar(250)
				--set @mensajeError = ERROR_MESSAGE
				rollback transaction
				--RAISERROR(@mensajeError, 16, 1)
				RAISERROR('Ocurrio un error', 16, 1)


			end catch
	    end
		
		else begin 

			
			rollback transaction 

			RAISERROR('Agente invalido', 16, 1)
			    
		end



	 end





--Poner mensajes como si fueran excepciones

		--declare @mensajin varchar(50)
		--set @meNsajin = ' mensaje peligroso'
		--raiserror(@mensajin, 16, 1)









--4
--Hacer un trigger que al insertar un pago realice las siguientes verificaciones:
--Verificar que la multa que se intenta pagar se encuentra no pagada.
--Verificar que el Importe del pago sumado a los importes anteriores de la misma multa no superen el Monto a abonar.

select * from Multas where idmulta =8
select * from pagos where idmulta = 8

 insert into pagos (IDMulta, Importe,Fecha,IDMedioPago) 
 values (8,32500, getdate(), 2)

 select * from pagos

	alter trigger tr_pago on pagos
	after insert
	as 
	begin
		declare @idmulta int

		select @idmulta = idmulta from inserted

		if((select m.Pagada from multas m where m.IdMulta = @idmulta) = 0 ) 
		and 
		(select monto from multas where idmulta = @idmulta) >= (select sum (importe) from pagos where  IDMulta = @idmulta)
		begin 
			
		begin try
			 begin transaction
				if(select monto from multas where idmulta = @idmulta) = (select sum (importe) from pagos where  IDMulta = @idmulta)
				begin
				 update Multas set pagada = 1  where IdMulta = @idmulta
				 end

			 commit transaction



		end try

		begin catch
			rollback transaction

		end catch
		end
		
		else begin 
			rollback transaction

			raiserror('surgio un error', 16,1)
		end


			



	end

go
--En ambos casos impedir el ingreso y mostrar un mensaje acorde.

--Si el pago cubre el Monto de la multa ya sea con un pago único o siendo la suma de pagos anteriores sobre la misma multa. Además de registrar el pago se debe modificar el estado Pagada de la multa relacionada.

--comment
--CTRL + K, CTRL + C. 
--uncomment 
--CTRL + K, CTRL + U
