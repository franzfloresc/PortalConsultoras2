USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarcaContenidoVisto]')  AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[MarcaContenidoVisto]
GO

CREATE PROC MarcaContenidoVisto
@IdContenidoDeta INT,
@CodigoConsultora varchar(20)
AS
BEGIN
	IF NOT EXISTS(SELECT IdVistoContenido FROM dbo.VistoContenidoConsultora WHERE CodigoConsultora=@CodigoConsultora AND IdContenidoDeta=@IdContenidoDeta)
	BEGIN
		INSERT INTO [VistoContenidoConsultora]([CodigoConsultora],[IdContenidoDeta],[FechaVisto])
		VALUES (@CodigoConsultora,@IdContenidoDeta,GETDATE())
	END
END

GO