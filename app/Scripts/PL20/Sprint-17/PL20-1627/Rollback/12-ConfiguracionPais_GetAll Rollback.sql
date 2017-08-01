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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO
use BelcorpMexico
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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO
use BelcorpChile
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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO

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
	
	SELECT c.ConfiguracionPaisID
		,c.Codigo
		,c.Excluyente
		,c.Descripcion
		,c.Estado
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

END

GO
