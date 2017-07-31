use BelcorpPeru
go
alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2
@Algoritmo varchar(10) = NUll
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta,
PrecioMinimo,
Algoritmo
from OfertaFinalParametria
where Algoritmo = @Algoritmo or isnull(@Algoritmo,'') = ''

end


GO
use BelcorpColombia
go
alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
@Algoritmo varchar(10) = NUll
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
where Algoritmo = @Algoritmo or isnull(@Algoritmo,'') = ''
end


GO
GO
use BelcorpMexico
go
ALTER PROCEDURE dbo.GetParametriaOfertaFinal_SB2
@Algoritmo varchar(10) = NUll
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
where Algoritmo = @Algoritmo or isnull(@Algoritmo,'') = ''
end
go
GO
use BelcorpChile
go

alter PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
@Algoritmo varchar(10) = NUll
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
where Algoritmo = @Algoritmo or isnull(@Algoritmo,'') = ''
end


GO
