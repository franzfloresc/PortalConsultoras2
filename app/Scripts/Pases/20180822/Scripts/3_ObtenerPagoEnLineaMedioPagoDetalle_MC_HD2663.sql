GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin
select
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

GO
