USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProductoMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProductoMasiva
@EstrategiaXML as XML,
@CampaniaID INT,
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT
AS
 SET NOCOUNT ON 
 SET @RetornoActualizacion = 0

MERGE INTO dbo.EstrategiaProducto e
   USING (SELECT  tabla.variable.value('CUV[1]', 'NVARCHAR(40)') AS 'CUV'
		  		, tabla.variable.value('NombreProducto[1]', 'VARCHAR(150)') AS 'NombreProducto'
				, tabla.variable.value('Descripcion1[1]', 'VARCHAR(255)') AS 'Descripcion1'
				, tabla.variable.value('Orden[1]', 'INT') AS 'Orden'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden;
 SET @RetornoActualizacion = @@ROWCOUNT
GO

