USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
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
			set @Orden = 1;
		END
	else
		BEGIN
			if (@OrdenActual = 20)
				BEGIN
				--ACTUALIZO ESTADO CUANDO HAY 20 REGISTROS
				UPDATE dbo.ContenidoAppDeta SET Estado = 0 WHERE Orden = 1 and IdContenido = @IdContenido;
				--ACTUALIAZO ORDEN
				UPDATE dbo.ContenidoAppDeta SET Orden = Orden - 1 WHERE Estado = 1 and IdContenido = @IdContenido;
				--CONTADOR
				set @Orden  = @OrdenActual;
				END
			else
				BEGIN
				set @Orden  = @OrdenActual + 1;
				END
		END

	INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Tipo, Estado)
	VALUES (@idContenido,'','', @RutaContenido, '', @Orden, @Tipo , 1);
	
END

GO