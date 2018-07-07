GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas_SB2') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas_SB2
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas_SB2
(
	@Campania varchar(50)
	,@CodigoRegion varchar(50)
	,@CodigoZona varchar(50)
)
AS
BEGIN
	
	declare @CodigoRegionx varchar(50) = ''
	,@CodigoZonax varchar(50) = ''
	,@ExisteRegistro int = 0
	,@CodigoPrograma varchar(50) = ''
	, @add bit = 1

	
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where CodigoRegion = @CodigoRegion
	

	if @ExisteRegistro > 0
	begin
			--set @add = 0
			set @CodigoPrograma = ''

			select @CodigoPrograma = isnull(c.CodigoPrograma, '')
			from  ods.configuracionProgramaNuevas c
				inner join ods.ConfiguracionProgramaNuevasUA cua 
					on cua.CodigoPrograma = c.CodigoPrograma
			where cua.CodigoRegion = @CodigoRegion
				and c.CampanaCarga = @Campania

			set @CodigoPrograma = LTRIM(RTRIM(isnull(@CodigoPrograma, '')))

			if @CodigoPrograma != ''
			begin
					--set @add = 1
					set @CodigoZonax = ''
			
					select @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						--and CodigoZona = @CodigoZona

					set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))

					if @CodigoZonax != ''
					begin
					
						set @add = 0
						set @CodigoZonax = ''
			
						select @CodigoZonax = isnull(CodigoZona, '')
						from ods.ConfiguracionProgramaNuevasUA
						where codigoprograma = @CodigoPrograma
							and CodigoRegion = @CodigoRegion
							and CodigoZona = @CodigoZona

						set @CodigoZonax = LTRIM(RTRIM(isnull(@CodigoZonax, '')))
						if @CodigoZonax != ''
							set @add = 1
						
					end

			end

	end

	
	if @add = 1
	begin

			select 
					 CodigoPrograma
					,CampaniaInicio
					,CampaniaFin
					,IndExigVent
					,IndProgObli
					,CuponKit
					,CUVKit
					, @CodigoRegionx as CodigoRegion
					, @CodigoZonax as CodigoZona
			from  ods.configuracionProgramaNuevas
			where CampanaCarga = @Campania
				and (CodigoPrograma = @CodigoPrograma or @CodigoPrograma = '')

	end

END
GO