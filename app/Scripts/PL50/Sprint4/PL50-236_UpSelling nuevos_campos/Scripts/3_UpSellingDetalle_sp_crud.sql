/*Optener detalles del UpSelling*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSellingDetalle_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSellingDetalle_Select
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Select (@UpSellingId INT)
AS
SET NOCOUNT ON;

WITH Ganadoras
AS (
	SELECT CampaniaID AS CodigoCampana
		,CUV
		,COUNT(CUV) AS Cantidad
	FROM OfertaFinalMontoMeta
	GROUP BY CampaniaID
		,CUV
	)
SELECT ud.UpSellingDetalleId
	,ud.CUV
	,ud.Nombre
	,ud.Descripcion
	,ud.Imagen
	,ud.Stock
	,ud.Orden
	,ud.Activo
	,ud.UpSellingId
	,ud.UsuarioCreacion
	,ud.FechaCreacion
	,ud.UsuarioModificacion
	,ud.FechaModificacion
	,ud.Stock - ISNULL(g.Cantidad, 0) AS StockActual
FROM UpSellingDetalle ud
INNER JOIN UpSelling u ON ud.UpSellingId = u.UpSellingId
LEFT JOIN Ganadoras g ON ud.CUV = g.CUV
	AND g.CodigoCampana = u.CodigoCampana
WHERE ud.UpSellingId = @UpSellingId;
GO

/*Optener Stock Actual*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSellingDetalle_Select_By_Id'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSellingDetalle_Select_By_Id
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Select_By_Id (@UpSellingDetalleId INT)
AS
SET NOCOUNT ON;

WITH Ganadoras
AS (
	SELECT CampaniaID AS CodigoCampana
		,CUV
		,COUNT(CUV) AS Cantidad
	FROM OfertaFinalMontoMeta
	GROUP BY CampaniaID
		,CUV
	)
SELECT ud.UpSellingDetalleId
	,ud.CUV
	,ud.Nombre
	,ud.Descripcion
	,ud.Imagen
	,ud.Stock
	,ud.Orden
	,ud.Activo
	,ud.UpSellingId
	,ud.UsuarioCreacion
	,ud.FechaCreacion
	,ud.UsuarioModificacion
	,ud.FechaModificacion
	,ud.Stock - ISNULL(g.Cantidad, 0) AS StockActual
FROM UpSellingDetalle ud
INNER JOIN UpSelling u ON ud.UpSellingId = u.UpSellingId
LEFT JOIN Ganadoras g ON ud.CUV = g.CUV
	AND g.CodigoCampana = u.CodigoCampana
WHERE ud.UpSellingDetalleId = @UpSellingDetalleId;
GO


IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSellingDetalle_Insert'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSellingDetalle_Insert
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Insert (
	@CUV VARCHAR(50)
	,@Nombre VARCHAR(250)
	,@Descripcion VARCHAR(500)
	,@Imagen VARCHAR(400)
	,@Stock INT
	,@Orden INT
	,@Activo BIT
	,@UpSellingId INT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSellingDetalle] (
	[CUV]
	,[Nombre]
	,[Descripcion]
	,[Imagen]
	,[Stock]
	,[Orden]
	,[Activo]
	,[UpSellingId]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CUV
	,@Nombre
	,@Descripcion
	,@Imagen
	,@Stock
	,@Orden
	,@Activo
	,@UpSellingId
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingDetalleId
	,CUV
	,Nombre
	,Descripcion
	,Imagen
	,Stock
	,Orden
	,Activo
	,UpSellingId
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSellingDetalle
WHERE (UpSellingDetalleId = SCOPE_IDENTITY())
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSellingDetalle_Update'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSellingDetalle_Update
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Update (
	@CUV VARCHAR(50)
	,@Nombre VARCHAR(250)
	,@Descripcion VARCHAR(500)
	,@Imagen VARCHAR(400)
	,@Stock INT
	,@Orden INT
	,@Activo BIT
	,@UpSellingId INT	
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME	
	,@UpSellingDetalleId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSellingDetalle]
SET [CUV] = @CUV
	,[Nombre] = @Nombre
	,[Descripcion] = @Descripcion
	,[Imagen] = @Imagen
	,[Stock] = @Stock
	,[Orden] = @Orden
	,[Activo] = @Activo
	,[UpSellingId] = @UpSellingId
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingDetalleId] = @UpSellingDetalleId);

SELECT UpSellingDetalleId
	,CUV
	,Nombre
	,Descripcion
	,Imagen
	,Stock
	,Orden
	,Activo
	,UpSellingId
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSellingDetalle
WHERE (UpSellingDetalleId = @UpSellingDetalleId)
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSellingDetalle_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSellingDetalle_Delete
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Delete (
	@UpSellingDetalleId INT
	)
AS
SET NOCOUNT OFF;

IF EXISTS(
SELECT ud.UpSellingDetalleId
	,ud.CUV	
	,ud.UpSellingId
	,ofi.ConsultoraId
FROM UpSellingDetalle ud
INNER JOIN UpSelling u ON ud.UpSellingId = u.UpSellingId
INNER JOIN OfertaFinalMontoMeta ofi ON ud.CUV = ofi.CUV
	AND u.CodigoCampana = ofi.CampaniaID
	WHERE ud.UpSellingDetalleId = @UpSellingDetalleId
	)
THROW 51000, 'Regalo asociado a alguna consultora.', 1;  

DELETE
FROM [UpSellingDetalle]
WHERE ([UpSellingDetalleId] = @UpSellingDetalleId)
GO


