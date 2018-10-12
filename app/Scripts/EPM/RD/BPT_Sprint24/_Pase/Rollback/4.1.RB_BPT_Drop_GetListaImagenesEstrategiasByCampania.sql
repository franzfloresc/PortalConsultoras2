GO
USE BelcorpPeru
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesEstrategiasByCampania') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
GO

CREATE PROCEDURE dbo.GetListaImagenesEstrategiasByCampania
@CampaniaID int
as
/*
GetListaImagenesEstrategiasByCampania 201717
GetListaImagenesEstrategiasByCampania 201715
*/
begin
select
	CUV2 as Cuv,
	ImagenURL as RutaImagen
from Estrategia
where CampaniaID = @CampaniaID
	and Activo = 1

end
GO

GO
