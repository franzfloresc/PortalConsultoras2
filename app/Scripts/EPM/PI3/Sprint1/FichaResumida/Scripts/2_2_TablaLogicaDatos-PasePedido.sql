use BelcorpCostaRica_BPT
go

print db_name()

declare @TablaLogicaId int = 157
declare @Codigo varchar(30) = 'CuvEditable'
--

if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

	if not exists (	select 1
					from TablaLogicaDatos tl
					where tl.Codigo = @Codigo)
	begin
	
			declare @Descripcion varchar(30) = 'cuv editable en pase pedido'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = TablaLogicaDatosId 
			from TablaLogicaDatos 
			where TablaLogicaId = @TablaLogicaId

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert' + @Descripcion

			insert into TablaLogicaDatos(
			TablaLogicaDatosID
			,TablaLogicaID
			,Codigo
			,Descripcion
			,Valor
			)
			values
			(
			@TablaLogicaDatosId
			,@TablaLogicaId
			,@Codigo
			,'cuv editable en pase pedido = 0 : Habilitar, 1: Deshabilitar'
			,'1'
			)

	end
end

