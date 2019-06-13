GO
USE BelcorpPeru
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpMexico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpColombia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpSalvador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpPuertoRico
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpPanama
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpGuatemala
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpEcuador
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpDominicana
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpCostaRica
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpChile
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
USE BelcorpBolivia
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'FichaResponsive'

if not exists(	select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	declare @flag_id smallint = 0
	select @flag_id = max(tld.TablaLogicaDatosID) + 1
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional

	print 'inserting into TablaLogicaDatos : FichaResponsive'
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
	,'Permite habilitar la funcionalidad de ficha responsive. 0 : Deshabilitar, 1: Habilitar'
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaResponsive'
end


GO
