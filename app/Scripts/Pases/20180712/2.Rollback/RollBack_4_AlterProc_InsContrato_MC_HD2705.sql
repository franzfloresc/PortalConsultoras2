GO
USE BelcorpPeru
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

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
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsContrato')
BEGIN
	DROP PROC InsContrato
END
GO
CREATE PROCEDURE [dbo].[InsContrato]
	@consultoraid BIGINT,
	@codigoconsultora VARCHAR(25),
	@origen VARCHAR(25)
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
			UPDATE contrato SET  origen = @origen , AceptoContrato = 1, FechaAceptacion=GETDATE() WHERE ConsultoraID=@consultoraid
			UPDATE PaqueteDocumentario SET Campania = @CampaniaID, EstadoInvitacion = 1 WHERE CodigoConsultora = @CodigoUsuario
		END
		ELSE
		BEGIN
			INSERT INTO contrato(ConsultoraID	,CodigoConsultora	,AceptoContrato	,FechaAceptacion	,origen)
						  VALUES(@consultoraid	,@codigoconsultora	,1				,GETDATE()			,@origen)

			IF NOT EXISTS(SELECT 1 FROM PaqueteDocumentario WHERE CodigoConsultora = @codigoconsultora AND Campania = @CampaniaID)
			BEGIN
				INSERT INTO PaqueteDocumentario VALUES (@CodigoUsuario, @CampaniaID, 1)
			END
		END
	SET NOCOUNT OFF
END

GO
