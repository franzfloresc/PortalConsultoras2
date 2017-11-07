
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
@CampaniaId Int,
@ConsultoraId Int
AS
BEGIN
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
		prd.RegaloDescripcion,
		prd.RegaloImagenUrl						
	From dbo.OfertaFinalMontoMeta ofe with (nolock)
		Inner Join ProductoDescripcion prd with (nolock) On 
			ofe.CampaniaId = prd.CampaniaId And ofe.Cuv = prd.CUV
		Inner Join ods.ProductoComercial pc with (nolock) On			
			pc.CUV = ofe.Cuv And pc.AnoCampania = ofe.CampaniaId						 
	Where 
		ofe.CampaniaId = @CampaniaId And 
		ofe.ConsultoraId = @ConsultoraId
END
GO