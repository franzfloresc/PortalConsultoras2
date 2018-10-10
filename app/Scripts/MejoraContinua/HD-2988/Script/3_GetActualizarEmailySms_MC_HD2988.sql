USE BelcorpPeru
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpMexico
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpColombia
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpSalvador
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpPuertoRico
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpPanama
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpGuatemala
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpEcuador
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpDominicana
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpCostaRica
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpChile
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

USE BelcorpBolivia
GO

if Exists (select 1 from sys.objects where type = 'P' and name = 'GetActualizarEmailySms')
begin
	drop procedure GetActualizarEmailySms
end
go
Create Procedure GetActualizarEmailySms
(
@CodigoUsuario varchar(20) = ''
)
as
Begin
	if not exists (select * from ValidacionDatos where CodigoUsuario = @CodigoUsuario)
		select '1' as TipoEnvio, '' as DatoNuevo
	Else
	Begin
		select TipoEnvio, DatoNuevo from ValidacionDatos where CodigoUsuario = @CodigoUsuario and TipoEnvio in ('Email','SMS') and Estado = 'P'
		order by FechaCreacion
	End 	
End
GO

