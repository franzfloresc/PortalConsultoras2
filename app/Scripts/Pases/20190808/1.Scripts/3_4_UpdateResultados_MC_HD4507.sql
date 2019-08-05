USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'[chatbot].[UpdateResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[UpdateResultados]
GO

CREATE PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
END
GO
