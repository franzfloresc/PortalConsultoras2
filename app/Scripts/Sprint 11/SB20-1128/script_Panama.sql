USE BelcorpPanama
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNombreProducto048ByCuv]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetNombreProducto048ByCuv
GO

create procedure dbo.GetNombreProducto048ByCuv
@CampaniaID int,
@CUV varchar(5)
as
/*
GetNombreProducto048ByCuv 201616,'96930'
GetNombreProducto048ByCuv 201616,'00040'
*/
begin

declare @NombreProducto varchar(200) = ''

select @NombreProducto = coalesce(pd.Descripcion, pc.Descripcion)
from ods.ProductoComercial pc
left join ProductoDescripcion pd on
	pc.AnoCampania = pd.CampaniaID 
	AND pc.CUV = pd.CUV
where 
	pc.AnoCampania = @CampaniaID
	and pc.CUV = @CUV

select @NombreProducto as NombreProducto

end

go