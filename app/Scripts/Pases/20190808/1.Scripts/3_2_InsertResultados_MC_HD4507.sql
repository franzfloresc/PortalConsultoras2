GO
USE BelcorpPeru
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpMexico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpColombia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpSalvador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpPuertoRico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpPanama
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpGuatemala
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpEcuador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpDominicana
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpCostaRica
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpChile
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
USE BelcorpBolivia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
