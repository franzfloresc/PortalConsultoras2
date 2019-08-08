USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO 

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO


USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END
GO


USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetConsultoraCaminoBrillante'))
	DROP PROC dbo.GetConsultoraCaminoBrillante
GO

CREATE PROC dbo.GetConsultoraCaminoBrillante
(
	@ConsultoraID BIGINT,
	@PeriodoCB INT,
	@Campania INT,
	@NivelCB INT
)
AS
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ConsultoraCaminoBrillante WITH(NOLOCK) WHERE  ConsultoraID = @ConsultoraID)
		BEGIN
			INSERT INTO ConsultoraCaminoBrillante (
			   [ConsultoraID]
			  ,[PeriodoCB]
			  ,[Campania]
			  ,[NivelCB]
			  ,[CambioNivelCB]
			  ,[FlagOnboardingAnim]
			  ,[FlagOnboardingAnimRepeat]
			  ,[FlagGananciaAnim]
			  ,[FlagCambioNivelAnim]
			  ,[FechaRegistro])
		   VALUES (
			  @ConsultoraID 
			  , @PeriodoCB
			  , @Campania
			  , @NivelCB
			  , NULL
			  , 0
			  , 0
			  , 0
			  , 0
			  , GETDATE()
		   );
		END
	ELSE 
		BEGIN 
			UPDATE ConsultoraCaminoBrillante
			SET PeriodoCB = @PeriodoCB
				, Campania = @Campania
				, NivelCB = @NivelCB
				, FechaEdicion = GETDATE()
			WHERE ConsultoraID = @ConsultoraID AND (PeriodoCB <> @PeriodoCB OR Campania <> @Campania OR NivelCB <> @NivelCB )
		END
	
	/* SELECT */
	SELECT TOP 1 [ConsultoraID]
      ,[PeriodoCB]
      ,[Campania]
      ,[NivelCB]
      ,[CambioNivelCB]
      ,[FlagOnboardingAnim]
      ,[FlagOnboardingAnimRepeat]
      ,[FlagGananciaAnim]
      ,[FlagCambioNivelAnim]
      ,[FechaRegistro]
      ,[FechaEdicion] 
	FROM ConsultoraCaminoBrillante WITH(NOLOCK) 
	WHERE ConsultoraID = @ConsultoraID;
END

