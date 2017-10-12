GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
