GO
USE BelcorpPeru
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpMexico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpColombia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpSalvador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpPuertoRico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpPanama
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpGuatemala
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpEcuador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpDominicana
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpCostaRica
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpChile
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
USE BelcorpBolivia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaEnriquecida'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values(
	@flag_id
	,@tabla_logica_flag_funcional
	,@flag_codigo
	,'Permite habilitar la funcionalidad de ficha enriquecida para desktop y mobile. 0 : Deshabilitar, 1: Habilitar'
	,'1'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end


GO
