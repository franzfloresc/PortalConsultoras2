GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO
create proc dbo.UpdListBackOrderPedidoWebDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@ListPedidoDetalleID dbo.IdSmallintType readonly
AS
BEGIN
	update dbo.PedidoWebDetalle
	set EsBackOrder = 0
	where
		CampaniaID = @CampaniaID and
		PedidoID = @PedidoID and
		AceptoBackOrder = 0;

	if exists (select 1 from @ListPedidoDetalleID)
	begin
		update dbo.PedidoWebDetalle
		set
			EsBackOrder = 1,
			AceptoBackOrder = 0
		from dbo.PedidoWebDetalle PWD
		inner join @ListPedidoDetalleID PDI ON
			PWD.CampaniaID = @CampaniaID and
			PWD.PedidoID = @PedidoID and
			PWD.PedidoDetalleID = PDI.Id;
	end
END
GO