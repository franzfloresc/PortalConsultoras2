Use AppCatalogo
go

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetProductoCatalogoByCodigoIsoBySap]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure dbo.GetProductoCatalogoByCodigoIsoBySap
GO

create procedure dbo.GetProductoCatalogoByCodigoIsoBySap
@CodigoIso varchar(2),
@CampaniaID int,
@CodigoSap varchar(max)
as
/*
GetProductoCatalogoByCodigoIsoBySap 'PE',201616,'210083746|200064346|200080243|200082397|210082770'
*/
begin

declare @tablaCodigoSap as table ( CodigoSap varchar(20) )

DECLARE @lstCadena varchar(700)
DECLARE @lstDato varchar(20)
DECLARE @lnuPosComa int

SET @lstCadena = @CodigoSap		--Cadena de Codigo SAP.

WHILE  LEN(@lstCadena)> 0
BEGIN
	SET @lnuPosComa = CHARINDEX('|', @lstCadena ) -- Buscamos el caracter separador
	IF ( @lnuPosComa=0 )
	BEGIN
		SET @lstDato = @lstCadena
		SET @lstCadena = ''
	END
	ELSE
	BEGIN
		SET @lstDato = Substring( @lstCadena , 1  , @lnuPosComa-1)
		SET @lstCadena = Substring( @lstCadena , @lnuPosComa + 1 , LEN(@lstCadena))
	END
	
	insert into @tablaCodigoSap values (@lstDato)
END

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
AND pc.CodSAP in (select CodigoSap from @tablaCodigoSap)

end

go