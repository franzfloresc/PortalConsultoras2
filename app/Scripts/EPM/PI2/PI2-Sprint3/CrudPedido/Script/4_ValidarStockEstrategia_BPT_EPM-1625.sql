USE [BelcorpPeru_BPT]
GO

ALTER PROCEDURE [dbo].[ValidarStockEstrategia]
	@CUV VARCHAR(20),
	@CampaniaID INT,
	@CantidadPedida INT,
	@flagPedido INT,
	@ConsultoraID INT = NULL
AS
BEGIN
	set nocount on;

	declare @validarEstrategia bit = 0;
	declare @NumeroPedido int = 0;
	declare @mensaje varchar(5000) = '';

	if @flagPedido <> 0
	begin
		declare @ProgramaNuevoActivado INT;
		select @ProgramaNuevoActivado = count(C.ConsultoraID)
		from ods.Consultora C
		inner join ods.ConsultorasProgramaNuevas CP on C.Codigo = CP.CodigoConsultora
		where C.ConsultoraID = @ConsultoraID and CP.Participa = 1;

		if @ProgramaNuevoActivado <> 0
		begin		
			select @NumeroPedido = consecutivonueva + 1
			from ods.Consultora
			where ConsultoraID=@ConsultoraID;
		end

		set @validarEstrategia = iif(exists(select 1 from Estrategia where CampaniaID = @CampaniaID and CUV2 = @CUV and NumeroPedido = @NumeroPedido and TipoEstrategiaID = @flagPedido and Activo = 1), 1, 0);
	end
	
	if @validarEstrategia = 1
	begin
		declare @CantidadYaSolicitada int = isnull((select SUM(Cantidad) from PEDIDOWEBDETALLE where CUV = @CUV AND CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID),0);
		declare @CantidadSolicitante int = isnull(@CantidadYaSolicitada, 0) + @CantidadPedida;
		declare @CantidadLimite int = isnull((
			select LimiteVenta
			from Estrategia
			where CampaniaID = @CampaniaID and CUV2 = @CUV and NumeroPedido = @NumeroPedido and TipoEstrategiaID = @flagPedido and Activo = 1				
		), 0);
	
		if @CantidadSolicitante > @CantidadLimite
		begin
			set @mensaje = iif(
				@CantidadLimite = @CantidadYaSolicitada,
				'Usted ya ingresó la cantidad total permitida para éste producto (' + CONVERT(VARCHAR, @CantidadLimite) + ').',
				'La cantidad solicitada sobrepasa las Unidades Permitidas de Venta (' + CONVERT(VARCHAR, @CantidadLimite) + ') del producto.' 
				--+ ' Usted solo puede adicionar ' + CONVERT(VARCHAR, @CantidadLimite - @CantidadYaSolicitada) + ' más, debido a que ya agregó este producto a su pedido, verifique.'
			);
		end
	end

	select iif(@mensaje <> '', @mensaje, 'OK');
END
