USE BelcorpPeru
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpMexico
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpColombia
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpVenezuela
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpSalvador
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpPuertoRico
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpPanama
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpGuatemala
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpEcuador
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpDominicana
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpCostaRica
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpChile
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

USE BelcorpBolivia
GO

go
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ListConfiguracionPaisDatos') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.ListConfiguracionPaisDatos
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@Codigo varchar(100) = ''
	,@CodigoRegion varchar(100) = ''
	,@CodigoZona varchar(100) = ''
	,@CodigoSeccion varchar(100) = ''
	,@CodigoConsultora varchar(100) = ''
AS
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)

	if @ConfiguracionPaisID > 0
	begin
		SELECT @Codigo = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID
	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado 
	FROM ConfiguracionPaisDatos D
		INNER JOIN  (
				select
				c.ConfiguracionPaisID
				from dbo.fnConfiguracionPais_GetAll(
				@Codigo,
				@CodigoRegion,
				@CodigoZona,
				@CodigoSeccion,
				@CodigoConsultora
				) as c
				WHERE (C.DesdeCampania <= @CampaniaID OR @CampaniaID = 0)
		) P
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where D.Estado = 1

END

go

