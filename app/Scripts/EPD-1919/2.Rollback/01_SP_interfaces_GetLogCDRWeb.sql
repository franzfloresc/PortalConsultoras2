GO
ALTER PROCEDURE interfaces.GetLogCDRWeb
	@ProcesoAutomaticoId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWeb(
		ProcesoAutomaticoId,
		CDRWebId,
		CampaniaId,
		PedidoId,
		PedidoFacturadoId,		
		ConsultoraId,
		CodigoConsultora,
		CodigoRegion,
		CodigoZona,
		FechaRegistro,
		FechaCulminado,
		Estado
	)
	SELECT
		@ProcesoAutomaticoId,
		CDRW.CDRWebID,
		CDRW.CampaniaID,
		CDRW.PedidoId,
		CDRW.PedidoNumero,
		CDRW.ConsultoraID,
		LEFT(C.Codigo,15),
		LEFT(R.Codigo,2),
		LEFT(Z.Codigo,4),
		CDRW.FechaRegistro,
		CDRW.FechaCulminado,
		1
	FROM CDRWeb CDRW
	INNER JOIN ods.Consultora C ON CDRW.ConsultoraID = C.ConsultoraID
	INNER JOIN ods.Region R ON R.RegionID = C.RegionID
	INNER JOIN ods.Zona Z ON Z.RegionID = C.RegionID AND Z.ZonaID = C.ZonaID
	WHERE CDRW.Estado = 2; --CULMINADOS
 
	SELECT		
		l.LogCDRWebId,
		l.ProcesoAutomaticoId,
		l.CDRWebId,
		l.CampaniaId,
		l.PedidoId,
		l.PedidoFacturadoId,
		l.CodigoConsultora,
		l.CodigoRegion,
		l.CodigoZona,
		l.FechaRegistro,
		l.FechaCulminado,
		isnull(u.Email,'') as Email,
		isnull(u.Nombre,u.Sobrenombre) as NombreCompleto
	FROM interfaces.LogCDRWeb l
	LEFT JOIN usuario u on
		l.CodigoConsultora = u.CodigoConsultora		
	WHERE l.ProcesoAutomaticoId = @ProcesoAutomaticoId;	
END
GO