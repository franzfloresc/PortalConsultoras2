
USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			2,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
END
