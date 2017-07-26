use BelcorpPeru 
go
alter procedure dbo.GetPaisByCodigoISO
@CodigoISO char(2)
as
/*
GetPaisByCodigoISO 'PE'
*/
begin

select PaisID, Nombre, Simbolo, OfertaFinal, OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
from dbo.Pais 
where CodigoISO = @CodigoISO

end


GO
use BelcorpColombia
go
alter procedure dbo.GetPaisByCodigoISO
@CodigoISO char(2)
as
/*
GetPaisByCodigoISO 'PE'
*/
begin

select PaisID, Nombre, Simbolo, OfertaFinal, OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
from dbo.Pais 
where CodigoISO = @CodigoISO

end


GO
