USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CargaEstadoValidadorDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[CargaEstadoValidadorDatos]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 03/04/2019   
DESCRIPCIÓN : RETORNA EL ESTADO DEL POPUP VALIDADOR
*/ 

CREATE PROCEDURE CargaEstadoValidadorDatos
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE TablaLogicaID=171
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO

GO
