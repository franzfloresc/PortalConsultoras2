USE [AppCatalogo]
GO

ALTER procedure [dbo].[GetProductoCatalogoByCodigoIsoBySap]
@CodigoIso varchar(2),
@CampaniaID int,
@CodigoSap varchar(max),
@NroCampania int
as
/*
GetProductoCatalogoByCodigoIsoBySap 'CO',201705,'200073557|200073558|200084114|200084115|200085580|200084116|200084117|200056620|200056633|200056634',3
*/
begin
declare @tablaCodigoSap as table ( CodigoSap varchar(20) )

DECLARE @lstCadena varchar(700)
DECLARE @lstDato varchar(20)
DECLARE @lnuPosComa int

--Seteando los codigos sap
SET @lstCadena = @CodigoSap		--Cadena de Codigo SAP.

--recorriendo los codigos sap
WHILE  LEN(@lstCadena)> 0
BEGIN
	SET @lnuPosComa = CHARINDEX('|', @lstCadena ) -- Buscamos el caracter separador
	IF ( @lnuPosComa=0 )
	BEGIN
		--En el caso que solo haya un solo codigo / No exista concatenacion.
		SET @lstDato = @lstCadena
		SET @lstCadena = ''
	END
	ELSE --Desconcatenando los codigos sap en @lstDato
	BEGIN
		SET @lstDato = Substring( @lstCadena , 1  , @lnuPosComa-1)
		SET @lstCadena = Substring( @lstCadena , @lnuPosComa + 1 , LEN(@lstCadena))
	END
	--Insertando casa SAP desconcatenado en la tabla temporal
	insert into @tablaCodigoSap values (@lstDato)
END

declare @tableProductos as table (
	CodigoIso char(3),
	IdMarca int,
	CodigoMarca char(1),
	NombreMarca varchar(50),
	CampaniaId int,
	Cuv char(10),
	CodigoSap varchar(15),
	DescripcionComercial varchar(100),
	NombreComercial varchar(200),
	Descripcion varchar(400),
	PrecioValorizado decimal(10,2),
	PrecioCatalogo decimal(10,2),
	Volumen varchar(50),
	Imagen varchar(50),
	ImagenBulk varchar(50),
	NombreBulk varchar(50)
)
-- En esta parte de insertan los codigos desconcatenados en @tableProductos
insert into @tableProductos (CodigoIso, CodigoSap, Imagen, ImagenBulk, NombreBulk) 
select @CodigoIso, CodigoSap, '', '', '' from @tablaCodigoSap
where isnull(CodigoSap,'') <> ''

--select * from @tableProductos

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
ISNULL(pc.Imagen, '') AS Imagen,
ISNULL(pc.ImagenBulk, '') AS ImagenBulk,
ISNULL(pc.NombreBulk, '') AS NombreBulk
INTO #tmp1		-- SB20-1198
FROM ProductoCampana pc
inner join Marca m on
	pc.IdMarca = m.Id
WHERE 
pc.CodPais = @CodigoIso
AND pc.CodCampana = @CampaniaID 
AND pc.IdCatalogo > 0 
AND pc.IdMarca in (1,2,3)
AND pc.CodSAP in (select CodigoSap from @tablaCodigoSap)

--select * from #tmp1

update a 
set 
	--a.CodigoIso = b.CodigoIso
	a.IdMarca = b.IdMarca,
	a.CodigoMarca = b.CodigoMarca,
	a.NombreMarca = b.NombreMarca,
	a.CampaniaId = b.CampaniaId,
	a.CUV = b.CUV,
	--a.CodigoSAP = b.CodigoSAP,
	a.DescripcionComercial = b.DescripcionComercial,
	a.NombreComercial = b.NombreComercial,
	a.Descripcion = b.Descripcion,
	a.PrecioValorizado = b.PrecioValorizado,
	a.PrecioCatalogo = b.PrecioCatalogo,
	a.Volumen = b.Volumen,
	a.Imagen = b.Imagen,
	a.ImagenBulk = b.ImagenBulk,
	a.NombreBulk = b.NombreBulk
from @tableProductos a inner join #tmp1 b on a.CodigoSAP = b.CodigoSAP

--select * from @tableProductos

/* INICIO SB20-1198 */
-- SI @tableProductos TIENE DATOS

if exists (select 1 from @tableProductos pc where isnull(Imagen,'') = '')
begin 

	--select * from @tableProductos
	declare @campania_inicio int, @campania_fin int

	select top (@NroCampania) Codigo into #tmp2
	from Campana 
	where CodPais = @CodigoIso --'PE' 
	and Codigo < @CampaniaID --201618
	group by Codigo
	order by Codigo desc 

	select @campania_inicio = min(Codigo), @campania_fin = max(Codigo) from #tmp2

	print @campania_inicio
	print @campania_fin

	----select * from @tableProductos

	select 
		CodSAP as CodigoSAP, 
		CodCampana as CampaniaId,
		CodMarca as CodigoMarca,
		pc.Imagen,
		NombreComercial,
		Descripcion,
		Cuv,
		PrecioValorizado,
		Volumen,
		PrecioCatalogo,
		DescripcionComercial,
		IdMarca,
		m.Nombre as NombreMarca,
		ImagenBulk,
		NombreBulk
		into #tmp3
	from ProductoCampana pc
	inner join Marca m on pc.IdMarca = m.Id
	where CodPais = @CodigoIso
	and CodCampana between @campania_inicio and @campania_fin
	and IdCatalogo > 0 
	and IdMarca in (1,2,3)
	and CodSAP in (
		select CodigoSAP from @tableProductos where isnull(Imagen,'') = ''
	) 
	and isnull(pc.Imagen,'') <> ''

	--select * from #tmp3
			 
	--update a
	--set a.Imagen = (
	--	select top 1 Imagen 
	--	from #tmp3 b 
	--	where b.CodigoSAP = a.CodigoSAP 
	--	order by b.CampaniaId desc
	--)
	--from @tableProductos a
	--where isnull(a.Imagen,'') = ''

	update a
	set a.Imagen = b.Imagen,
		a.CodigoMarca = b.CodigoMarca,
		a.NombreComercial = b.NombreComercial,
		a.Descripcion = b.Descripcion,
		a.Cuv = b.Cuv,
		a.PrecioValorizado = b.PrecioValorizado,
		a.CampaniaId = b.CampaniaId,
		a.Volumen = b.Volumen,
		a.PrecioCatalogo = b.PrecioCatalogo,
		a.DescripcionComercial = b.DescripcionComercial,
		a.IdMarca = b.IdMarca,
		a.NombreMarca = b.NombreMarca,
		a.ImagenBulk = b.ImagenBulk,
		a.NombreBulk = b.NombreBulk
	from @tableProductos a inner join #tmp3 b on b.CodigoSAP = (
		select top 1 CodigoSAP
		from #tmp3
		where CodigoSAP = a.CodigoSAP 
		order by CampaniaId desc
	)
	where isnull(a.Imagen,'') = ''

	drop table #tmp2
	drop table #tmp3

end

drop table #tmp1

select * from @tableProductos

/* FIN SB20-1198 */

END

go

CREATE NONCLUSTERED INDEX IX_ProductoCampana_CodPaisIdMarcaIdCatalogo ON dbo.ProductoCampana (CodPais,IdMarca,IdCatalogo) 
INCLUDE(CodMarca,CodCampana,CodSAP,NombreComercial,Imagen)

go