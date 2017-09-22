USE BelcorpBolivia
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
	DROP PROCEDURE InsertarOfertaFinalRegaloSorpresa
GO

CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
BEGIN	
	/*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
	if @Algoritmo != 'OFR' 
	Return;

	Declare @GapAgregar decimal(18,2),--@MontoMeta decimal(18,2),
	@RangoId int,@GapMinimo decimal(18,2),@GapMaximo decimal(18,2)	
	set @MontoMeta = 0
			
	Select
		@RangoId = isnull(OfertaFinalParametriaID,0),
		@GapAgregar = isnull(PrecioMinimo,0),
		@GapMinimo = isnull(GapMinimo,0),
		@GapMaximo = isnull(GapMaximo,0)			
	From dbo.OfertaFinalParametria
	Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo			
				
	if Not Exists(Select 1 From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId) And @RangoId != 0
	Begin
		/*Monto Meta y Regalo*/
		Declare @Cuv varchar(100)		
		Set @Cuv = (Select Cuv From OfertaFinalRegaloXCampania with (nolock) Where CampaniaId = @CampaniaId And RangoId = @RangoId)
		Set @MontoMeta = @MontoTotal + @GapAgregar			
		insert into OfertaFinalMontoMeta(CampaniaId,ConsultoraId,MontoPedido,GapMinimo,GapMaximo,GapAgregar,MontoMeta,Cuv)
		select 
			CampaniaId = @CampaniaId,
			ConsultoraId = @ConsultoraId,
			MontoPedido = @MontoTotal,
			GapMinimo = @GapMinimo,
			GapMaximo = @GapMaximo,
			GapAgregar = @GapAgregar,
			MontoMeta = @MontoMeta,
			Cuv = @Cuv									
	END			
END
GO



