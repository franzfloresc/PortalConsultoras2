
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
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
		--Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
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