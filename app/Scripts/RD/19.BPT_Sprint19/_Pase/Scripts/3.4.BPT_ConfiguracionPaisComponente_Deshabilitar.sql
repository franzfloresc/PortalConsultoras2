USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisComponente_Deshabilitar]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ConfiguracionPaisComponente_Deshabilitar]
GO

CREATE PROCEDURE dbo.ConfiguracionPaisComponente_Deshabilitar
	 @ConfiguracionPaisID int
	,@CampaniaID int
	,@Componente varchar(100)
AS
BEGIN

	SET @ConfiguracionPaisID = ISNULL(@ConfiguracionPaisID, 0)
	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @Componente = LTRIM(RTRIM(ISNULL(@Componente, '')))

	if @ConfiguracionPaisID > 0 and @CampaniaID >= 0 and @Componente <> ''
	begin
			update ConfiguracionPaisDatos
			set Estado = 0
			where ConfiguracionPaisID = @ConfiguracionPaisID
				and CampaniaID = @CampaniaID
				and Componente = @Componente
	end

END
GO
