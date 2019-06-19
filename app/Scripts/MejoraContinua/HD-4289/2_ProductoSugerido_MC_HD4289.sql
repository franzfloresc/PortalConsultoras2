USE BelcorpPeru
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpMexico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpColombia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpSalvador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpPuertoRico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpPanama
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpGuatemala
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpEcuador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpDominicana
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpCostaRica
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpChile
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
USE BelcorpBolivia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
	alter table ProductoSugerido add ConfiguracionZona varchar(max)
end
go
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'ProductoSugerido' and column_name = 'ConfiguracionZona')
begin
    declare @aux varchar(max)=(select  Codigo+',' from ods.zona where EstadoActivo=1 for xml path (''))
	update ProductoSugerido set ConfiguracionZona=LEFT(@aux,LEN(@aux)-1)
end


GO
