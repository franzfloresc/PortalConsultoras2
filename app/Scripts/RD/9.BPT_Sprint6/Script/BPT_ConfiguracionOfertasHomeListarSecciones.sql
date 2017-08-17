

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
-- ConfiguracionOfertasHomeListarSecciones 201713
BEGIN
	SET NOCOUNT ON;
	
	SELECT O.*, C.Codigo FROM ConfiguracionOfertasHome O
		inner join (
			SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
			FROM ConfiguracionOfertasHome 
			WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
			group by  ConfiguracionPaisID 
		) OC
		on O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
		LEFT JOIN ConfiguracionPais C
			ON C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where MobileActivo = 1 or DesktopActivo = 1

END

go
