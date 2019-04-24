USE BelcorpPeru
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpMexico
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpColombia
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpSalvador
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpPuertoRico
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpPanama
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpGuatemala
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpEcuador
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpDominicana
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpCostaRica
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpChile
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

USE BelcorpBolivia
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into Permiso values (@_PermisoID, 'Camino Brillante', 1003, 10, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
	Update Permiso set OrdenItem = 11 where PermisoID = 1021 and IdPadre = 1003 
	Update Permiso set OrdenItem = 12 where PermisoID = 1079 and IdPadre = 1003
	Update Permiso set OrdenItem = 13 where PermisoID = 1055 and IdPadre = 1003 
	Update Permiso set OrdenItem = 14 where PermisoID = 1006 and IdPadre = 1003 
end
GO

