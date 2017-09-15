GO
use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
drop procedure InsertarOfertaFinalRegaloSorpresa
go
CREATE PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
	@CampaniaID INT, 
	@ConsultoraId INT, 
	@MontoTotal MONEY, 
	@Algoritmo varchar(10),
	@MontoMeta decimal(18,2) output
)
AS
Begin	
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
	End			
End