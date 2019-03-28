GO
USE BelcorpPeru
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpMexico
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpColombia
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpSalvador
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpPuertoRico
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpPanama
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpGuatemala
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpEcuador
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpDominicana
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpCostaRica
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpChile
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
USE BelcorpBolivia
GO
GO

print db_name()

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if not exists (	select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	declare @Descripcion varchar(250) = 'Banner interativo'
	declare @TablaLogicaDatosID smallint

	select @TablaLogicaDatosID = max(TablaLogicaDatosID)+1 from TablaLogicaDatos tld where tld.TablaLogicaID =  @TablaLogicaID

	print 'insert into TablaLogicaDatos : 10 - Banner interativo'

	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,	Codigo,	Descripcion)
	values( @TablaLogicaDatosID,@TablaLogicaID,'10',@Descripcion)

	print 'fin insert TablaLogicaDatos'
end

go


GO
