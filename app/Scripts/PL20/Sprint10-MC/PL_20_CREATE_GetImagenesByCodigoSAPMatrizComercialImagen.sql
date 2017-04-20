USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[GetImagenesByCodigoSAP]    Script Date: 20/04/2017 12:29:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImagenesByCodigoSAPMatrizComercialImagen]
(
	@CodigoSAP varchar(50)
)
AS
BEGIN

	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
		   CodigoSAP,
		   isnull(Foto,'') Foto,
		   FechaRegistro
	FROM MatrizComercialImagen
	where codigoSAP = @CodigoSAP
END
