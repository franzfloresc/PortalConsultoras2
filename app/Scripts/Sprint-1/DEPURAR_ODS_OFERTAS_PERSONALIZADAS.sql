PRINT 'Inicia Bolivia'
GO

USE BelcorpBolivia
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_BO
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Chile'
GO

USE BelcorpChile
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_CL
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Colombia'
GO

USE BelcorpColombia
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_CO
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Costa Rica'
GO

USE BelcorpCostaRica
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_CR
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Dominicana'
GO

USE BelcorpDominicana
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_DO
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Ecuador'
GO

USE BelcorpEcuador
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_EC
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Guatemala'
GO

USE BelcorpGuatemala
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_GT
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Mexico'
GO

USE BelcorpMexico
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_MX
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Panama'
GO

USE BelcorpPanama
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_PA
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Peru'
GO

USE BelcorpPeru
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_PE
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Puerto Rico'
GO

USE BelcorpPuertoRico
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_PR
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Salvador'
GO

USE BelcorpSalvador
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_SV
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO


PRINT 'Inicia Venezuela'
GO

USE BelcorpVenezuela
GO

DECLARE @CampaniaActual INT
DECLARE @Campania2Anterior VARCHAR(8)
DECLARE @NroCampanias INT
DECLARE @Anio INT
DECLARE @Campania INT

SELECT @CampaniaActual = dbo.fnGetCampaniaActualPais()

SELECT @NroCampanias = NroCampanias FROM Pais (NOLOCK) WHERE EstadoActivo = 1

SELECT 
	@Anio = Anio,
	@Campania = CONVERT(INT, SUBSTRING(Codigo,5,2))
FROM ods.Campania (NOLOCK)
WHERE Codigo = @CampaniaActual

IF(@Campania = 1)
	SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias - 1))
ELSE
	IF(@Campania = 2)
		SET @Campania2Anterior = CONCAT((@Anio - 1), (@NroCampanias))
	ELSE
		SET @Campania2Anterior = CONCAT(@Anio, (@Campania - 2))

BEGIN TRANSACTION DepuraOfertasPersonalizadas
SET ROWCOUNT 10000
 eliminar:
	DELETE FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta <= @Campania2Anterior
	IF @@ROWCOUNT > 0 GOTO eliminar
SET ROWCOUNT 0
COMMIT TRANSACTION DepuraOfertasPersonalizadas

GO

USE ODS_VE
GO

ALTER INDEX ALL ON dbo.OfertasPersonalizadas
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);
GO

