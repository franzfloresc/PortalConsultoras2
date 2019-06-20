USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActualizaDatoRecogerPor') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.ActualizaDatoRecogerPor
GO

CREATE PROC	dbo.ActualizaDatoRecogerPor
 @PedidoID int,
 @Documento VARCHAR(50),
 @RecogerNombre VARCHAR(150)
AS
BEGIN
	UPDATE dbo.PedidoWeb
	SET RecogerDNI=@Documento,
		RecogerNombre=@RecogerNombre
	WHERE PedidoID=@PedidoID
END

GO