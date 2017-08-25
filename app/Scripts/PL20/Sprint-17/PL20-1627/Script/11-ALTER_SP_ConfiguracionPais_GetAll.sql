use BelcorpPeru
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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
use BelcorpColombia
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go 
Use BelcorpMexico
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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
Use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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
go
use BelcorpBolivia
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpEcuador
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpCostaRica
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpDominicana
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpGuatemala
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpPanama
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpPuertoRico
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpSalvador
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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

go
use BelcorpVenezuela
go
if exists(select 1 from sysobjects where name = 'ConfiguracionPais_GetAll' and xtype = 'p')
drop procedure ConfiguracionPais_GetAll
go
CREATE PROCEDURE [dbo].[ConfiguracionPais_GetAll]
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
go

