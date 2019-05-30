GO
USE [BelcorpBolivia]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpChile]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpColombia]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpCostaRica]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpDominicana]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpEcuador]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpGuatemala]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpMexico]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpPanama]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpPeru]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

GO
USE [BelcorpSalvador]
GO
ALTER PROCEDURE dbo.GetPaginateProductoSugerido_SB2
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
	,@RegionID INT=0 --/* HD-4289 */
	,@ZonaID INT=0 --/* HD-4289 */
AS
BEGIN
	SET NOCOUNT ON;

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
		,isnull(psp.MostrarAgotado, 0) MostrarAgotado
		,ps.RegionID --/* HD-4289 */
		,isnull(re.Codigo,'Todas') as Region --/* HD-4289 */
		,ps.ZonaID --/* HD-4289 */
		,isnull(zo.Codigo,'Todas') as Zona --/* HD-4289 */
	FROM dbo.ProductoSugerido ps
	LEFT JOIN dbo.ProductoSugeridoPadre psp on psp.CampaniaID = ps.CampaniaId and psp.CUV = ps.CUV
	LEFT JOIN ods.Region re on ps.RegionID=re.RegionID --/* HD-4289 */
	LEFT JOIN ods.Zona zo on ps.ZonaID=zo.ZonaID --/* HD-4289 */
	WHERE
		(ps.CampaniaID = @CampaniaID or @CampaniaID = 0)
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and (ps.RegionID = @RegionID or @RegionID = 0)--/* HD-4289 */
		and (ps.ZonaID = @ZonaID or @ZonaID = 0)--/* HD-4289 */
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden;

	SET NOCOUNT OFF;
END

