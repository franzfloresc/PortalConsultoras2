USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
USE BelcorpVenezuela
GO
IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
BEGIN
	DECLARE @orden int
	SET @orden = (SELECT TOP 1 Orden + 1 FROM TipoEstrategia ORDER BY FechaRegistro DESC)

	INSERT INTO TipoEstrategia VALUES('Los más vendidos', '', @orden, 1, 'ADMCONTENIDO', GETDATE(), NULL,NULL, 0, 0, 1, NULL, NULL, '020')
	
END

DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

IF NOT EXISTS (SELECT 1 FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta)
BEGIN
	INSERT INTO TipoEstrategiaOferta VALUES(@CodigoTipoEstrategia, @CodigoOferta)
END 

GO
