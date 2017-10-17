
GO
ALTER PROCEDURE dbo.GetEstrategiaProducto
	 @EstrategiaId int
AS
begin

	SELECT 
	 EstrategiaProductoId
	,EstrategiaId
	,Campania
	,CUV
	,CodigoEstrategia
	,Grupo
	,Orden
	,CUV2
	,SAP
	,Cantidad
	,Precio
	,PrecioValorizado
	,Digitable
	,CodigoError
	,CodigoErrorObs
	,FactorCuadre
	FROM EstrategiaProducto
	WHERE EstrategiaId = @EstrategiaId
	
end

GO