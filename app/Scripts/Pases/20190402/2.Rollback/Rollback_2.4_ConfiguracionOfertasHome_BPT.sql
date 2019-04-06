GO
USE BelcorpPeru
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpMexico
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpColombia
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpSalvador
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpPuertoRico
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpPanama
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpGuatemala
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpEcuador
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpDominicana
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpCostaRica
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpChile
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
USE BelcorpBolivia
GO

GO

print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID in (
		select cp.ConfiguracionPaisID
		from [dbo].[ConfiguracionPais] cp
		where cp.Codigo = @Codigo
	)
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go


GO
