USE BelcorpPeru
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpMexico
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpColombia
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpSalvador
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpPuertoRico
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpPanama
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpGuatemala
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpEcuador
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 1)
end
GO

USE BelcorpDominicana
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 0)
end
GO

USE BelcorpCostaRica
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 1)
end
GO

USE BelcorpChile
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 1)
end
GO

USE BelcorpBolivia
GO

if not exists (select 1 from Permiso where Codigo = 'CaminoBrillante')
begin
	declare @_PermisoID int = (select max(PermisoID) from Permiso) + 1
	insert into permiso values (@_PermisoID, 'Camino Brillante', 1003, 12, 'CaminoBrillante/Index', 0, 'Header', NULL, 0, 0, 0, 1, 'CaminoBrillante')
	insert into RolPermiso values (1,@_PermisoID, 1, 1)
end
GO

