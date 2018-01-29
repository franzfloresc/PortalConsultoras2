USE BelcorpPeru
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpMexico
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpColombia
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpVenezuela
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpSalvador
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpPuertoRico
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpPanama
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpGuatemala
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpEcuador
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpDominicana
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpCostaRica
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpChile
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

USE BelcorpBolivia
GO

go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID
end

go

