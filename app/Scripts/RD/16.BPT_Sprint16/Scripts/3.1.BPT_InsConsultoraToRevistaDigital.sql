

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[interfaces].[InsConsultoraToRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
GO

CREATE PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT * FROM ConfiguracionPaisDatos Cpd
					INNER JOIN ConfiguracionPais Cp ON Cpd.ConfiguracionPaisID = Cp.ConfiguracionPaisID
					WHERE Cp.Codigo = 'RD' AND Cpd.Codigo = 'ActivarSuscripcionUnete' AND Cpd.Valor1 = '1' and Cpd.Estado = 1)
		BEGIN
			DECLARE @IsoPais VARCHAR(20);
			SELECT @IsoPais = CodigoISO FROM Pais WHERE EstadoActivo = 1;

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
				L.FechaIngreso,
				1,
				0,
				@IsoPais,
				Z.Codigo, 
				COALESCE(L.Email, ''),
				L.AnoCampanaIngreso,
				'UNETE'
			FROM interfaces.LogPSOInsConsultora L
				INNER JOIN ods.zona Z on L.zonaid = Z.zonaid
			WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '' 
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


