USE BelcorpBolivia
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpChile
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpColombia
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpCostaRica
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpDominicana
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpEcuador
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpGuatemala
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpMexico
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpPanama
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpPeru
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpPuertoRico
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
USE BelcorpSalvador
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetUpsellingMarcaCategoriaLista AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetUpsellingMarcaCategoriaLista 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin


if(@MarcaID='')
begin 
set @MarcaID=null 
end


if(@CategoriaID='')
begin 
set @CategoriaID=null 
end


SELECT        UpsellingID, MarcaID,m.DescripcionLarga as MarcaNombre, CategoriaID, c.DescripcionCategoria as CategoriaNombre
FROM            Upselling_Marca_Categoria umc 
inner join ods.sap_marca m on umc.MarcaID = m.Codigo
inner join ODS.SAP_CATEGORIA c on umc.CategoriaID = c.CodigoCategoria
where umc.UpSellingID= @UpSellingId
and (umc.MarcaID = @MarcaID or @MarcaID is null )
and (umc.CategoriaID = @CategoriaID or @CategoriaID is null )

end
go
