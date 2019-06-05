USE [BelcorpPeru_MC]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ContenidoAppDetaVideo]
	@Proc int,
	@IdContenidoDeta int,
	@IdContenido int,
	@RutaContenido varchar(250),
	@tipo varchar(20),
	@Campania int,
	@respuesta int output
AS
BEGIN

Declare @OrdenActual AS int = 0;
Declare @Estado AS int = 1;
Declare @Orden AS int;
Declare @CantContenido AS int;
Declare @numReg AS int;
Declare @numCampania AS int;
SET @respuesta = 0;	
	IF @Proc = 1
		BEGIN
			SET @OrdenActual = (select top 1 p.orden  from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and p.IdContenido = @IdContenido Order by p.Orden desc);
			SET @CantContenido = (SELECT top 1 p.CantidadContenido FROM dbo.ContenidoApp p with(nolock) WHERE p.IdContenido = @IdContenido);
			SET @numReg = (select COUNT(*) from  dbo.ContenidoAppDeta p with(nolock) WHERE p.Estado = 1 and IdContenido = @IdContenido and Campania = @Campania);
	
			if @OrdenActual is Null
					set @Orden = 1;
			else
					set @Orden  = @OrdenActual + 1;
		
			if @CantContenido >= @numReg
				if @CantContenido != @numReg
				BEGIN		
					--print 'Se inserto campania';	
					INSERT INTO dbo.ContenidoAppDeta (IdContenido, RutaContenido, Orden, Estado, Tipo, Campania)
					VALUES (@IdContenido, @RutaContenido, @Orden, @Estado, @Tipo, @Campania);
					SET @respuesta = 1;				
				END
				else
				BEGIN			
					--print 'Limite campanias son @CantContenido';	
					SET @respuesta = 2;						
				END
			else
			BEGIN
				 SET @respuesta = 3;			
				-- print 'Cantidad no puede ser menor que registros en el detalle';					
			END
		END
	ELSE IF @Proc = 2
		BEGIN
					UPDATE dbo.ContenidoAppDeta
					SET 
					Campania = @Campania,
					RutaContenido = @RutaContenido
					WHERE IdContenidoDeta = @IdContenidoDeta and IdContenido = @IdContenido;	
					SET @respuesta = 1;		
		END
	ELSE IF @Proc = 3
	BEGIN
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
	END
	
END