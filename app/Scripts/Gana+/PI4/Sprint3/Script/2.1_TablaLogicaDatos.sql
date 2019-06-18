use [BelcorpPeru_GANAMAS]
go

declare @idx int
declare @str varchar(max)
declare @strToFind varchar(max)


set @idx = 0
--
select @str = c.Valor1
from ConfiguracionPaisDatos c
where c.Codigo = 'EstrategiaDisponibleParaFicha'
--
set @strToFind = 'CAT'

SELECT @idx = CHARINDEX(@str, @strToFind)

IF @idx = 0
	BEGIN
	update c
	set c.Valor1 = c.Valor1 + ',CAT'
	from ConfiguracionPaisDatos c
	where c.Codigo = 'EstrategiaDisponibleParaFicha'
END


set @idx = 0
--
select @str = c.Valor1
from ConfiguracionPaisDatos c
where c.Codigo = 'EstrategiaDisponible'
--
set @strToFind = 'CAT'

SELECT @idx = CHARINDEX(@str, @strToFind)

IF @idx = 0
BEGIN
	update c
	set c.Valor1 = c.Valor1 + ',CAT'
	from ConfiguracionPaisDatos c
	where c.Codigo = 'EstrategiaDisponible'
END

go