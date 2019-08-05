USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'[chatbot].[InsertResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[InsertResultados]
GO

CREATE PROCEDURE [chatbot].[InsertResultados]
	 @OperadorID VARCHAR(50)
	,@NombreOperador VARCHAR(100)
	,@CodigoConsultora VARCHAR(25)
	,@NombreConsultora VARCHAR(150)
	,@FechaInicio DATETIME
	,@Campania VARCHAR(10)
	,@Pais VARCHAR(2)
	,@ConversacionID VARCHAR(50)
	,@CanalID SMALLINT
	,@new_identity int output
AS
BEGIN
	INSERT INTO [chatbot].[Resultados]
		(OperadorID
		,NombreOperador
		,CodigoConsultora
		,NombreConsultora
		,FechaInicio
		,Campania
		,Pais
		,ConversacionID
		,CanalID)
		VALUES
		(@OperadorID
		,@NombreOperador
		,@CodigoConsultora
		,@NombreConsultora
		,@FechaInicio
		,@Campania
		,@Pais
		,@ConversacionID
		,@CanalID);
		SET @new_identity = SCOPE_IDENTITY();
END
GO
