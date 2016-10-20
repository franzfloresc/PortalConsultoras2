
--sinonimo
go

IF EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[ConfiguracionProgramaNuevasUA]') AND (type = N'SN') )
	DROP SYNONYM [ods].[ConfiguracionProgramaNuevasUA]
GO

declare @PrefijoPais varchar(2), @cadenaSYNONYMConfiguracionProgramaNuevasUA varchar(1000)
select @PrefijoPais = PrefijoPais from pais where EstadoActivo = 1
set @cadenaSYNONYMConfiguracionProgramaNuevasUA = 'CREATE SYNONYM ods.ConfiguracionProgramaNuevasUA FOR ODS_'+@PrefijoPais+'.dbo.ConfiguracionProgramaNuevasUA'
exec (@cadenaSYNONYMConfiguracionProgramaNuevasUA)

--CREATE SYNONYM [ods].[ConfiguracionProgramaNuevasUA] FOR [ODS_PE].[dbo].[ConfiguracionProgramaNuevasUA]
GO

go

IF EXISTS(
	SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetConfiguracionProgramaNuevas_SB2'
	AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetConfiguracionProgramaNuevas_SB2
END
GO

CREATE PROCEDURE [dbo].GetConfiguracionProgramaNuevas_SB2
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
	,@CodigoPrograma varchar(50)
	, @add bit = 0

	select @CodigoPrograma = CodigoPrograma
	from  ods.configuracionProgramaNuevas
	where CampanaCarga = @Campania
		
	select @ExisteRegistro = COUNT(1)
	from ods.ConfiguracionProgramaNuevasUA
	where codigoprograma = @CodigoPrograma
	
	set @add = 1
	if @ExisteRegistro > 0
	begin
			set @add = 0
			set @CodigoRegionx = ''
			set @CodigoZonax = ''

			select @CodigoRegionx = isnull(CodigoRegion, '')
				, @CodigoZonax = isnull(CodigoZona, '')
			from ods.ConfiguracionProgramaNuevasUA
			where codigoprograma = @CodigoPrograma
				and CodigoRegion = @CodigoRegion
				--and (CodigoZona = @CodigoZona or CodigoZona is null)

			if @CodigoRegionx != ''
			begin
			
				set @add = 1
				if @CodigoZonax != ''
				begin
					set @add = 0
					set @CodigoRegionx = ''
					set @CodigoZonax = ''
			
					select @CodigoRegionx = isnull(CodigoRegion, '')
						, @CodigoZonax = isnull(CodigoZona, '')
					from ods.ConfiguracionProgramaNuevasUA
					where codigoprograma = @CodigoPrograma
						and CodigoRegion = @CodigoRegion
						and CodigoZona = @CodigoZona
					
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
	end

END

go