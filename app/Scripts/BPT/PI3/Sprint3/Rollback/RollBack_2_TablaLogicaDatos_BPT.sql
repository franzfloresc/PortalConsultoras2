
GO

print db_name()

GO

print 'Inicio de eliminacion de tabla logica datos codigo 10 - Banner interativo'

declare @TablaLogicaID int = 120
declare @Codigo varchar(150) = '10'

if exists (select 1
				from TablaLogicaDatos tld
				where tld.TablaLogicaID = @TablaLogicaID and tld.Codigo = @Codigo)
begin
	delete from [dbo].[TablaLogicaDatos] where TablaLogicaID = @TablaLogicaID and Codigo = @Codigo
end

GO

print 'Fin de eliminacion de tabla logica datos codigo 10 - Banner interativo'

go
