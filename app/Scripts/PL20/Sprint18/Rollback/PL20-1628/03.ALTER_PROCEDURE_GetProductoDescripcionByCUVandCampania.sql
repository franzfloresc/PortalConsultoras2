USE BelcorpPeru
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpColombia
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpMexico
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpChile
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE [BelcorpChile_Plan20]
GO

DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpBolivia
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpEcuador
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpCostaRica
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpDominicana
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpGuatemala
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpPanama
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpPuertoRico
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpSalvador
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO


USE BelcorpVenezuela
GO
DROP PROCEDURE [dbo].[GetProductoDescripcionByCUVandCampania]
GO

CREATE proc [dbo].[GetProductoDescripcionByCUVandCampania]
@CampaniaID int, 
@CUV varchar(20) 

as

begin

select p.Descripcion, 
	   p.AnoCampania As CampaniaID, 
	   p.CUV, 
	   p.PrecioUnitario  as PrecioProducto, 
	   p.FactorRepeticion
from ods.ProductoComercial p 
where p.AnoCampania = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV)) and IndicadorDigitable = 1

union all

select p.Descripcion, 
	   p.CampaniaID, 
	   p.CUV,
	   p.PrecioProducto,
	   p.FactorRepeticion
from dbo.ProductoDescripcion p
where p.CampaniaID = @CampaniaID and LTRIM(RTRIM(p.CUV)) = LTRIM(RTRIM(@CUV))
end
GO