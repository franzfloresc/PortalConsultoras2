USE [BelcorpPeru_GANAMAS]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY  
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY  
	BEGIN CATCH  
		 SELECT 0; 
	END CATCH
END
GO