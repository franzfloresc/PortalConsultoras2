use BelcorpPeru 
go
alter procedure dbo.GetPaisByCodigoISO
@CodigoISO char(2)
as
/*
GetPaisByCodigoISO 'PE'
*/
begin

/*Existe Oferta final por Pais*/
declare @OfertaFinal int 
set @OfertaFinal = 0;

if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFT','OFC') and Estado = 1)
set @OfertaFinal = 1;

/*Existe Oferta Final Gana Mas*/
declare @OFGanaMas tinyint
set @OFGanaMas = 0
if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFTGM') and Estado = 1)
set @OFGanaMas = 1

select PaisID, Nombre, Simbolo, OfertaFinal = @OfertaFinal, OFGanaMas = @OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
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

	/*Existe Oferta final por Pais*/
	declare @OfertaFinal int 
	set @OfertaFinal = 0;

	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFT','OFC') and Estado = 1)
	set @OfertaFinal = 1;

	/*Existe Oferta Final Gana Mas*/
	declare @OFGanaMas tinyint
	set @OFGanaMas = 0
	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFTGM') and Estado = 1)
	set @OFGanaMas = 1

	select PaisID, Nombre, Simbolo, OfertaFinal = @OfertaFinal, OFGanaMas = @OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
	from dbo.Pais 
	where CodigoISO = @CodigoISO

end


GO

GO

use BelcorpMexico
go
alter procedure dbo.GetPaisByCodigoISO
@CodigoISO char(2)
as
/*
GetPaisByCodigoISO 'PE'
*/
begin
	/*Existe Oferta final por Pais*/
	declare @OfertaFinal int 
	set @OfertaFinal = 0;

	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFT','OFC') and Estado = 1)
	set @OfertaFinal = 1;

	/*Existe Oferta Final Gana Mas*/
	declare @OFGanaMas tinyint
	set @OFGanaMas = 0
	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFTGM') and Estado = 1)
	set @OFGanaMas = 1

select PaisID, Nombre, Simbolo, OfertaFinal = @OfertaFinal, OFGanaMas = @OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
from dbo.Pais 
where CodigoISO = @CodigoISO

end


GO
use BelcorpChile
go

alter procedure dbo.GetPaisByCodigoISO
@CodigoISO char(2)
as
/*
GetPaisByCodigoISO 'PE'
*/
begin
	/*Existe Oferta final por Pais*/
	declare @OfertaFinal int 
	set @OfertaFinal = 0;

	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFC') and Estado = 1)
	set @OfertaFinal = 1;

	/*Existe Oferta Final Gana Mas*/
	declare @OFGanaMas tinyint
	set @OFGanaMas = 0
	if exists(select 1 from dbo.fnConfiguracionPais_GetAll('','','','','') where Codigo in ('OFCGM') and Estado = 1)
	set @OFGanaMas = 1
select PaisID, Nombre, Simbolo, OfertaFinal = @OfertaFinal, OFGanaMas = @OFGanaMas, HoraCierreZonaNormal, HoraCierreZonaDemAnti 
from dbo.Pais 
where CodigoISO = @CodigoISO

end


GO
