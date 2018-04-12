
create procedure dbo.ObtenerPagoEnLineaByFiltro
@CampaniaID int = 0,
@RegionID int = 0,
@ZonaID int = 0,
@CodigoConsultora varchar(20) = '',
@Estado varchar(10) = ''
as
/*
ObtenerPagoEnLineaByFiltro
ObtenerPagoEnLineaByFiltro 201802,0,0,'','-1'
*/
begin

set @CampaniaID = isnull(@CampaniaID,0)
set @RegionID = isnull(@RegionID,0)
set @ZonaID = isnull(@ZonaID,0)
set @CodigoConsultora = isnull(@CodigoConsultora,'')
set @Estado = isnull(@Estado,'')


select
pl.CampaniaId,
'SB VISA' as NombreComercio,
pl.IdUnicoTransaccion,	--IdPago
pl.PagoEnLineaResultadoLogId, --NroPago
c.PrimerNombre,
c.SegundoNombre,
c.PrimerApellido,
c.SegundoApellido,
pl.FechaCreacion,
pl.CodigoConsultora,
pl.NumeroDocumento,
'Internet' as Canal,
'' as Ciclo,
pl.ImporteAutorizado,
pl.MontoGastosAdministrativos,
0 as IVA,
pl.MontoPago,
'' as TicketId,
r.Codigo as CodigoRegion,
z.Codigo as CodigoZona,
pl.OrigenTarjeta,
pl.NumeroTarjeta,
pl.NumeroOrdenTienda,
pl.CodigoError,
pl.MensajeError
from PagoEnLineaResultadoLog pl
inner join ods.Consultora c on
	pl.ConsultoraId = c.ConsultoraID
inner join ods.Region r on
	c.RegionID = r.RegionID
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
where 
		case when @CampaniaID = 0 then 1
			when @CampaniaID = pl.CampaniaId then 1
			else 0 end = 1
	and
		case when @RegionID = 0 then 1
			when @RegionID = r.RegionID then 1
			else 0 end = 1
	and
		case when @ZonaID = 0 then 1
			when @ZonaID = z.ZonaID then 1
			else 0 end = 1
	and
		case when @CodigoConsultora = '' then 1
			when @CodigoConsultora = c.Codigo then 1
			else 0 end = 1
	and
		(	
			@Estado = ''
			or
			(@Estado = '0' and pl.CodigoError = @Estado) 
			or
			(@Estado = '-1' and pl.CodigoError != '0')
		)
order by FechaCreacion desc

end

