GO
IF NOT EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetLogCDRWebByLogCDRWebId' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    exec (N'CREATE PROCEDURE interfaces.GetLogCDRWebByLogCDRWebId AS');
END
GO
ALTER PROCEDURE interfaces.GetLogCDRWebByLogCDRWebId
	@LogCDRWebId BIGINT
AS
BEGIN		
	SELECT
		LogCDRWebId,
		CDRWebId,
		CampaniaId,
		PedidoId,
		PedidoFacturadoId,
		ConsultoraId,
		CodigoConsultora,
		FechaRegistro,
		FechaCulminado,
		FechaAtencion,
		ImporteCDR,
		EstadoCDR,
		ISNULL(ConsultoraSaldo,0) AS ConsultoraSaldo,
		TipoDespacho,
		FleteDespacho,
		MensajeDespacho
	FROM interfaces.LogCDRWeb
	WHERE LogCDRWebId = @LogCDRWebId;
END
GO