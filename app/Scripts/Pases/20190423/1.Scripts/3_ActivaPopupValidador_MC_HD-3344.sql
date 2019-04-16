USE [BelcorpBolivia];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpChile];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpColombia];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpCostaRica];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpDominicana];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpEcuador];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpGuatemala];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpMexico];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpPanama];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpPeru];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpPuertoRico];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
USE [BelcorpSalvador];
GO
CREATE PROCEDURE ActivaPopupValidador
	@estado INT
AS
BEGIN
DECLARE @TablaLogicaDatosID  INT
SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'
UPDATE TABLALOGICADATOS SET VALOR=@estado  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
END
GO
