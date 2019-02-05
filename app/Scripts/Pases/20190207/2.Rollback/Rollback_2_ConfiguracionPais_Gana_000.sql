USE BelcorpPeru
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpMexico
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpColombia
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpSalvador
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpPuertoRico
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpPanama
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpGuatemala
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpEcuador
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpDominicana
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpCostaRica
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpChile
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO

USE BelcorpBolivia
GO

declare @Codigo varchar(100) = 'MSPersonalizacion'

if exists (select 1 from ConfiguracionPais where Codigo = @Codigo)
begin
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = @Codigo)
	DELETE FROM ConfiguracionPais WHERE Codigo = @Codigo
end

GO



