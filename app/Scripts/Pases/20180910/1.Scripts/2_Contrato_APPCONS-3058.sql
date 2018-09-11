USE BelcorpPeru
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

/* AGREGAR COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD IMEI VARCHAR(15) NULL 
	CONSTRAINT DF_Contrato_IMEI DEFAULT (NULL);
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NULL
BEGIN
  ALTER TABLE Contrato 
	ADD DeviceID VARCHAR(50) NULL 
	CONSTRAINT DF_Contrato_DeviceID DEFAULT (NULL);
END


/* CREAR PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

CREATE PROCEDURE [dbo].[GetContratos]
	@consultoraid BIGINT
AS
BEGIN	
	SELECT 
		ConsultoraID as ConsultoraId,
		CodigoConsultora as CodigoConsultora,
		AceptoContrato as AceptoContrato,
		FechaAceptacion	as FechaAceptacion,
		Origen as Origen,
		DireccionIP	as DireccionIP,
		InformacionSOMobile as InformacionSOMobile
	FROM Contrato WITH(NOLOCK)
	WHERE ConsultoraID = @consultoraid
END
GO

/* ACTUALIZAR PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500),
	@imei VARCHAR(15) = NULL,
	@deviceID VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @CodigoUsuario VARCHAR(20),
				@CampaniaID int,
				@ZonaID int,
				@RegionID int
		SET @CodigoUsuario = (	SELECT u.CodigoConsultora
								FROM Usuario U inner join ods.Consultora C ON u.CodigoConsultora = c.Codigo
								WHERE ConsultoraID = @consultoraid)

		SELECT	@ZonaID = ISNULL(ZonaID,0),
				@RegionID = ISNULL(RegionID,0)
		FROM ods.consultora WITH(NOLOCK)
		WHERE ConsultoraID = @consultoraid
		SET @CampaniaID = (SELECT campaniaId FROM dbo.GetCampaniaPreLogin(4, @ZonaID, @RegionID, @ConsultoraID))
		IF	EXISTS(SELECT 1 FROM contrato WHERE ConsultoraID= @consultoraid)
		BEGIN
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile, IMEI = @imei, DeviceID = @deviceID
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP	, InformacionSOMobile	,IMEI	,DeviceID  )
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP	, @InformacionSOMobile	,@imei	,@deviceID )

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO

