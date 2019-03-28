GO
USE BelcorpPeru
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpMexico
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpColombia
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpSalvador
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpPuertoRico
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpPanama
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpGuatemala
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpEcuador
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpDominicana
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpCostaRica
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpChile
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
USE BelcorpBolivia
GO

GO

print db_name()

GO

print 'Inicio de eliminaci� de columnas'

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

print 'Fin de eliminaci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

GO



GO
