USE BelcorpPeru
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpMexico
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpColombia
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpVenezuela
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpSalvador
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpPuertoRico
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpPanama
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpGuatemala
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpEcuador
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpDominicana
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpCostaRica
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpChile
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

USE BelcorpBolivia
GO

GO
DECLARE @ConfiPaisId int = 0

select @ConfiPaisId = ConfiguracionPaisID
from  ConfiguracionPais WHERE Codigo = 'HV'

if @ConfiPaisId > 0
begin
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiPaisId
	DELETE FROM ConfiguracionPais WHERE ConfiguracionPaisID = @ConfiPaisId
end

GO
IF EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	delete from TipoEstrategia WHERE Codigo = '011'
END
GO

