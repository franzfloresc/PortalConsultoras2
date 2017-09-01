use BelcorpPeru
go
alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin
	
select 
	0 as EsOfertaFinalZonaValida, 
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
dbo.ObtenerDatosRegionZonaByCodigoZona '1508'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

use BelcorpMexico
go
alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '1508'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

select 
	0 as EsOfertaFinalZonaValida, 
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
go
use BelcorpBolivia
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpEcuador
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpCostaRica
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpDominicana
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpGuatemala
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpPanama
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpPuertoRico
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpSalvador
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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

go
use BelcorpVenezuela
go

alter procedure dbo.ObtenerDatosRegionZonaByCodigoZona
@CodigoZona varchar(4)
as
/*
dbo.ObtenerDatosRegionZonaByCodigoZona '7413'
*/
begin

select 
	0 as EsOfertaFinalZonaValida, 
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
