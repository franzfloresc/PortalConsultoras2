USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EliminarArchivoCsvValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EliminarArchivoCsvValidador]
GO


/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 20/02/2019     
DESCRIPCIÓN : ELIMINA EL ARCHIVO CSV 
*/ 
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
	       	  DECLARE @TablaLogicaDatosID  INT
		      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
			  FROM   TABLALOGICADATOS 
			  WHERE  TablaLogicaID=171

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

  go

GO
