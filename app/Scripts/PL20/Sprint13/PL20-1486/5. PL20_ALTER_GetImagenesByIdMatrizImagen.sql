USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetImagenesByIdMatrizImagen]
(
	@IdMatrizComercial varchar(50),
	@NumeroPagina int,
	@Registros int
)
AS
SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   IdMatrizComercial,
			   isnull(Foto,'') Foto,
			   NemoTecnico,
			   FechaRegistro			   
		FROM MatrizComercialImagen
		where idMatrizComercial = @IdMatrizComercial
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;