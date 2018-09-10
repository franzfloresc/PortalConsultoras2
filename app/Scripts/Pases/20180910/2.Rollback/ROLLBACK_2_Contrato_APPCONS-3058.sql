USE BelcorpPeru
GO

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

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

/* ROOLBACK COLUMNAS A TABLA CONTRATO */
IF COL_LENGTH('Contrato', 'IMEI') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_IMEI') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_IMEI;
  END
  ALTER TABLE Contrato DROP COLUMN IMEI;
END

IF COL_LENGTH('Contrato', 'DeviceID') IS NOT NULL
BEGIN
  IF OBJECT_ID('DF_Contrato_DeviceID') IS NOT NULL 
  BEGIN
	ALTER TABLE Contrato
	DROP CONSTRAINT DF_Contrato_DeviceID;
  END
  ALTER TABLE Contrato DROP COLUMN DeviceID;
END

/* ROOLBACK PROCEDIMIENTO GETCONTRATOS */
IF (OBJECT_ID('GetContratos') IS NOT NULL)
  DROP PROCEDURE GetContratos
GO

/* ROOLBACK PROCEDIMIENTO INSCONTRATO */
ALTER PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25),
	@direccionIP VARCHAR(15),
	@InformacionSOMobile VARCHAR(500)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE(), DireccionIP = @direccionIP, InformacionSOMobile = @InformacionSOMobile
								 WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen, DireccionIP, InformacionSOMobile)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen, @direccionIP, @InformacionSOMobile)

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END
GO


