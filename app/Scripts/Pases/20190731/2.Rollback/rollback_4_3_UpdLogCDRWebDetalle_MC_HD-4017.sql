USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO
	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO

USE BelcorpSalvador
GO
IF EXISTS(SELECT * FROM sys.procedures where name =N'UpdLogCDRWebDetalle')
 BEGIN
   DROP PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
 END
GO

IF EXISTS(SELECT * FROM sys.types where name = N'LogCDRWebDetalleType')
 BEGIN
  DROP TYPE [interfaces].[LogCDRWebDetalleType]
 END
GO


CREATE TYPE [interfaces].[LogCDRWebDetalleType] AS TABLE(
	[LogCDRWebDetalleId] [bigint] NOT NULL,
	[CDRWebDetalleId] [int] NOT NULL,
	[EstadoCDR] [int] NOT NULL,
	[CodigoRechazo] [varchar](10) NULL,
	[ObservacionRechazo] [varchar](100) NULL,
	[ExisteDetalleSicc] [bit] NOT NULL,
	[EstadoCDRSicc] [varchar](5) NULL,
	[ProcesoFallo] [bit] NOT NULL
)
GO

CREATE PROCEDURE [interfaces].[UpdLogCDRWebDetalle]
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		ExisteDetalleSicc = T.ExisteDetalleSicc,
		EstadoCDRSicc = T.EstadoCDRSicc,
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID AND T.ProcesoFallo = 0;
END
GO