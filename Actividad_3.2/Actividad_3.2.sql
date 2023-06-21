--Actividad 3.2

--#
--Ejercicio
--1
--Hacer un trigger que al eliminar un Agente su estado Activo pase de True a False.
	SELECT * FROM AGENTES
	delete from Agentes where 
	IdAgente = 3
	 
	 create trigger tr_eliminar_agente on agentes
	 instead of delete
	 as 
	 begin
		update Agentes set Activo =0
		where IdAgente  = (select IdAgente from deleted)
	 end


	




--2
--Modificar el trigger anterior para que al eliminar un Agente y si su estado Activo ya se encuentra
--previamente en False entonces realice las siguientes acciones:
--Cambiar todas las multas efectuadas por ese agente y establecer el valor NULL al campo IDAgente.
--Eliminar físicamente al agente en cuestión.

--Utilizar una transacción
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
		
--		Case 
--    When Email Is null And Celular is null and Telefono is null then 'Incontactable'
--    When Email Is null And Celular is null then Telefono
--    When Email Is null Then Celular
--    Else Email
--End As DatosContacto

		select * from  multas
		select * from agentes

		insert into multas (idtipoinfraccion, idlocalidad, idagente, patente, FechaHora, monto,PAGADA)
		values( 4,  12,2, 'ZAB234',GETDATE(), 999, 0)

		exec sp_agregarmulta 4, 12,3, 'ZAB234', 666


	 ALTER trigger tr_inserta_multa on multas
	 AFTER insert
	 as 
	 begin
		
		if (select ag.activo from inserted ) = 1 begin	

			begin try 
					declare @monto money
					declare @idtipoInfra int
					declare @idmulta int
					declare @patente varchar(10)

					Select @idtipoInfra = idtipoinfraccion from inserted
					select @idmulta = idmulta from inserted
					select @patente = patente from inserted

					set @monto = (select ti.importeReferencia from TipoInfracciones ti
					where  ti.IdTipoInfraccion = @idtipoInfra)


					if  (select count(*) from multas where idmulta <>  @idmulta and Patente like @patente begin
					set @monto = @monto * 1.2
					end

					if year(fechahora) = year(getdate()) begin
					set @monto = @monto * 1.2
					end








				

					begin transaction
					 

										
					commit transaction					
				
			end try

			begin catch
				declare @mensajeError varchar(250)
				set @mensajeError = ERROR_MESSAGE
				rollback transaction
				RAISEERROR(@mensajeError, 16, 1)


			end catch
	    end
		
		else begin 

			
			rollback transaction 

			RAISEERROR('Agente invalido', 16, 1)

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

--En ambos casos impedir el ingreso y mostrar un mensaje acorde.

--Si el pago cubre el Monto de la multa ya sea con un pago único o siendo la suma de pagos anteriores sobre la misma multa. Además de registrar el pago se debe modificar el estado Pagada de la multa relacionada.

--comment
--CTRL + K, CTRL + C. 
--uncomment 
--CTRL + K, CTRL + U
