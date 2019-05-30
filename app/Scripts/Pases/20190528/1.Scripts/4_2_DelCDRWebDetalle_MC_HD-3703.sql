USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.DelCDRWebDetalle @CDRWebDetalleID INT
	,@GrupoID VARCHAR(36) = NULL
AS
BEGIN
	IF @GrupoID IS NOT NULL
		AND @GrupoID <> ''
	BEGIN
		DELETE
		FROM dbo.CDRWebDetalle
		WHERE GrupoID = @GrupoID
	END
	ELSE
	BEGIN
		DELETE
		FROM CDRWebDetalle
		WHERE CDRWebDetalleID = @CDRWebDetalleID
	END
END
GO


