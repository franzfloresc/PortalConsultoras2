USE BelcorpBolivia
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpChile
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpColombia
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpCostaRica
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpDominicana
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpEcuador
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpGuatemala
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpMexico
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpPanama
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpPeru
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpPuertoRico
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpSalvador
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO
USE BelcorpVenezuela
GO
  IF OBJECT_ID('dbo.InsertarProductoShowroomMasiva', 'P') IS NOT NULL
	DROP PROC dbo.InsertarProductoShowroomMasiva
GO
CREATE PROCEDURE dbo.InsertarProductoShowroomMasiva
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
				, tabla.variable.value('IdMarca[1]', 'TINYINT') AS 'IdMarca'
		  FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t 
   ON  e.Campania = @CampaniaID
   AND e.CUV = t.CUV
WHEN MATCHED THEN
   UPDATE 
      SET e.CUV = t.CUV,
	      e.NombreProducto = t.NombreProducto,
		  e.Descripcion1 = t.Descripcion1,
		  e.Orden = t.Orden,
		  e.IdMarca = t.IdMarca;
 SET @RetornoActualizacion = @@ROWCOUNT
 GO