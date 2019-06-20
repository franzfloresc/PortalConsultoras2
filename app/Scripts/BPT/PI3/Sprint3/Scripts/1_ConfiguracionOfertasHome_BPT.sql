
GO

print db_name()

GO

print 'Inicio de creacion de columnas'

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonTexto1' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add BotonTexto1 varchar(100) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonTexto2' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add BotonTexto2 varchar(100) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonColor' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add BotonColor varchar(10) null
end

GO

if not exists(
	select 1 from INFORMATION_SCHEMA.COLUMNS
	where column_name = 'BotonColorTexto' and table_name = 'ConfiguracionOfertasHome'
)begin
	alter table [dbo].[ConfiguracionOfertasHome] add BotonColorTexto varchar(10) null
end

GO

print 'Fin de insercion de columnas: Color de titulos, Texto boton inicial, Texto boton final, Color del boton, Color mensaje boton'

go

