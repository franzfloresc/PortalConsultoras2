USE [BelcorpPeru_GANAMAS]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]
GO


CREATE PROCEDURE [dbo].[GetPromocionesByCondicion]
	@CampaniaID INTEGER,
	@CuvCondicion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvCondicion = @CuvCondicion AND CampaniaID = @CampaniaID;
END
GO
