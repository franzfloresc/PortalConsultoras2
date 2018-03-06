USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListConfiguracionPaisComponenteDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListConfiguracionPaisComponenteDatos]
GO

CREATE PROCEDURE dbo.ListConfiguracionPaisComponenteDatos
	@ConfiguracionPaisID int = 0
	,@CampaniaID int = 0
	,@PalancaCodigo varchar(100) = ''
	,@Componente varchar(100) = ''
AS
-- ListConfiguracionPaisComponenteDatos 0, 0, 'RD', 'Popup_Club_Gana+'
BEGIN
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @PalancaCodigo = LTRIM(RTRIM(ISNULL(@PalancaCodigo, '')))
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0
	begin
		declare @aux varchar(100) = ''
		SELECT @aux = Codigo
		FROM ConfiguracionPais
		WHERE ConfiguracionPaisID = @ConfiguracionPaisID

		if  @aux <> ''
			set @PalancaCodigo = @aux

	end

	SELECT 
		  D.ConfiguracionPaisID
		, D.Codigo
		, D.CampaniaID
		, D.Componente
		, D.Valor1
		, D.Valor2
		, D.Valor3
		, D.Descripcion
		, D.Estado
	FROM ConfiguracionPaisDatos D
		INNER JOIN ConfiguracionPais P 
			ON P.ConfiguracionPaisID = D.ConfiguracionPaisID
	where (D.CampaniaID = @CampaniaID or @CampaniaID < 0)
		AND (P.Codigo = @PalancaCodigo OR @PalancaCodigo = '')
		AND (D.Componente = @Componente OR @Componente = '')

END
GO
