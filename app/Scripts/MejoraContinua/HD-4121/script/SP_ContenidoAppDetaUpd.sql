USE [BelcorpPeru_APP]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaUpd]    Script Date: 17/5/2019 12:33:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
		--print @Orden;

		UPDATE dbo.ContenidoAppDeta 
				SET Orden = Orden - 1
				WHERE Estado = 1 and IdContenido = @IdContenido and Orden > @Orden;

		SET @respuesta = 1;
	end
	
END

