USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ConfiguracionPais_GetAll]
(
	@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
)
AS
BEGIN

	SET NOCOUNT ON;
	select
		ConfiguracionPaisID,
		Codigo,
		Excluyente,
		Descripcion,
		Estado
	from dbo.fnConfiguracionPais_GetAll(
		@Codigo,
		@CodigoRegion,
		@CodigoZona,
		@CodigoSeccion,
		@CodigoConsultora
	)

END

GO