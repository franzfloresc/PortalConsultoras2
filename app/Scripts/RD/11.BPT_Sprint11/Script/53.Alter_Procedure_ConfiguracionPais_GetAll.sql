USE [BelcorpPeru_BPT]
GO

DROP PROCEDURE [dbo].[ConfiguracionPais_GetAll]
GO

CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
@DesdeCampania int = 0
,@Codigo varchar(100) = ''
,@CodigoRegionvarchar(100) = ''
,@CodigoZonavarchar(100) = ''
,@CodigoSeccionvarchar(100) = ''
,@CodigoConsultoravarchar(100) = ''
)
AS
/*
dbo.ConfiguracionPais_GetAll 0,'','','','',''
*/
BEGIN
SET NOCOUNT ON;

SET @DesdeCampania = ISNULL(@DesdeCampania, 0)

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
,C.UrlMenu
,C.OrdenBpt
,C.BloqueoRevistaImpresa
from dbo.fnConfiguracionPais_GetAll(
@Codigo,
@CodigoRegion,
@CodigoZona,
@CodigoSeccion,
@CodigoConsultora
) as c
WHERE C.DesdeCampania <= @DesdeCampania OR @DesdeCampania = 0

END


GO


