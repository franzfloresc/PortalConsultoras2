
GO
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
	IF(@Codigo IS NULL OR @Codigo = 'NULL') SET @Codigo = '';
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
		INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 1 AND (d.CodigoRegion != @CodigoRegion OR d.CodigoZona != @CodigoZona OR d.CodigoSeccion != @CodigoSeccion OR d.CodigoConsultora != @CodigoConsultora)	
	UNION 
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
	FROM ConfiguracionPais c
	INNER JOIN ConfiguracionPaisDetalle d ON c.ConfiguracionPaisID = d.ConfiguracionPaisID
	WHERE c.Estado = '1' AND d.Estado = '1' AND (@Codigo = '' OR c.Codigo = @Codigo)
		AND Excluyente = 0 AND (d.CodigoRegion = @CodigoRegion OR d.CodigoZona = @CodigoZona OR d.CodigoSeccion = @CodigoSeccion OR d.CodigoConsultora = @CodigoConsultora)
END

GO
