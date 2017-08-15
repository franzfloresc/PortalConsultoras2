
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(50) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'DesTipoRegistro' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalConsultora_Log'))
BEGIN
	ALTER TABLE dbo.OfertaFinalConsultora_Log
	DROP COLUMN DesTipoRegistro
END  
GO

ALTER TABLE dbo.OfertaFinalConsultora_Log
ADD DesTipoRegistro VARCHAR(50);
GO

ALTER PROCEDURE [dbo].[registrarLogOfertaFinal_SB2]
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2),
	@TipoRegistro int = 1,
	@DesTipoRegistro varchar(150) = null
AS	
BEGIN		
	declare @CantidadInsertar int
	if @Cantidad = 0
	begin
		set @CantidadInsertar = null
	end
	else
	begin
		set @CantidadInsertar = @Cantidad
	end

	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP, TipoRegistro, DesTipoRegistro)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @CantidadInsertar, GETDATE(), @TipoOfertaFinal, @GAP, @TipoRegistro, @DesTipoRegistro)
END
GO


