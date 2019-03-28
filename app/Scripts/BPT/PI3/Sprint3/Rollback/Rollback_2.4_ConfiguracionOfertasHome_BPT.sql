
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
