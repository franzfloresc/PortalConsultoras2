
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetTipoEstrategiaId') AND type IN ( N'TF', N'FN' ) ) 
	DROP FUNCTION [fnGetTipoEstrategiaId]
GO

CREATE FUNCTION [fnGetTipoEstrategiaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin
	
	DECLARE @tipoId int = 0

	select @tipoId = TipoEstrategiaId  from TipoEstrategia where Codigo = @EstrategiaCodigo

	return @tipoId
end
GO


