GO
alter procedure [dbo].[GetCDRWeb]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
as
--GetCDRWeb 2
BEGIN
	--INI: EPD-1919
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);
	declare @MensajeCDRExpress varchar(200) = isnull((select top 1 Descripcion from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'Mensaje'),'');
	declare @MensajeCDRExpressNueva varchar(200) = isnull((select top 1 Descripcion from TablaLogicaDatos where TablaLogicaID = 104 and Codigo = 'MensajeNew'),'');
	--FIN: EPD-1919

	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId 
			AND Estado = 2 AND EstadoCDR = 3
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		@TieneCDRExpress as TieneCDRExpress, --EPD-1919
		@MensajeCDRExpress as MensajeCDRExpress, --EPD-1919
		@MensajeCDRExpressNueva as MensajeCDRExpressNueva --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO