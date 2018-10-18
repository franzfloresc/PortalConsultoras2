GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
CREATE PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from ProductoSugerido
	where CampaniaID = @CampaniaID
end

GO

GO
