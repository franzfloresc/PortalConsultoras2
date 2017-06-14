USE BelcorpBolivia
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpChile
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpColombia
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpMexico
GO
IF OBJECT_ID('GetImagenesByIdMatrizImagen', 'P') IS NOT NULL
	DROP PROC GetImagenesByIdMatrizImagen
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpPanama
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpPeru
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpSalvador
GO

IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO

USE BelcorpVenezuela
GO
IF OBJECT_ID('GetImagenesByNemotecnico', 'P') IS NOT NULL
	DROP PROC GetImagenesByNemotecnico
GO
	
CREATE PROCEDURE [dbo].[GetImagenesByNemotecnico]
(
	@NemoTecnico nvarchar(3000)
)
AS
	EXECUTE sp_executesql @NemoTecnico;
GO
