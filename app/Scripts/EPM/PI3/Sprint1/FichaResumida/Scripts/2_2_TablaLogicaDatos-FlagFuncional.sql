use BelcorpPeru_BPT
go

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes' 
declare @TablaLogicaDescripcion_FeatureFlags varchar(30) = 'Pantallas Responsive'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = 'Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
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
			,'0 : Deshabilitar, 1: Habilitar'
			,'1'
			)
		end

end

