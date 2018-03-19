USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarRdSuscripcionNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
GO

CREATE PROCEDURE [dbo].[ActualizarRdSuscripcionNuevas]
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionNuevas' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
	BEGIN
		DECLARE @IsoPais VARCHAR(20);
		DECLARE @RegionesIn VARCHAR(500) = '';

		SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;
		SELECT @RegionesIn = ISNULL(Valor1, '') FROM ConfiguracionPaisDatos WHERE Codigo = 'HabilitarRegionesNuevas' AND Estado = 1;

		INSERT INTO RevistaDigitalSuscripcion(
			CodigoConsultora,
			CampaniaID,
			FechaSuscripcion,
			EstadoRegistro,
			EstadoEnvio,
			IsoPais,
			CodigoZona,
			EMail,
			CampaniaEfectiva,
			Origen,
			SubOrigen
		)
		SELECT  
			CT.CodigoConsultora,
			CT.Campania,
			dbo.fnObtenerFechaHoraPais(),
			1,
			0,
			@IsoPais,
			Z.Codigo, 
			COALESCE(C.Email, ''),
			CT.Campania,
			'NUEVA',
			CT.Origen
		FROM ods.Consultora AS C
		INNER JOIN ods.zona Z on C.ZonaID = Z.ZonaID
		INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
		INNER JOIN (SELECT CodigoConsultora, Campania, Origen FROM ConsultoraNuevaTemporal 
					WHERE CodigoConsultora NOT IN (
					SELECT RDS.CodigoConsultora FROM RevistaDigitalSuscripcion RDS
					INNER JOIN (SELECT MAX(RS.RevistaDigitalSuscripcionID) AS id
								FROM RevistaDigitalSuscripcion RS
								INNER JOIN ConsultoraNuevaTemporal TC ON RS.CodigoConsultora = TC.CodigoConsultora
    							GROUP BY RS.CodigoConsultora) TMP ON TMP.id = RDS.RevistaDigitalSuscripcionID
					WHERE EstadoRegistro = 1)) AS CT ON CT.CodigoConsultora = C.Codigo
		WHERE (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')));
	END
END
GO

