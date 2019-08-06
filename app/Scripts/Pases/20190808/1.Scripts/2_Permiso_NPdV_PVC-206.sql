USE BelcorpPeru
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpMexico
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpColombia
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 1)
GO

USE BelcorpSalvador
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpPuertoRico
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpPanama
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpGuatemala
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpEcuador
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpDominicana
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 0)
GO

USE BelcorpCostaRica
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 1)
GO

USE BelcorpChile
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 1)
GO

USE BelcorpBolivia
GO

DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'montoexigencia')
delete from RolPermiso where PermisoID = @PermisoID
delete from Permiso where PermisoID = @PermisoID
GO
DECLARE @PermisoID int = (select max(PermisoID) from Permiso) + 1
insert into Permiso values (@PermisoID, 'Monto de Exigencia para Incentivos', 81, 111, 'CaminoBrillanteAdministrar/AdministrarMontoExigencia', 0, 'Header', NULL, 0, 0, 0, 0, 'montoexigencia')
insert into RolPermiso values (3, @PermisoID, 1, 1)
GO

