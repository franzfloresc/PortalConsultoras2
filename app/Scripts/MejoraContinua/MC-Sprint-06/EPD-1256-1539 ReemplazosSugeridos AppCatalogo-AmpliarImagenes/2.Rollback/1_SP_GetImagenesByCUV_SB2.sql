USE BelcorpBolivia
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpChile
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpCostaRica
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpDominicana
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpEcuador
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpGuatemala
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPanama
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPuertoRico
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpSalvador
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpVenezuela
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpColombia
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpMexico
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go
/*end*/

USE BelcorpPeru
go
ALTER PROCEDURE dbo.GetImagenesByCUV_SB2
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END
go