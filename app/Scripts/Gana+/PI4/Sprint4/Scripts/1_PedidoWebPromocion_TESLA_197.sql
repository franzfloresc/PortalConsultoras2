USE [BelcorpPeru_GANAMAS]
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoWebPromocion') AND TYPE = 'U')
   DROP TABLE DBO.PedidoWebPromocion
GO

CREATE TABLE DBO.PedidoWebPromocion
(
	CuvPromocion varchar(10),
	CuvCondicion varchar(10),
	CampaniaID int
)
GO
