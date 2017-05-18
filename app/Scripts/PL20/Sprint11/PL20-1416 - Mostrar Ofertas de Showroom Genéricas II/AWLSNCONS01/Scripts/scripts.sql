USE BelcorpBolivia
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpChile
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpColombia
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpCostaRica
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpDominicana
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpEcuador
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpGuatemala
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpMexico
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpPanama
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpPeru
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpPuertoRico
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpSalvador
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go

USE BelcorpVenezuela
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'EsGenerica') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD EsGenerica bit
go

update ShowRoom.EventoConsultora set EsGenerica = 0 where EsGenerica is null

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201707,'0013918'
ShowRoom.GetShowRoomConsultora 201707,'1626379'
*/
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica)
begin
	if not exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and isnull(EsGenerica,0) = 0)
	begin
		declare @EventoID int = 0
		declare @SegmentoGenerica varchar(50) = ''

		select top 1 @EventoID = EventoID, @SegmentoGenerica = Segmento from ShowRoom.EventoConsultora where CodigoConsultora = @ConsultoraGenerica
		order by FechaCreacion desc
		
		if @EventoID <> 0
		begin			
			DECLARE @FechaGeneral DATETIME        
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
			
			if exists (select 1 from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1)
			begin
				declare @SegmentoConsultora varchar(50) = ''

				select @SegmentoConsultora = Segmento from ShowRoom.EventoConsultora where 
					CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 1

				if @SegmentoGenerica != @SegmentoConsultora
				begin
					update ShowRoom.EventoConsultora
					set 
						Segmento = @SegmentoGenerica,
						FechaModificacion = @FechaGeneral
					where 
						CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
				end
			end
			else
			begin
				insert into ShowRoom.EventoConsultora 
				(EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,FechaCreacion,UsuarioCreacion,
				FechaModificacion,UsuarioModificacion,MostrarPopupVenta,EsGenerica)
				values
				(@EventoID,@CampaniaID,@CodigoConsultora,@SegmentoGenerica,1,@FechaGeneral,'ADMCONTENIDO',
				@FechaGeneral,'ADMCONTENIDO',1,1)
			end			
		end		
	end

	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	order by FechaCreacion desc
end
else
begin
	select top 1
		EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso
	from ShowRoom.EventoConsultora
	where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora and EsGenerica = 0
	order by FechaCreacion desc
end

end

go
