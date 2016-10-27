GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03
			--count(*) as Cantidad
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
	--ORDER BY PC.CodigoProducto
END
GO