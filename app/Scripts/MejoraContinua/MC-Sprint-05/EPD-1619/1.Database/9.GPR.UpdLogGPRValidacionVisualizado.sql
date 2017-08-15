USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacionVisualizado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacionVisualizado]
GO


CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@ProcesoValidacionPedidoRechazadoID BIGINT
AS

BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID;

END


GO

