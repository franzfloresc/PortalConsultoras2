
GO

print db_name()

GO

print 'Inicio de eliminacio de columnas'

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonTexto1' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column BotonTexto1
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonTexto2' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column BotonTexto2
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonColor' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column BotonColor
end

GO

if exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonColorTexto' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] drop column BotonColorTexto
end

GO

print 'Fin de eliminacion de columnas: Color de titulos, Texto boton inicial, Texto boton final, Color del boton, Color mensaje boton'

GO

