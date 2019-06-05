USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
ALTER PROCEDURE [dbo].[GetCDRWeb]
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
