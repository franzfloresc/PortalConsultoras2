
GO
USE BelcorpPeru_BPT
GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorTitulos' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column ColorTitulos
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'TextoBotonInicial' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column TextoBotonInicial
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'TextoBotonFinal' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column TextoBotonFinal
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorBoton' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column ColorBoton
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorMensajeBoton' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column ColorMensajeBoton
end

GO

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

