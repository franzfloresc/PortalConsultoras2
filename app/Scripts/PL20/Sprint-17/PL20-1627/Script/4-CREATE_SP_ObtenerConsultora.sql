use BelcorpPeru
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go

use BelcorpColombia
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End

go

use BelcorpMexico
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpBolivia
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpEcuador
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpCostaRica
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpDominicana
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpGuatemala
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpPanama
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpPuertoRico
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpSalvador
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
use BelcorpVenezuela
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
Create Procedure ObtenerConsultora
@ConsultoraId int
As
Begin
	Select 
		CodigoConsultora = co.Codigo,
		CodigoRegion = re.Codigo,
		CodigoZona = zo.Codigo,
		CodigoSeccion = se.Codigo
	from ods.Consultora co with (nolock)
		inner join ods.Region re with (nolock) on re.RegionId = co.RegionId
		inner join ods.Zona zo with (nolock) on zo.ZonaId = co.ZonaId
		inner join ods.Seccion se with (nolock) on se.SeccionId = co.SeccionId	
	Where 
		co.ConsultoraId = @ConsultoraId
End
go
