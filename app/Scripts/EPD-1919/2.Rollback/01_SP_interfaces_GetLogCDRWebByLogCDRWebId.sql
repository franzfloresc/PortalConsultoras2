GO
ALTER PROCEDURE [interfaces].[GetLogCDRWebByLogCDRWebId]
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
		ISNULL(ConsultoraSaldo,0) AS ConsultoraSaldo
	FROM interfaces.LogCDRWeb
	WHERE LogCDRWebId = @LogCDRWebId;
END
GO