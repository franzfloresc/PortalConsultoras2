USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaUpd]
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
			from  dbo.ContenidoAppDeta p with(nolock)
				WHERE p.IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido);

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

GO