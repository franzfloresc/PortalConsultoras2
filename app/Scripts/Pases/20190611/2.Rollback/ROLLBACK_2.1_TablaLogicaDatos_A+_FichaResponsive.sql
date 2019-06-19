GO
USE BelcorpPeru
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpMexico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpColombia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpSalvador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpPuertoRico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpPanama
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpGuatemala
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpEcuador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpDominicana
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpCostaRica
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpChile
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
USE BelcorpBolivia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	--
	select @flag_id = tld.TablaLogicaDatosID
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo

	print 'rollback inserting into TablaLogicaDatos : FichaResponsive'
	delete
	from tablalogicadatos
	where tablalogicaid = @tabla_logica_flag_funcional
	and TablaLogicaDatosID = @flag_id
	print 'end of rollback inserting into TablaLogicaDatos : FichaResponsive'
end



GO
