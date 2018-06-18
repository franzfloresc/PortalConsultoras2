

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO

CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote 

	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


