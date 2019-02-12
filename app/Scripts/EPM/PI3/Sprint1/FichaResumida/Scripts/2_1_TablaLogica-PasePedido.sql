use BelcorpCostaRica_BPT
go

print db_name()

declare @TablaLogicaId int = 157

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	declare @Descripcion varchar(30) = 'Pase Pedido'

	print 'insert into TablaLogica : 157 - ' + @Descripcion
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

