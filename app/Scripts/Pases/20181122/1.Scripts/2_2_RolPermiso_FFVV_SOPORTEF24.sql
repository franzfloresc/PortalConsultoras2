USE BelcorpBolivia
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpChile
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpColombia
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpCostaRica
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpDominicana
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpEcuador
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpGuatemala
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpMexico
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpPanama
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpPeru
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 1, 1)
	end
end
GO

USE BelcorpPuertoRico
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO

USE BelcorpSalvador
GO
declare @PermisoId int = (select PermisoId from permiso where urlitem = 'Unete/ExcepcionarDocumento');

if @PermisoId is not null
begin
	if not exists(select 1 from RolPermiso where RolId = 3 and PermisoId = @PermisoId)
	begin		
		insert into RolPermiso(RolID, PermisoID, Activo, Mostrar)
		values (3, @PermisoId, 0, 0)
	end
end
GO