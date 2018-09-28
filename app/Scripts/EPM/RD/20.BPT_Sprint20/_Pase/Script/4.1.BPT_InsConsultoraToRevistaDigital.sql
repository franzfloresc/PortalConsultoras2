USE BelcorpPeru
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
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
				Origen
			)
			SELECT  
				L.Codigo,
				L.AnoCampanaIngreso,
				dbo.fnObtenerFechaHoraPais(),
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.Zona Z ON L.ZonaID = Z.ZonaID
				INNER JOIN ods.Region R ON Z.RegionID = R.RegionID
				INNER JOIN dbo.SolicitudPostulante sp ON l.Codigo = sp.CodigoConsultora
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
				AND sp.EstadoPostulante = 5 AND sp.FuenteIngreso = 'UB'
				AND (@RegionesIn = '' OR R.Codigo in (select * from FnSplit(@RegionesIn, ',')))
				AND L.Codigo NOT IN (SELECT L.Codigo
					FROM RevistaDigitalSuscripcion R 
					INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
					WHERE L.PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(L.Error,'') = '');
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora a RD'
	END CATCH
END
GO

