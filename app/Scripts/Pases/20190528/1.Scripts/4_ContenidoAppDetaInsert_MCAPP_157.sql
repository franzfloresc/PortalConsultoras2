USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaInsert]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@Campania int,
	@Accion varchar(20),
	@CodigoDetalle varchar(150),
	@tipo varchar(20)
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Orden AS int;
Declare @numReg AS int;
	
	IF @Proc = 1
		BEGIN
		
			SET @OrdenActual = (select top 1 orden from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido Order by p.Orden desc);
			SET @numReg = (SELECT top 1 P.CantidadContenido FROM dbo.ContenidoApp P with(nolock) WHERE P.IdContenido = 3);

			if @OrdenActual is Null
				BEGIN
				--print '@OrdenActual Nulo';
					set @Orden = 1;
				END
			else
				BEGIN
					if (@OrdenActual = @numReg)
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

			INSERT INTO dbo.ContenidoAppDeta (IdContenido, CodigoDetalle, Descripcion, RutaContenido, Accion, Orden, Estado, Tipo, Campania)
			VALUES (@IdContenido, @CodigoDetalle,'', @RutaContenido, @Accion, @Orden, 1, @Tipo, @Campania);
		END
	ELSE IF @Proc = 2
		BEGIN
		UPDATE dbo.ContenidoAppDeta
				SET 
				CodigoDetalle = @CodigoDetalle,
				Accion = @Accion,
				Campania = @Campania
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;		
		END
			
END

GO

