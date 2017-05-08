
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.UpdIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.UpdIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE UpdIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT,
	@IndicadorIPUsuario VARCHAR(30),
	@IndicadorFingerprint VARCHAR(50),
	@IndicadorToken VARCHAR(50)
)
AS
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM IndicadorPedidoAutentico 
		WHERE PedidoID = @PedidoID AND CampaniaID = @CampaniaID 
		AND PedidoDetalleID = @PedidoDetalleID)
	BEGIN
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END
	ELSE
	BEGIN
		UPDATE IndicadorPedidoAutentico
		SET IndicadorIPUsuario = @IndicadorIPUsuario,
			IndicadorFingerprint = @IndicadorFingerprint,
			IndicadorToken = @IndicadorToken,
			FechaModificacion = GETDATE()
		WHERE PedidoID = @PedidoID
		AND CampaniaID = @CampaniaID
		AND PedidoDetalleID = @PedidoDetalleID

		SELECT 1
	END
END
GO



