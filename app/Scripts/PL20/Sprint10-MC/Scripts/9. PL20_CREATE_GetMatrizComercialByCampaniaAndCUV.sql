USE BelcorpBolivia
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpChile
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpColombia
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpMexico
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpPanama
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpPeru
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpSalvador
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

USE BelcorpVenezuela
GO
IF OBJECT_ID('GetMatrizComercialByCampaniaAndCUV', 'P') IS NOT NULL
DROP PROC GetMatrizComercialByCampaniaAndCUV
GO

CREATE PROCEDURE [dbo].[GetMatrizComercialByCampaniaAndCUV]
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	select
		pc.CodigoProducto as CodigoSAP,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END

GO

