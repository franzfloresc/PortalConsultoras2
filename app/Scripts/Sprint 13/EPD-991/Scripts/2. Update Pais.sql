
USE BelcorpBolivia
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (
	SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Pais]') AND name = 'OFGanaMas'
)
BEGIN
	ALTER TABLE Pais DROP COLUMN OFGanaMas
END
GO

ALTER TABLE Pais ADD OFGanaMas TINYINT

INSERT INTO OfertaFinalParametria (Tipo,PrecioMinimo) VALUES('GM', 25)

GO