use BelcorpPeru
go
alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

declare @EsOfertaFinalZonaValida int = 0

if not exists (select 1 from OfertaFinalRegionZona where CodigoZona = @CodigoZona and Estado = 1)
	set @EsOfertaFinalZonaValida = 1

select 
	@EsOfertaFinalZonaValida as EsOfertaFinalZonaValida, 
	z.ZonaID, 
	z.Codigo as CodigoZona, 
	r.RegionID, 
	r.Codigo as CodigoRegion
from ods.Zona z
inner join ods.Region r on
	z.RegionID = r.RegionID
where z.Codigo = @CodigoZona

end


GO
use BelcorpColombia
go
alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

declare @EsOfertaFinalZonaValida int = 0

if not exists (select 1 from OfertaFinalRegionZona where CodigoZona = @CodigoZona and Estado = 1)
	set @EsOfertaFinalZonaValida = 1

select 
	@EsOfertaFinalZonaValida as EsOfertaFinalZonaValida, 
	z.ZonaID, 
	z.Codigo as CodigoZona, 
	r.RegionID, 
	r.Codigo as CodigoRegion
from ods.Zona z
inner join ods.Region r on
	z.RegionID = r.RegionID
where z.Codigo = @CodigoZona

end


GO


GO
use BelcorpMexico
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

declare @EsOfertaFinalZonaValida int = 0

if not exists (select 1 from OfertaFinalRegionZona where CodigoZona = @CodigoZona and Estado = 1)
	set @EsOfertaFinalZonaValida = 1

select 
	@EsOfertaFinalZonaValida as EsOfertaFinalZonaValida, 
	z.ZonaID, 
	z.Codigo as CodigoZona, 
	r.RegionID, 
	r.Codigo as CodigoRegion
from ods.Zona z
inner join ods.Region r on
	z.RegionID = r.RegionID
where z.Codigo = @CodigoZona

end


GO
use BelcorpChile
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

declare @EsOfertaFinalZonaValida int = 0

if not exists (select 1 from OfertaFinalRegionZona where CodigoZona = @CodigoZona and Estado = 1)
	set @EsOfertaFinalZonaValida = 1

select 
	@EsOfertaFinalZonaValida as EsOfertaFinalZonaValida, 
	z.ZonaID, 
	z.Codigo as CodigoZona, 
	r.RegionID, 
	r.Codigo as CodigoRegion
from ods.Zona z
inner join ods.Region r on
	z.RegionID = r.RegionID
where z.Codigo = @CodigoZona

end


GO
