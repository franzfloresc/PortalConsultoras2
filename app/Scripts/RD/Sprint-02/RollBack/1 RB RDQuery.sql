go

delete from MenuMobile where Codigo = 'RevistaDigital'

go

declare @Aux int = 0

select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
delete from RolPermiso where PermisoID = @Aux
delete from Permiso where PermisoID = @Aux

go

delete FROM PopupPais where CodigoPopup = 9

go