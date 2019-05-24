use BelcorpPeru_bpt
go

--use BelcorpChile_bpt
--go

--use BelcorpCostaRica_bpt
--go

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
	,'0'
	)
	print 'end of inserting into TablaLogicaDatos : FichaEnriquecida'
end

