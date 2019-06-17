USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerZonasPorRegion]
GO
CREATE PROCEDURE  ObtenerZonasPorRegion
	-- Add the parameters for the stored procedure here
		@RegionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT	
	        Z.Codigo,
			Z.ZonaID,
			Z.RegionID ,
			Z.Nombre 
	FROM	ODS.Zona Z
	INNER JOIN ODS.Region R ON Z.RegionID=R.RegionID
	WHERE		Z.RegionID = @RegionID AND 
				Z.EstadoActivo = 1 AND 
				Z.Nombre != 'CERRADA' 
END
GO

