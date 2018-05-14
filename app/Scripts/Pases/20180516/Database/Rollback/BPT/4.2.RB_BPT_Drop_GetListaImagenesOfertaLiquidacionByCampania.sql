GO
USE BelcorpPeru
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesOfertaLiquidacionByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesOfertaLiquidacionByCampania
GO

CREATE PROCEDURE  dbo.GetListaImagenesOfertaLiquidacionByCampania
	@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin
	declare @Id int = 0
	select @Id = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaID

	select CUV as Cuv,
		ImagenProducto as RutaImagen
	from OfertaProducto
	where CampaniaID = @Id
end
GO

GO
