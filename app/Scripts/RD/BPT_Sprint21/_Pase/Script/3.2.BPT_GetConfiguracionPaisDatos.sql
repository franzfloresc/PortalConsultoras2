USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionPaisDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConfiguracionPaisDatos]
GO
CREATE PROCEDURE [dbo].[GetConfiguracionPaisDatos]
	@PalancaCodigo varchar(255),
	@CampaniaID int,
	@Codigo varchar(255)
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID
		,CPD.Codigo
		,CPD.CampaniaID
		,CPD.Valor1
		,CPD.Valor2
		,CPD.Valor3
		,CPD.Descripcion
		,CPD.Estado
		,CPD.Componente
	FROM ConfiguracionPaisDatos CPD
	INNER JOIN ConfiguracionPais CP ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.Codigo = @PalancaCodigo AND
		CPD.CampaniaID = @CampaniaID AND
		CPD.Codigo = @Codigo
END
GO

