USE BelcorpPeru
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpMexico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpColombia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpSalvador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpPuertoRico
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpPanama
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpGuatemala
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpEcuador
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpDominicana
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpCostaRica
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpChile
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
USE BelcorpBolivia
GO
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion add OpcionConfirmarEmail bit
end
if not exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion add OpcionConfirmarSms bit
end
go
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	update OpcionesVerificacion set OpcionConfirmarEmail=0
end
if  exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	update OpcionesVerificacion set OpcionConfirmarSms=0
end

GO
