USE BelcorpPeru
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpMexico
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpColombia
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpSalvador
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpPanama
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpEcuador
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpDominicana
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpChile
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

USE BelcorpBolivia
GO

IF EXISTS (
    SELECT * FROM sys.objects
    WHERE object_id =
    OBJECT_ID(N'[dbo].[GrabarDocumentoExcepcionBuro]')
    AND type in (N'P', N'PC')
)
    DROP PROCEDURE [dbo].[GrabarDocumentoExcepcionBuro]
GO

create  procedure dbo.GrabarDocumentoExcepcionBuro(
	@data varchar(30)
)
as
begin
	declare @id int
	declare @Numerodocumento varchar(30)
	declare @Usuario varchar(20)
	declare @pos1 int
	set @pos1 = CHARINDEX('|',@data)
	set @Numerodocumento = substring(@data,0 ,@pos1)
	set @Usuario = substring(@data,@pos1 +1 , Len(@data)-@pos1)

	if not exists( select * from dbo.DocumentoExcepcionBuro where NumeroDocumento = @Numerodocumento and activo=1 )
	begin
		select @id = isnull(max(DocumentoExcepionBuroID) ,0) from dbo.DocumentoExcepcionBuro 
		insert into dbo.DocumentoExcepcionBuro 
			( DocumentoExcepionBuroID, NumeroDocumento,TipoDocumento, Activo,UsuarioCreacion,FechaCreacion) 
		values
			(@id +1, @Numerodocumento,1,1,@Usuario,GETDATE())
	end
	else
	begin
		update dbo.DocumentoExcepcionBuro 
		set		Activo = 0,
				FechaEliminacion = GETDATE(),
				UsuarioEliminacion = @Usuario
		where NumeroDocumento = @Numerodocumento
	end
	select @id +1
end
GO

