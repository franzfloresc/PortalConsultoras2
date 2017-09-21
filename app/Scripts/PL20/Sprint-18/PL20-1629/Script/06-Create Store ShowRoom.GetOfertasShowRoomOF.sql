
USE BelcorpBolivia
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpColombia
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpDominicana
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpEcuador
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpMexico
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpPanama
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpPeru
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpSalvador
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO

/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	DROP PROCEDURE ShowRoom.GetOfertasShowRoomOF
GO

CREATE PROCEDURE [ShowRoom].[GetOfertasShowRoomOF]
@CampaniaID int
AS
/*
ShowRoom.GetShowRoomOfertasConsultora 201709
*/
BEGIN
	declare @tablaFaltante table (CUV varchar(6))
	insert into @tablaFaltante
	select distinct ltrim(rtrim(CUV)) from dbo.ProductoFaltante nolock where CampaniaID = @CampaniaID 
	Union All
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV from ods.FaltanteAnunciado fa (nolock) 
		inner join ods.Campania c (nolock) on fa.CampaniaID = c.CampaniaID
	where c.Codigo = @CampaniaID 

	select
	--o.OfertaShowRoomID,
	--o.CampaniaID,
	o.CUV,
	--o.TipoOfertaSisID,
	--o.ConfiguracionOfertaID,
	o.Descripcion as NombreComercial,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioCatalogo,
	--o.Stock,
	--o.StockInicial,
	o.ImagenProducto as Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	from ShowRoom.OfertaShowRoom o
	inner join ods.ProductoComercial pc on o.CampaniaID = pc.CampaniaID 
		and o.CUV = pc.CUV
	inner join ods.Campania c on o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	where 
		c.Codigo = @CampaniaID
		--and ec.CodigoConsultora = @CodigoConsultora
		and o.FlagHabilitarProducto = 1
		and o.CUV not in (select CUV from @tablaFaltante)
	--order by pos.Orden
END
GO




