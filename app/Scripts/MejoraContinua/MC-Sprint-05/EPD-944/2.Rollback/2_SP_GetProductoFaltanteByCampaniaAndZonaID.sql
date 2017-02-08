USE BelcorpBolivia
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpChile
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpPanama
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpColombia
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpMexico
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go
/*end*/

USE BelcorpPeru
go
alter procedure GetProductoFaltanteByCampaniaAndZonaID --201302,4041  
    @CampaniaID int,
    @ZonaID int
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID

    SELECT DISTINCT pf.CUV,pc.Descripcion
    FROM dbo.ProductoFaltante pf with(nolock)
                    JOIN ods.ProductoComercial pc with(nolock) ON pf.CampaniaID = pc.AnoCampania AND pf.CUV = pc.CUV
    WHERE pf.CampaniaID = @CampaniaID AND pf.ZonaID = @ZonaID AND pc.IndicadorDigitable = 1 and
                                    ISNULL(pf.FaltanteUltimoMinuto,0) = 0

    UNION 

    select distinct fa.CodigoVenta,pc.Descripcion
	from ods.FaltanteAnunciado fa with(nolock)
                    inner join ods.ProductoComercial pc with(nolock) on pc.CUV = fa.CodigoVenta and pc.CampaniaID = fa.CampaniaID
                    inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
    WHERE ca.Codigo = @CampaniaID AND pc.IndicadorDigitable = 1 and 
                    ((rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) and ((rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)))
end
go