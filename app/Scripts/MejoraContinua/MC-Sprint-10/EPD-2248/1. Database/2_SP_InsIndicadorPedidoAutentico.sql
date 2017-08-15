
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.InsIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE InsIndicadorPedidoAutentico
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
	BEGIN TRY
		INSERT INTO IndicadorPedidoAutentico
		(PedidoID,CampaniaID,PedidoDetalleID,IndicadorIPUsuario,IndicadorFingerprint,IndicadorToken,FechaCreacion)
		VALUES (@PedidoID,@CampaniaID,@PedidoDetalleID,@IndicadorIPUsuario,@IndicadorFingerprint,@IndicadorToken,GETDATE())

		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO

