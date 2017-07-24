use BelcorpPeru
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@PedidoId int,
@CampaniaId int 
As
Begin
	Select 
		pe.PedidoId,
		pe.CampaniaId,
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from PedidoWeb pe with (nolock)
		inner join ods.Consultora co with (nolock) on pe.ConsultoraId = co.ConsultoraId
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		pe.PedidoId = @PedidoId And pe.CampaniaId = @CampaniaId 
End