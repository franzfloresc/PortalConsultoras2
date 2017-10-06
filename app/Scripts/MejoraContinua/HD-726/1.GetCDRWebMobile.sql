USE BelcorpPeru
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpMexico
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpColombia
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpPanama
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpChile
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select * from sys.objects where type = 'P' and name = 'GetCDRWebMobile')
BEGIN
	DROP PROCEDURE [dbo].[GetCDRWebMobile]
END
GO

CREATE PROCEDURE [dbo].[GetCDRWebMobile]
	@ConsultoraID BIGINT,
	@PedidoID INT = 0,
	@CampaniaID INT = 0,
	@CDRWebID INT = 0
AS
BEGIN
	SELECT top 20
		C.CDRWebID,
		C.PedidoID,
		C.PedidoNumero,
		C.CampaniaID,
		C.ConsultoraID,
		C.FechaRegistro,
		C.Estado,
		C.FechaCulminado,
		C.FechaAtencion,
		C.Importe,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 3) as CantidadAprobados,
		(select count(1) from CDRWebDetalle where CDRWebID = C.CDRWebID and Estado = 4) as CantidadRechazados,
		isnull(
			(SELECT TOP 1 ConsultoraSaldo 
			FROM [interfaces].[LogCDRWeb] 
			WHERE CDRWebId = C.CDRWebId AND Estado = 2
			ORDER BY FechaRegistro DESC)
		,0) AS ConsultoraSaldo,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC;
END
GO

