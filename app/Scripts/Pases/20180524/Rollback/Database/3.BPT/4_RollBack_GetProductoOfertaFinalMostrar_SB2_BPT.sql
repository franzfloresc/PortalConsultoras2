USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetProductoOfertaFinalMostrar_SB2]
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
AS
/*
GetProductoOfertaFinalMostrar_SB2 201618,'000758833',2161,'50','5052'
*/
BEGIN

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante WITH(NOLOCK)
where CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa  WITH(NOLOCK)
inner join ods.Campania c  WITH(NOLOCK) on fa.CampaniaID = c.CampaniaID
where c.Codigo = @CampaniaID
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV
FROM PedidoWebDetalle p WITH(NOLOCK)
INNER JOIN ods.Consultora c WITH(NOLOCK) ON p.ConsultoraID = c.ConsultoraID
WHERE p.CampaniaID=@CampaniaID and c.Codigo = @CodigoConsultora

select distinct 
	pc.CUV, 
	pc.CodigoProducto as CodigoSap, 
	op.Orden
from ods.ProductoComercial pc WITH(NOLOCK)
inner join ods.ofertaspersonalizadas op WITH(NOLOCK) on pc.CUV = op.CUV 
	and pc.AnoCampania = op.AnioCampanaVenta 
	and op.CodConsultora = @CodigoConsultora
	and op.TipoPersonalizacion = 'OF'
where pc.AnoCampania = @CampaniaID
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

END
GO