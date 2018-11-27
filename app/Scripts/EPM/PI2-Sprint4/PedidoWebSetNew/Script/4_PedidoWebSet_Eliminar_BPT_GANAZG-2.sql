USE [BelcorpPeru_GANA]
GO

ALTER PROCEDURE PedidoWebSet_Eliminar 
	@SetId INT
AS
BEGIN 
		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID 
END
