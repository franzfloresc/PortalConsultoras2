USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaExitosa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaExitosa]
AS
BEGIN
	DECLARE @FechaProceso DATETIME
	DECLARE @FechaEnvio DATETIME

	SELECT @FechaProceso = MAX(fechaproceso) FROM pedidoweb WHERE indicadorenviado = 1 
	SELECT @FechaEnvio = MAX(fechaenvio) FROM pedidodd WHERE indicadorenviado = 1

	SELECT @FechaProceso AS FechaProceso, @FechaEnvio AS FechaEnvio
END

GO

