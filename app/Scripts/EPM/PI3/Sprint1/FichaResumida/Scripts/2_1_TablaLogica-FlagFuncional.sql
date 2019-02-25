use BelcorpPeru_BPT
go

print db_name()

declare @TablaLogicaId int = 158

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Flag Funcionales'

	set @Descripcion = @Descripcion + ', pasar a prd apagado en caso no esta terminado el desarrollo'
	set @Descripcion = @Descripcion + ', cuando el desarrollo este termina eliminar el registro en TablaLogicaDatos'

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

