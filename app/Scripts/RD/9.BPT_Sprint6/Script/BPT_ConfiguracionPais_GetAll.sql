ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	select
		
		c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
		,C.TienePerfil
		,C.DesdeCampania
		,C.MobileTituloMenu
		,C.DesktopTituloMenu
		,C.Logo
		,C.Orden
		,C.DesktopTituloBanner
		,C.MobileTituloBanner
		,C.DesktopSubTituloBanner
		,C.MobileSubTituloBanner
		,C.DesktopFondoBanner
		,C.MobileFondoBanner
		,C.DesktopLogoBanner
		,C.MobileLogoBanner
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	) as c

END


