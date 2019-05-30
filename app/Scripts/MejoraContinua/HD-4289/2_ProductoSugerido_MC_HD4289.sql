USE BelcorpPeru
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpMexico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpColombia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpSalvador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpPuertoRico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpPanama
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpGuatemala
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpEcuador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpDominicana
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpCostaRica
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpChile
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
USE BelcorpBolivia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	alter table ProductoSugerido add RegionID int
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	alter table ProductoSugerido add ZonaID int
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'RegionID')
begin
	update ProductoSugerido set RegionID=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ZonaID')
begin
	update ProductoSugerido set ZonaID=0
end

GO
