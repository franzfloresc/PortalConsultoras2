USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetMatrizImagenesByCodigoSap]
(
	@CodigoSap varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

DECLARE @IdMatrizComercial INT

SET @IdMatrizComercial = (SELECT TOP 1 IdMatrizComercial FROM MatrizComercial WHERE CodigoSAP=@CodigoSap)

SELECT 
	*,
COUNT(*) OVER() AS TotalRegistros
FROM
(
	SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
	 mc.IdMatrizComercial,
	 isnull(Foto,'') Foto,
	 NemoTecnico,
	 mci.FechaRegistro 
	FROM MatrizComercial mc
	left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial
	where mc.idMatrizComercial = @IdMatrizComercial
) as T
order by T.FechaRegistro desc
OFFSET (@NumeroPagina-1)*@Registros ROWS
FETCH NEXT @Registros ROWS ONLY;

END


