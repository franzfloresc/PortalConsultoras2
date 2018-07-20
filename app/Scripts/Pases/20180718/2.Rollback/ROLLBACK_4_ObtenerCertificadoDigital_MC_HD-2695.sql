GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[ObtenerCertificadoDigital]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@TipoCert TINYINT
)
AS

BEGIN
	IF NOT EXISTS (SELECT 1 FROM dbo.CertificadoDigitalLog
		WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert)
	BEGIN
		DECLARE
			@NumeroSecuencia VARCHAR(12),
			@NombreCompleto VARCHAR(50),
			@TipoDocumento VARCHAR(20),
			@NumeroDocumento VARCHAR(20),
			@FechaIngresoConsultora DATETIME,
			@PromedioVentas DECIMAL(18,2)
		SET @NumeroSecuencia = CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('000000' + CAST((SELECT COUNT(1)+1 FROM dbo.CertificadoDigitalLog) AS VARCHAR), 6)
		--IF (@TipoCert = 2)
			--SET @PromedioVentas = dbo.fnObtenerPromedioVentaCampaniaConsecutivas(@CampaniaId,3, @ConsultoraId)
		SELECT
			@NombreCompleto = NombreCompleto,
			@PromedioVentas = isnull(PromedioVenta,0),
			@FechaIngresoConsultora = CASE @TipoCert WHEN 2 THEN FechaIngreso ELSE NULL end
		FROM ods.Consultora
		WHERE ConsultoraId = @ConsultoraId

		SELECT
			@TipoDocumento = TipoDocumento,
			@NumeroDocumento = RIGHT(Numero,8)
		FROM ods.Identificacion
		WHERE ConsultoraId = @ConsultoraId AND DocumentoPrincipal = 1
		INSERT INTO dbo.CertificadoDigitalLog
		(
			Campania,
			ConsultoraId,
			NumeroSecuencia,
			Ciudad,
			Asunto,
			NombreCompleto,
			TipoDocumento,
			NumeroDocumento,
			DescripcionEstado,
			FechaIngresoConsultora,
			PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			TipoCert
		)
		SELECT
			@CampaniaId,
			@ConsultoraId,
			@NumeroSecuencia,
			Ciudad,
			Asunto,
			@NombreCompleto,
			@TipoDocumento,
			@NumeroDocumento,
			DescripcionEstado,
			@FechaIngresoConsultora,
			@PromedioVentas,
			RazonSocial,
			Ruc,
			Telefono,
			UrlFirma,
			Responsable,
			Cargo,
			@TipoCert
		FROM dbo.CertificadoDigitalConfig WHERE /*Campania = @CampaniaId AND*/ TipoCert = @TipoCert
	END
	ELSE
	BEGIN
		UPDATE dbo.CertificadoDigitalLog SET NumeroVeces = NumeroVeces + 1
		WHERE Campania = @CampaniaId AND ConsultoraId = ConsultoraId AND TipoCert = @TipoCert
	END
	DECLARE @DocumentoResponsable VARCHAR(30) = (SELECT documento FROM CertificadoDigitalConfig WHERE TipoCert = @TipoCert);
	SELECT
		1 AS Result,
		Campania,
		ConsultoraId,
		NumeroSecuencia,
		Ciudad,
		Asunto,
		NombreCompleto,
		TipoDocumento,
		NumeroDocumento,
		DescripcionEstado,
		FechaIngresoConsultora,
		PromedioVentas,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		NumeroVeces,
		@DocumentoResponsable DocumentoResponsable
	FROM dbo.CertificadoDigitalLog
	WHERE Campania = @CampaniaId AND ConsultoraId = @ConsultoraId AND TipoCert = @TipoCert
END

GO
