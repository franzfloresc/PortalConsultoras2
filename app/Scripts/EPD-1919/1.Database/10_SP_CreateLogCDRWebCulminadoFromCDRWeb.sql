GO
ALTER PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado,
		TipoDespacho,
		FleteDespacho,
		MensajeDespacho
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado,
		CDRW.TipoDespacho,
		CDRW.FleteDespacho,
		CDRW.MensajeDespacho
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO