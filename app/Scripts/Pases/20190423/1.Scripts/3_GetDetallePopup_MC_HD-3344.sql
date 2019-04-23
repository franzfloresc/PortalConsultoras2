USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetDetallePopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetDetallePopup
GO


CREATE PROCEDURE [dbo].[GetDetallePopup] 
@COMUNICADOID INT 
AS 
  BEGIN 
      SELECT COMUNICADOID, 
             DESCRIPCION, 
             ACTIVO, 
             DESCRIPCIONACCION, 
             SEGMENTACIONID, 
             URLIMAGEN, 
             ORDEN, 
             NOMBREARCHIVOCCV, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN 
             , 
             TIPODISPOSITIVO, 
             COMENTARIO 
      FROM   COMUNICADO 
      WHERE  COMUNICADOID = @COMUNICADOID 
  END 
GO
