USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.UpdConsultoraCaminoBrillanteAnim'))
	DROP PROC dbo.UpdConsultoraCaminoBrillanteAnim
GO
-- GetConsultoraCaminoBrillante 3897, 201902, 201913, 4
CREATE PROC dbo.UpdConsultoraCaminoBrillanteAnim
(
	@ConsultoraID BIGINT,
	@KeyName VARCHAR(50),
	@Val VARCHAR(8),
	@Rep VARCHAR(8)
)
AS
BEGIN
	DECLARE @IVal bit = 0
	DECLARE @IRep bit = 0

	SELECT @IVal = 1 WHERE @Val = '1'
	SELECT @IRep = 1 WHERE @Rep = '1'

	UPDATE ConsultoraCaminoBrillante
		SET [FlagOnboardingAnim] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IVal ELSE [FlagOnboardingAnim]  END
		   ,[FlagOnboardingAnimRepeat] = CASE WHEN @KeyName = 'CB_CON_ONBOARDING_ANIM' THEN @IRep ELSE [FlagOnboardingAnimRepeat]  END 
		   ,[FlagGananciaAnim] = CASE WHEN @KeyName = 'CB_CON_GANANCIA_ANIM' THEN @IVal ELSE [FlagGananciaAnim]  END 
		   ,[FlagCambioNivelAnim] = CASE WHEN @KeyName = 'CB_CON_CAMB_NIVEL_ANIM' THEN @IVal ELSE [FlagCambioNivelAnim]  END 
		   ,FechaEdicion = GETDATE()
	WHERE ConsultoraID = @ConsultoraID;
END

