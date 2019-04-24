USE BelcorpPeru_APP
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

USE BelcorpMexico_APP
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

USE BelcorpColombia_APP
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

USE BelcorpSalvador_APP
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

USE BelcorpPuertoRico_APP
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

USE BelcorpPanama_APP
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

USE BelcorpGuatemala_APP
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

USE BelcorpEcuador_APP
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

USE BelcorpDominicana_APP
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

USE BelcorpCostaRica_APP
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

USE BelcorpChile_APP
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

USE BelcorpBolivia_APP
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

