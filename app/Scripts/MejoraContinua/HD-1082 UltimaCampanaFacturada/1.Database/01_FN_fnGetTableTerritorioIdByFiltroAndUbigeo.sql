GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table(TerritorioID int)
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO

