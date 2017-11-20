USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

create procedure dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin

select
	CUV2 as Cuv, ImagenURL as RutaImagen
from Estrategia where CampaniaID = @CampaniaID and Activo = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

create procedure dbo.GetListaImagenesOfertaLiquidacionByCampania
@CampaniaID int
as
/*
GetListaImagenesOfertaLiquidacionByCampania 201716
*/
begin

declare @Id int = 0
select @Id = CampaniaID from ods.Campania where Codigo = @CampaniaID

select CUV as Cuv, ImagenProducto as RutaImagen from OfertaProducto
where CampaniaID = @Id

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

create procedure dbo.GetListaImagenesProductoSugeridoByCampania
@CampaniaID int
as
/*
GetListaImagenesProductoSugeridoByCampania 201716
*/
begin

select CUV as Cuv, ImagenProducto as RutaImagen from ProductoSugerido
where CampaniaID = @CampaniaID


end

go

