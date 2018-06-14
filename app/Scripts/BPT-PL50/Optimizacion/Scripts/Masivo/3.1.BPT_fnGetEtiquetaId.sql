
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnGetEtiquetaId') AND type IN ( N'TF', N'FN' ) ) 
	DROP FUNCTION [fnGetEtiquetaId]
GO

CREATE FUNCTION [fnGetEtiquetaId]
(
	@EstrategiaCodigo varchar(100)
)
returns int
begin


	DECLARE @tipoId int = 0
	IF @EstrategiaCodigo = '001'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @EstrategiaCodigo = '009'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @EstrategiaCodigo = '020'
	BEGIN
		SELECT @tipoId = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	return @tipoId
end
GO


