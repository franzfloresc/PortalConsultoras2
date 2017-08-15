USE BelcorpBolivia
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpChile
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpCostaRica
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpDominicana
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpEcuador
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpGuatemala
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPanama
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPuertoRico
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpSalvador
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpVenezuela
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpColombia
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpMexico
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPeru
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
	@CampaniaID int,
	@CUV varchar(50)
AS
BEGIN
	set @CampaniaID = isnull(@CampaniaID, 0);
	set @CUV = isnull(@CUV, '');

	select
		pc.CodigoProducto as CodigoSAP,
		pc.CUV,
		isnull(pc.Descripcion,'') DescripcionProductoComercial,
		pc.IndicadorDigitable,
		pc.EstadoActivo,
		isnull(mc.IdMatrizComercial,0) IdMatrizComercial,
		isnull(mc.Descripcion,'') Descripcion,
		isnull(mc.DescripcionOriginal,'') DescripcionOriginal,
		isnull(mc.FotoProducto01,'') FotoProducto01,
		isnull(mc.FotoProducto02,'') FotoProducto02,
		isnull(mc.FotoProducto03,'') FotoProducto03,
		isnull(mc.FotoProducto04,'') FotoProducto04,
		isnull(mc.FotoProducto05,'') FotoProducto05,
		isnull(mc.FotoProducto06,'') FotoProducto06,
		isnull(mc.FotoProducto07,'') FotoProducto07,
		isnull(mc.FotoProducto08,'') FotoProducto08,
		isnull(mc.FotoProducto09,'') FotoProducto09,
		isnull(mc.FotoProducto10,'') FotoProducto10
	from ods.productocomercial pc
	inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	left join MatrizComercial mc on pc.CodigoProducto  = mc.CodigoSAP		
	where pc.CUV = @CUV and c.Codigo = @CampaniaID 
END
go