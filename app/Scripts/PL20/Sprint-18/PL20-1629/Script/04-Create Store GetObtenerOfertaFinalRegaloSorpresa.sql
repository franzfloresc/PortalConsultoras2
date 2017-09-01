
USE BelcorpBolivia
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpChile
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpColombia
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpMexico
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpPanama
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpPeru
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE GetObtenerOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
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
