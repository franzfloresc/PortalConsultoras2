GO
USE BelcorpPeru_GANAMAS
GO

print db_name()

declare @tabla_logica_flag_funcional smallint = 158
declare @flag_codigo varchar(150) = 'Promociones'

if exists(		select 1
				from tablalogicadatos
				where tablalogicaid = @tabla_logica_flag_funcional
				and codigo = @flag_codigo)

begin
	delete tld
	from tablalogicadatos tld
	where tld.tablalogicaid = @tabla_logica_flag_funcional
	and tld.codigo = @flag_codigo
end