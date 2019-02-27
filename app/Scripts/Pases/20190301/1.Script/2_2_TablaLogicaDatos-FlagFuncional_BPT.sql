GO
USE BelcorpPeru
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpMexico
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpColombia
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpSalvador
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpPuertoRico
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpPanama
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpGuatemala
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpEcuador
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpDominicana
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpCostaRica
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpChile
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
USE BelcorpBolivia
GO

print db_name()

declare @TablaLogicaId int = 158
declare @Codigo varchar(30) = 'MisClientes'


if exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId)
begin

		if not exists (	select 1
							from TablaLogicaDatos tl
							where tl.Codigo = @Codigo)
		begin

			declare @Descripcion varchar(30) = '0 : Deshabilitar, 1: Habilitar - Pantalla Responsive MisClientes y Funcionalidad de cliente en Ficha'
			declare @TablaLogicaDatosId int = 0

			select @TablaLogicaDatosId = max(TablaLogicaDatosId)
			from TablaLogicaDatos
			where TablaLogicaId = @TablaLogicaId

			set @TablaLogicaDatosId = isnull(@TablaLogicaDatosId, 0)

			if @TablaLogicaDatosId = 0
				set @TablaLogicaDatosId = @TablaLogicaId * 100

			set @TablaLogicaDatosId = @TablaLogicaDatosId + 1

			print 'insert ' + @Descripcion

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
				,@Descripcion
				,'1'
			)
		end

end



GO
