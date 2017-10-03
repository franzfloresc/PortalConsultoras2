USE BelcorpPeru
go

if exists (select * from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpMexico
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpColombia
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpVenezuela
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpSalvador
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpPuertoRico
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpPanama
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpGuatemala
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpEcuador
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpDominicana
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpCostaRica
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpChile
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go

USE BelcorpBolivia
GO

if exists (select 1 from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel'))
begin
	delete from TablaLogicaDatos where TablaLogicaID in 
				(select TablaLogicaID from TablaLogica where Descripcion='Tipo Presentacion Carrusel')
end

go

if exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

	delete from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel'

end

go

if exists (select 1 from Permiso where Descripcion = 'Configurar Palanca')
begin
	DECLARE @PermisoID INT = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Configurar Palanca'

	delete from RolPermiso where PermisoID=@PermisoID
	delete from Permiso where PermisoID=@PermisoID
end

go