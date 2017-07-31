use BelcorpPeru
go
alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta,
PrecioMinimo
from OfertaFinalParametria

end


GO
use BelcorpColombia
go
alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta,
PrecioMinimo
from OfertaFinalParametria

end


GO
GO
use BelcorpMexico
go

ALTER PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta,
PrecioMinimo
from OfertaFinalParametria

end


GO
use BelcorpChile
go

alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta,
PrecioMinimo
from OfertaFinalParametria

end


GO
