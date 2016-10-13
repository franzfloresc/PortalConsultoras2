
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
	
	if @ExisteRegistro > 0
	begin
			select @CodigoRegionx = isnull(CodigoRegion, '')
				, @CodigoZonax = isnull(CodigoZona, '')
			from ods.ConfiguracionProgramaNuevasUA
			where codigoprograma = @CodigoPrograma
				and CodigoRegion = @CodigoRegion
				--and (CodigoZona = @CodigoZona or CodigoZona is null)
	end

	if @ExisteRegistro = 0
		set @add = 1
	else if @CodigoRegionx != '' or  @CodigoZonax != ''
		set @add = 1
	else
		set @add = 0
		
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