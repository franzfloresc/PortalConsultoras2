USE BelcorpCostaRica
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpDominicana
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpEcuador
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpGuatemala
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpPanama
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpPuertoRico
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpSalvador
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpColombia
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpMexico
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO
/*end*/

USE BelcorpPeru
GO
alter procedure GetValidacionStockProductos
	@ConsultoraId bigint,
	@ValidacionStockProlId bigint
as
begin
	select
		vs.CUV,
		vs.DescripcionProducto as DescripcionProd,
		vs.StockDisponible,
		0 as Cantidad,
		0 as PrecioUnidad,
		0 as ImporteTotal,
		'' as  ObservacionPROL
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.consultora c with(nolock) on vs.Codigo = c.Codigo
	where 
		c.ConsultoraId = @ConsultoraId
		and
		vs.ValidacionStockProlId = @ValidacionStockProlId
		and
		vs.Enviocorreo = 1;
end
GO