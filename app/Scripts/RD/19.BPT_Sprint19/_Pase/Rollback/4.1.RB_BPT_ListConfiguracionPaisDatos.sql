USE BelcorpPeru
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE dbo.ListConfiguracionPaisDatos
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
GO
