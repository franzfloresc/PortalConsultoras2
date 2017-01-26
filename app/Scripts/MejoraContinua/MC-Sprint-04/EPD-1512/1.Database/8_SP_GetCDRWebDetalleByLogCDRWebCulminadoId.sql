USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetCDRWebDetalleByLogCDRWebCulminadoId' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
END
GO
CREATE PROCEDURE dbo.GetCDRWebDetalleByLogCDRWebCulminadoId
	@LogCDRWebCulminadoId bigint
AS
BEGIN
	SELECT 
		LCDRWDC.LogCDRWebDetalleCulminadoId as CDRWebDetalleID
		,LCDRWC.CDRWebID
		,LCDRWDC.CodigoOperacion
		,LCDRWDC.CodigoReclamo
		,LCDRWDC.CUV
		,LCDRWDC.Cantidad
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.CUV, LCDRWDC.CUV2) as CUV2
		,iif(isnull(LCDRWDC.CUV2,'') = '', LCDRWDC.Cantidad, LCDRWDC.Cantidad2) as Cantidad2
		,LCDRWDC.FechaRegistro
		,pc.Descripcion as Descripcion
		,iif(isnull(LCDRWDC.CUV2,'') = '', pc.Descripcion, pc2.Descripcion) as Descripcion2
		,case
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(LCDRWDC.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * LCDRWDC.Cantidad)
			when LCDRWDC.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * LCDRWDC.Cantidad2)
			else (pwd.MontoPagar * LCDRWDC.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM LogCDRWebDetalleCulminado LCDRWDC
	INNER JOIN LogCDRWebCulminado LCDRWC on LCDRWDC.LogCDRWebCulminadoId = LCDRWC.LogCDRWebCulminadoId
	INNER JOIN ods.ProductoComercial pc on LCDRWDC.CUV = pc.CUV and pc.AnoCampania = LCDRWC.CampaniaID
	LEFT JOIN ods.ProductoComercial pc2 on LCDRWDC.CUV2 = pc2.CUV and pc2.AnoCampania = LCDRWC.CampaniaID
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = LCDRWDC.CUV and pwd.PedidoID = LCDRWC.PedidoID
	WHERE LCDRWDC.LogCDRWebCulminadoId = @LogCDRWebCulminadoId;
END
GO