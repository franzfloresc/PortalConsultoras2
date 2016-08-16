--Servidor: awrds008.cgwmheq2buot.us-east-1.rds.amazonaws.com

USE [AppCatalogo]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductoCatalogoByCodigoIsoCampa]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetProductoCatalogoByCodigoIsoCampa
GO

create procedure dbo.GetProductoCatalogoByCodigoIsoCampa
@CodigoIso varchar(2),
@CampaniaID int
as
/*
GetProductoCatalogoByCodigoIsoCampa 'PE',201612
*/
begin

SELECT 
pc.CodPais as CodigoIso, 
pc.IdMarca as IdMarca, 
pc.CodMarca as CodigoMarca, 
m.Nombre as NombreMarca,
pc.CodCampana as CampaniaId, 
pc.CUV as Cuv, 
pc.CodSAP as CodigoSap, 
DescripcionComercial, 
ISNULL(pc.NombreComercial, '') AS NombreComercial, 
ISNULL(pc.Descripcion, '') AS Descripcion, 
ISNULL(pc.PrecioValorizado, 0) AS PrecioValorizado, 
ISNULL(pc.PrecioCatalogo, 0) AS PrecioCatalogo, 
ISNULL(pc.Volumen, '') AS Volumen, 
ISNULL(pc.Imagen, '') AS Imagen
FROM ProductoCampana pc
inner join Marca m on
	pc.IdMarca = m.Id
WHERE 
pc.CodPais = @CodigoIso
AND pc.CodCampana = @CampaniaID 
AND pc.IdCatalogo > 0 
AND pc.IdMarca in (1,2,3)

end

go