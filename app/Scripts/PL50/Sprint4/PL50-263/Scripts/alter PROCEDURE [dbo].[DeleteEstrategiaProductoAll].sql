USE Belcorpcolombia_pl50
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END