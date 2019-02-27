USE BelcorpPeru
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpMexico
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpColombia
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpSalvador
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpPuertoRico
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpPanama
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpGuatemala
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpEcuador
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpDominicana
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpCostaRica
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpChile
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

USE BelcorpBolivia
GO

if exists(select 1 from sys.objects where type = 'P' and name = 'InsUsuarioOpciones')
begin
	drop procedure InsUsuarioOpciones
end
go
Create Proc InsUsuarioOpciones 
(
@CodigoUsuario varchar(20),
@OpcionesUsuarioId tinyint,
@Activo bit 
)
As
Begin
	if exists(select 1 from UsuarioOpciones where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId)
	begin
		update UsuarioOpciones set Activo = @Activo, FechaModificacion = GetDate() 
		where CodigoUsuario = @CodigoUsuario and OpcionesUsuarioId = @OpcionesUsuarioId
	end
	else
	begin
		insert UsuarioOpciones values (@CodigoUsuario, @OpcionesUsuarioId, @Activo, GetDate())
	end	
End
GO

