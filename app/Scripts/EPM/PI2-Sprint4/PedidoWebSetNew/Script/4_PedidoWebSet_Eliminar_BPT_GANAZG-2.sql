USE [BelcorpPeru_BPT]
GO

ALTER PROCEDURE PedidoWebSet_Eliminar 
	@SetId INT
AS
BEGIN 
		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID 
END
GO

USE [BelcorpChile_BPT]
GO

ALTER PROCEDURE PedidoWebSet_Eliminar 
	@SetId INT
AS
BEGIN 
		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID 
END
GO

USE [BelcorpCostaRica_BPT]
GO

ALTER PROCEDURE PedidoWebSet_Eliminar 
	@SetId INT
AS
BEGIN 
		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID 
END
GO