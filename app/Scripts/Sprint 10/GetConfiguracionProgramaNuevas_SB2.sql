
CREATE PROCEDURE [dbo].GetConfiguracionProgramaNuevas_SB2
(
	@Campania varchar(50)
)
AS
BEGIN
	select 
		CodigoPrograma
		,CampaniaInicio
		,CampaniaFin
		,IndExigVent
		,IndProgObli
		,CuponKit
		,CUVKit
	from  ods.configuracionProgramaNuevas
	where CampanaCarga = @Campania

END


go