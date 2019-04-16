USE [BelcorpBolivia];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpChile];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpColombia];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpCostaRica];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpDominicana];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpEcuador];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpGuatemala];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpMexico];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpPanama];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpPeru];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpPuertoRico];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
USE [BelcorpSalvador];
GO
CREATE PROCEDURE dbo.EliminarArchivoCsvValidador 
AS 
  BEGIN 
		DECLARE @TablaLogicaDatosID  INT
		SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

      DELETE FROM SEGMENTACIONCOMUNICADO 
      WHERE  SEGMENTACIONID = @TablaLogicaDatosID 
  END 

GO
