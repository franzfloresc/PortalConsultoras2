GO
USE BelcorpPeru
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpMexico
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpColombia
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpSalvador
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpPuertoRico
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpPanama
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpGuatemala
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpEcuador
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpDominicana
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpCostaRica
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpChile
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
USE BelcorpBolivia
GO

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo se termina eliminar el registro en TablaLogicaDatos'

	print 'insert into TablaLogica : 158 - Flag Funcionales'
	insert into TablaLogica(
		TablaLogicaID
		,Descripcion
	)
	values
	(
		@TablaLogicaId
		,@Descripcion
	)

end



GO
