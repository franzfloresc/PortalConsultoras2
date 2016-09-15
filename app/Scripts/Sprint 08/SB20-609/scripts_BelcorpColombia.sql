USE [BelcorpColombia]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	drop procedure ShowRoom.UpdStockOfertaShowRoomMasivo
go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
  DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int
  )
GO

create procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

ALTER PROCEDURE [dbo].[InsPedidoWebDetalleOferta_SB2]
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

go

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10)
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'00025',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'02767',2701,2161,'50','5052'
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID,null
FROM OfertaProducto op
inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID,null    
 FROM ShowRoom.OfertaShowRoom op    
 inner join ods.Campania c on     
 op.CampaniaID = c.CampaniaID    
where --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	select 1 from dbo.ProductoSugerido 
			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
begin
	set @TieneSugerido = 1
end
	
IF(@Criterio = 1)
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcc.CUVRevista IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,
		p.PrecioValorizado
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
END
ELSE
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
			(	SELECT E.TipoEstrategiaID FROM Estrategia E
				INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
				WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcc.CUVRevista IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,
		p.PrecioValorizado
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on
		op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	left join MatrizComercial mc on
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON
		EST.CampaniaID = p.AnoCampania
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV	TCC WHERE TCC.CUV = p.CUV))
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON
		p.MarcaId = M.MarcaId
	where
		p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion))>0
END

END

go

ALTER procedure [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'02767',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2)
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

end

go