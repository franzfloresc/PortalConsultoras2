USE BelcorpPeru
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpMexico
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpColombia
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpSalvador
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpPuertoRico
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpPanama
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpGuatemala
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpEcuador
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpDominicana
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpCostaRica
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpChile
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

USE BelcorpBolivia
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO

