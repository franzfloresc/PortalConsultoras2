USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetCDRWebDetalle
(
	@CDRWebID int,
	@PedidoID int = 0
)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	declare @CampaniaId int = 0;
	select @CampaniaId = CampaniaID from CDRWeb where CDRWebID = @CDRWebID;
	
	set @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	if (@CDRWebID = 0)
	begin
		select top 1
			@CDRWebID = CDRWebID,
			@CampaniaId = CampaniaID
		from CDRWeb where PedidoID = @PedidoID
	end

	SELECT 
		cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,case 
			when isnull(cd.CUV2,'') = '' then cd.CUV
			else cd.CUV2
		end as CUV2
		,case
			when isnull(cd.CUV2,'') = '' then cd.Cantidad
			else cd.Cantidad2
		end as Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.Observacion
		,cd.Eliminado
		,pc.Descripcion as Descripcion
		,case
			when isnull(cd.CUV2, '') = '' then pc.Descripcion
			else pc2.Descripcion
		end as Descripcion2
		,case
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			when cd.CodigoOperacion = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID and cd.Eliminado = 0		
END
GO