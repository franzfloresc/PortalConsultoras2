use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go


use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR]
GO
/*         
CREADO POR  : PAQUIRRI SEPERAK         
FECHA : 24/06/2019         
DESCRIPCIÓN : OBTIENE LA CARGA DE PEDIDOS
*/ 
CREATE proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT_SINMARCAR] --'CR',1,'2014-04-23',80
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@CampanaId int,
	@intNroLote int,
    @FechaFacturacion date
as
set nocount on;


declare @TempPedidoDDID as table(
NroLote  int,
Campaniaid int null,
PedidoId int null)


IF @intSEQIDZonaGrupo = 1
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 
	        and p.ImporteTotal <> 0 and 
			--p.IndicadorEnviado = 0 
			cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioReFacturacion >= @FechaFacturacion and
			ca.codigo =@CampanaId and
			c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
END
ELSE
BEGIN
	insert into @TempPedidoDDID (NroLote, CampaniaID, PedidoID)
	select @intNroLote, p.CampaniaId, p.PedidoID
	from PedidoDD p with(nolock)
	inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
	where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
			---p.IndicadorEnviado = 0 
			cr.FechaInicioWeb <= @FechaFacturacion and
			cr.FechaInicioDD >= @FechaFacturacion and
			ca.codigo =@CampanaId 
END

select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',
		ValorCupon = '000000000000'
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from @TempPedidoDDID pk 
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote 
and pd.IndicadorActivo = 1
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV
go
