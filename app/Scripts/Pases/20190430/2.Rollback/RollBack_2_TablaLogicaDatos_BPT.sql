GO
USE BelcorpPeru
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpMexico
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpColombia
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpSalvador
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpPuertoRico
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpPanama
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpGuatemala
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpEcuador
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpDominicana
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpCostaRica
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpChile
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
USE BelcorpBolivia
GO

go

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaEnriquecida'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = 158
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaEnriquecida'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaEnriquecida'
end

go



GO
