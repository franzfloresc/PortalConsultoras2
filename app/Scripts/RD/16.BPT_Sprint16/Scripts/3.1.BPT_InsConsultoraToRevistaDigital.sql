USE [BelcorpPeru_BPT]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[interfaces].[InsConsutoraToRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
GO

CREATE PROCEDURE [interfaces].[InsConsultoraToRevistaDigital]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	BEGIN TRY
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
		WHERE PSOInsConsultoraId = 54323 AND ISNULL(Error,'') = '' 
			AND L.Codigo NOT IN (SELECT L.Codigo
				FROM RevistaDigitalSuscripcion R 
				INNER JOIN interfaces.LogPSOInsConsultora L ON R.CodigoConsultora = L.Codigo AND R.CampaniaID = L.AnoCampanaIngreso
				WHERE L.PSOInsConsultoraId = 54323 AND ISNULL(L.Error,'') = '');
	END TRY
	BEGIN CATCH
		PRINT 'Error al suscribir consultora'
	END CATCH
END

GO


