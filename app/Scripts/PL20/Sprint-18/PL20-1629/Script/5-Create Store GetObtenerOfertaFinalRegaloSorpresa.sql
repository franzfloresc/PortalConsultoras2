GO
use BelcorpChile_Plan20
go
if Exists(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
drop procedure GetObtenerOfertaFinalRegaloSorpresa
go
Create Procedure [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
As
Begin
	Select 
		OfertaFinalMontoMeta.CampaniaId,
		OfertaFinalMontoMeta.ConsultoraId,
		OfertaFinalMontoMeta.MontoPedido,
		OfertaFinalMontoMeta.GapMinimo,
		OfertaFinalMontoMeta.GapMaximo,
		OfertaFinalMontoMeta.GapAgregar,
		OfertaFinalMontoMeta.MontoMeta,
		OfertaFinalMontoMeta.Cuv,
		pc.Descripcion,
		ProductoDescripcion.RegaloDescripcion,
		ProductoDescripcion.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta with (nolock)
		Inner Join ProductoDescripcion with (nolock) On 
			OfertaFinalMontoMeta.CampaniaId = ProductoDescripcion.CampaniaId And 
			OfertaFinalMontoMeta.Cuv = ProductoDescripcion.CUV
		Inner Join ods.ProductoComercial pc with (nolock) on pc.CUV = OfertaFinalMontoMeta.Cuv And pc.AnoCampania = OfertaFinalMontoMeta.CampaniaId						 
	Where 
		OfertaFinalMontoMeta.CampaniaId = @CampaniaId And 
		OfertaFinalMontoMeta.ConsultoraId = @ConsultoraId
End