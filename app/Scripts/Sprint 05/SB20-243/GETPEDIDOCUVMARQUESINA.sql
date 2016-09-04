USE [BelcorpPeru_SB2]
GO
/****** Object:  StoredProcedure [dbo].[GetPedidoCUVmarquesina]    Script Date: 26/07/2016 10:02:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetPedidoCUVmarquesina]
	@CampaniaID int,
	@ConsultoraID bigint,
	@CUV varchar(10)
AS
select Isnull(CUV,'') as CUV,
ISNULL(Cantidad, '0') as Cantidad,
ISNULL(PedidoDetalleID, '') PedidoWebDetalleID,
ISNULL(PedidoID, '') PedidoID
from [dbo].[PedidoWebDetalle] WITH (NOLOCK)
WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID and CUV = @CUV