USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'[chatbot].[InsertDetalleResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertDetalleResultados]
GO

CREATE PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END
GO
