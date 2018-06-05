use belcorpperu
go
IF (OBJECT_ID('dbo.ObtenerCuvSetDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ObtenerCuvSetDetalle AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[ObtenerCuvSetDetalle] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@PedidoId INT
	,@ListaSet NVARCHAR(200)
AS
BEGIN
	SELECT pw.setID AS SetID
		,pwd.CuvProducto AS CUV
	FROM pedidowebset pw
	INNER JOIN pedidowebsetdetalle pwd ON pw.setid = pwd.setid
	WHERE pwd.setid IN (
			SELECT Item
			FROM [SplitString](@ListaSet, ',')
			)
		AND pedidoid = @PedidoId
		AND consultoraid = @ConsultoraID
		AND campania = @CampaniaID
END;
