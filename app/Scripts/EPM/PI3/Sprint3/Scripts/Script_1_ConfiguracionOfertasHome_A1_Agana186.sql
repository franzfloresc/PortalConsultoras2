
--AGANA-186

GO
USE BelcorpPeru_BPT
GO

print db_name()

GO

print 'Inicio de creación de columnas'

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorTitulos' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add ColorTitulos varchar(10) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'TextoBotonInicial' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add TextoBotonInicial varchar(100) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'TextoBotonFinal' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add TextoBotonFinal varchar(100) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorBoton' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add ColorBoton varchar(10) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'ColorMensajeBoton' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add ColorMensajeBoton varchar(10) null
end

GO

print 'Fin de inserción de columnas: Color de títulos, Texto botón inicial, Texto botón final, Color del botón, Color mensaje botón'

