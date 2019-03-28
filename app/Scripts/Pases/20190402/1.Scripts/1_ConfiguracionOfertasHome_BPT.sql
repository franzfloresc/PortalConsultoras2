GO
USE BelcorpPeru
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpMexico
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpColombia
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpSalvador
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpPuertoRico
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpPanama
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpGuatemala
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpEcuador
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpDominicana
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpCostaRica
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpChile
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
USE BelcorpBolivia
GO

GO

print db_name()

GO

print 'Inicio de creaci�n de columnas'

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

print 'Fin de inserci�n de columnas: Color de t�tulos, Texto bot�n inicial, Texto bot�n final, Color del bot�n, Color mensaje bot�n'

go



GO
