GO
IF OBJECT_ID('dbo.GetRegaloProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetRegaloProgramaNuevas
END
GO
CREATE PROCEDURE [dbo].[GetRegaloProgramaNuevas]
	@CodigoPrograma varchar(3),
	@CampaniaId char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select top 1
		PPN.CUV as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.PremiosProgramaNuevas PPN
	inner join ods.ProductoComercial PC on PC.AnoCampania = PPN.AnoCampana and PC.CUV = PPN.CUV
	left join ProductoDescripcion PD ON PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		PPN.CodigoPrograma = @CodigoPrograma and PPN.AnoCampana = @CampaniaId and PPN.CodigoNivel = @CodigoNivel and
		isnull(PPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0;
END
GO