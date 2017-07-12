GO
alter procedure [dbo].[GetCDRWeb]
@ConsultoraID BIGINT
,@PedidoID INT = 0
,@CampaniaID INT = 0
,@CDRWebID INT = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,708495691,0
GetCDRWeb 2,0,0,3013
*/
BEGIN
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
		(select count(*) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle
		,ISNULL(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId 
			AND Estado = 2 AND EstadoCDR = 3
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO