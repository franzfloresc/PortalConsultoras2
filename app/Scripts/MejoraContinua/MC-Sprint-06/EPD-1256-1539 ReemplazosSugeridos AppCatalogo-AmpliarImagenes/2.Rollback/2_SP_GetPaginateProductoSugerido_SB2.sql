USE BelcorpBolivia
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpChile
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpCostaRica
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpDominicana
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpEcuador
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpGuatemala
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpPanama
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpPuertoRico
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpSalvador
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpVenezuela
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpColombia
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpMexico
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go
/*end*/

USE BelcorpPeru
go
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
	SET NOCOUNT OFF
END
go