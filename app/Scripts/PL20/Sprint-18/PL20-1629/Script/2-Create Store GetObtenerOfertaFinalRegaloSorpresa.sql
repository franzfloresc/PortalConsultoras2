GO
use BelcorpChile
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
		ofe.CampaniaId,
		ofe.ConsultoraId,
		ofe.MontoPedido,
		ofe.GapMinimo,
		ofe.GapMaximo,
		ofe.GapAgregar,
		ofe.MontoMeta,
		ofe.Cuv,
		pc.Descripcion,
		ProductoDescripcion.RegaloDescripcion,
		ProductoDescripcion.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = ProductoDescripcion.CampaniaId And ofe.Cuv = ProductoDescripcion.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = OfertaFinalMontoMeta.Cuv And pc.AnoCampania = OfertaFinalMontoMeta.CampaniaId						 
	Where 
		OfertaFinalMontoMeta.CampaniaId = @CampaniaId And 
		OfertaFinalMontoMeta.ConsultoraId = @ConsultoraId
End