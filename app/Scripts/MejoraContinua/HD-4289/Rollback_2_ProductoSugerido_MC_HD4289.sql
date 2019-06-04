USE BelcorpPeru
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpMexico
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpColombia
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpSalvador
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpPuertoRico
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpPanama
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpGuatemala
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpEcuador
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpDominicana
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpCostaRica
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpChile
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
USE BelcorpBolivia
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido drop column ConfiguracionZona
end


GO
