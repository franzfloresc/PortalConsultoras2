
--AGANA-186

GO
USE BelcorpPeru_BPT
GO

print db_name()

declare @Codigo varchar(100) = 'ATP'
declare @DesdeCampania int = 0

-- Verificar si existe la configuracion con Codigo ATP
if exists (select 1 
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo and coh.CampaniaID = @DesdeCampania)
begin
	declare @ConfiguracionPaisID int

	select 
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo 
	and cp.DesdeCampania = @DesdeCampania

	print 'Empieza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	delete from [dbo].[ConfiguracionOfertasHome]  where ConfiguracionPaisID = @ConfiguracionPaisID and CampaniaID = @DesdeCampania
end
else
begin
	print 'El registro en configuracion pais con Codigo ATP NO EXISTE'
end

print 'Finaliza delete  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

go
