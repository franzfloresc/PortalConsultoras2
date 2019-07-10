GO
USE BelcorpPeru
GO
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

GO
USE BelcorpMexico
GO
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

GO
USE BelcorpColombia
GO
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

GO
USE BelcorpSalvador
GO
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

GO
USE BelcorpPuertoRico
GO
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

GO
USE BelcorpPanama
GO
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

GO
USE BelcorpGuatemala
GO
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

GO
USE BelcorpEcuador
GO
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

GO
USE BelcorpDominicana
GO
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

GO
USE BelcorpCostaRica
GO
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

GO
USE BelcorpChile
GO
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

GO
USE BelcorpBolivia
GO
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

GO
