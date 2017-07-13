USE BelcorpBolivia
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpCostaRica
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpChile
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpColombia
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpDominicana
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpEcuador
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpGuatemala
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpMexico
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpPanama
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpPeru
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpPuertoRico
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpSalvador
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
USE BelcorpVenezuela
GO
DECLARE @CodigoTipoEstrategia INT
DECLARE @CodigoOferta INT

SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
SET @CodigoOferta = (SELECT TOP 1 OfertaID FROM Oferta WHERE CodigoOferta=105)

DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID=@CodigoTipoEstrategia AND OfertaID=@CodigoOferta
DELETE FROM TipoEstrategia WHERE TipoEstrategiaID = @CodigoTipoEstrategia

GO
