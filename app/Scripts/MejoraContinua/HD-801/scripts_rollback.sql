USE BelcorpColombia
go

if exists(select 1 from Permiso where Descripcion = 'Mis certificados')
begin

	declare @PermisoID int = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Mis certificados'

	delete from RolPermiso where PermisoID = @PermisoID
	delete from Permiso where PermisoID = @PermisoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TieneCampaniaConsecutivas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].TieneCampaniaConsecutivas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPromedioVentaCampaniaConsecutivas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPromedioVentaCampaniaConsecutivas
GO