USE BelcorpPeru
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpMexico
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpColombia
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpSalvador
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpPuertoRico
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpPanama
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpGuatemala
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpEcuador
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpDominicana
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpCostaRica
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpChile
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
USE BelcorpBolivia
GO

if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarEmail')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarEmail
end
GO
if exists(select column_name from INFORMATION_SCHEMA.columns where table_name = 'OpcionesVerificacion' and column_name = 'OpcionConfirmarSms')
begin
	alter table OpcionesVerificacion drop column OpcionConfirmarSms
end

GO
