USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppUpd]    Script Date: 17/5/2019 12:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ContenidoAppUpd]
@IdContenido INT,
@UrlMiniatura VARCHAR(100)
AS
BEGIN
		UPDATE ContenidoApp 
		SET
		UrlMiniatura = @UrlMiniatura
		WHERE 
		IdContenido = @IdContenido;
END

