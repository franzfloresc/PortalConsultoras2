USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaInsert]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaInsert]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@idContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;

	SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);

	if @OrdenActual is Null
		BEGIN
		--print '@OrdenActual Nulo';
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--print '@OrdenActual Llego a 20';
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				--print '@OrdenActual menor que 20';
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

