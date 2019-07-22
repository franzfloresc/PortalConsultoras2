USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaUpd]') AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaUpd]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaUpd]
	@IdContenidoDeta int,
	@IdContenido int,
	@respuesta int output
AS
BEGIN
	Declare @Orden AS int;
	SET @respuesta = 0

	if @IdContenidoDeta > 0 and @IdContenido > 0
	begin
		--Actualizo Estado 
		UPDATE dbo.ContenidoAppDeta
				SET 
				Estado = 0
				WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;

			SET @Orden = (select top 1  Orden
			from  dbo.ContenidoAppDeta p
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

