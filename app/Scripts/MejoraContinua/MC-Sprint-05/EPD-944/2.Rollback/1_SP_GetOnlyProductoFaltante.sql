USE BelcorpBolivia
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpChile
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpPanama
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpColombia
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go
/*end*/

USE BelcorpPeru
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int
as/*GetOnlyProductoFaltante 201616,2541*/
begin
	SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
    INNER JOIN ods.ProductoComercial pc with(nolock) ON 
		pf.CampaniaID = pc.AnoCampania 
		AND pf.CUV = pc.CUV
    WHERE 
		pf.CampaniaID = @CampaniaID 
		AND pf.ZonaID = @ZonaID 
		AND pc.IndicadorDigitable = 1 
		and ISNULL(pf.FaltanteUltimoMinuto,0) = 0;
end
go