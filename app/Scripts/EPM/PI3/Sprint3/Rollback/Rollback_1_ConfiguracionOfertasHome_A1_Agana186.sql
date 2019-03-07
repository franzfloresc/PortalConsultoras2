
GO
USE BelcorpPeru_BPT
GO

print db_name()

GO

print 'Inicio de eliminació de columnas'

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

print 'Fin de eliminación de columnas: Color de títulos, Texto botón inicial, Texto botón final, Color del botón, Color mensaje botón'

