GO
ALTER function fnConfiguracionPais_GetAll
(
	@Codigo varchar(100) = ''
	,@CodigoRegion  varchar(100) = ''
	,@CodigoZona  varchar(100) = ''
	,@CodigoSeccion  varchar(100) = ''
	,@CodigoConsultora  varchar(100) = ''
)
returns @tabla table
(
  ConfiguracionPaisID	int
, Codigo	varchar(100)
, Excluyente	bit
, Descripcion	varchar(1000)
, Estado	bit
, TienePerfil	bit
, DesdeCampania	int
, MobileTituloMenu	varchar(255)
, DesktopTituloMenu	varchar(255)
, Logo	varchar(255)
, Orden	int
, DesktopTituloBanner	varchar(255)
, MobileTituloBanner	varchar(255)
, DesktopSubTituloBanner varchar(255)
, MobileSubTituloBanner	varchar(255)
, DesktopFondoBanner	varchar(255)
, MobileFondoBanner	varchar(255)
, DesktopLogoBanner	varchar(255)
, MobileLogoBanner	varchar(255)
, UrlMenu	varchar(255)
)
begin
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	IF(@CodigoRegion IS NULL OR @CodigoRegion = 'NULL') SET @CodigoRegion = '';
	IF(@CodigoZona IS NULL OR @CodigoZona = 'NULL') SET @CodigoZona = '';
	IF(@CodigoSeccion IS NULL OR @CodigoSeccion = 'NULL') SET @CodigoSeccion = '';
	IF(@CodigoConsultora IS NULL OR @CodigoConsultora = 'NULL') SET @CodigoConsultora = '';

	
	DECLARE @tablaDetalle table (
		ConfiguracionPaisDetalleID int
		,ConfiguracionPaisID int
		, CodigoRegion varchar(2)
		, CodigoZona varchar(4)
		, CodigoSeccion varchar(8)
		, CodigoConsultora varchar(20)
	)
	insert into @tablaDetalle
	select DD.ConfiguracionPaisDetalleID
		, DD.ConfiguracionPaisID
		, DD.CodigoRegion
		, DD.CodigoZona
		, DD.CodigoSeccion
		, DD.CodigoConsultora
	FROM (
			SELECT ConfiguracionPaisDetalleID ,ConfiguracionPaisID
				,case when isnull(d.CodigoRegion, '') = '' then @CodigoRegion else d.CodigoRegion end as CodigoRegion
				,case when isnull(d.CodigoZona, '') = '' then @CodigoZona else d.CodigoZona end as CodigoZona
				,case when isnull(d.CodigoSeccion, '') = '' then @CodigoSeccion else d.CodigoSeccion end as CodigoSeccion
				,case when isnull(d.CodigoConsultora, '') = '' then @CodigoConsultora else d.CodigoConsultora end as CodigoConsultora
			FROM ConfiguracionPaisDetalle d 
			WHERE d.Estado = 1 
				AND (
					(d.CodigoRegion = @CodigoRegion and @CodigoRegion != '') 
					OR ( d.CodigoZona = @CodigoZona and  @CodigoZona != '')
					OR ( d.CodigoSeccion = @CodigoSeccion and  @CodigoSeccion != '')
					OR ( d.CodigoConsultora = @CodigoConsultora and  @CodigoConsultora != '')
				)
		) AS DD
	WHERE DD.CodigoRegion = @CodigoRegion
		and DD.CodigoZona = @CodigoZona
		and DD.CodigoSeccion = @CodigoSeccion
		and DD.CodigoConsultora = @CodigoConsultora
	
	insert @tabla(ConfiguracionPaisID
		,Codigo
		,Excluyente
		,Descripcion
		,Estado
		,TienePerfil
		,DesdeCampania
		,MobileTituloMenu
		,DesktopTituloMenu
		,Logo
		,Orden
		,DesktopTituloBanner
		,MobileTituloBanner
		,DesktopSubTituloBanner
		,MobileSubTituloBanner
		,DesktopFondoBanner
		,MobileFondoBanner
		,DesktopLogoBanner
		,MobileLogoBanner
		,UrlMenu)
	SELECT c.ConfiguracionPaisID
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
	FROM ConfiguracionPais c
	WHERE c.Estado = 1 
		AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND ( 
			(
				C.Excluyente = 1 -- EXCLUYENTE 
				AND C.ConfiguracionPaisID NOT IN (select ConfiguracionPaisID from @tablaDetalle d where d.ConfiguracionPaisID = c.ConfiguracionPaisID)
			) OR (
				C.Excluyente = 0 -- INCLUYENTE
				AND C.ConfiguracionPaisID IN (select ConfiguracionPaisID from @tablaDetalle d where d.ConfiguracionPaisID = c.ConfiguracionPaisID)
			)
		)	

	return 
end

GO