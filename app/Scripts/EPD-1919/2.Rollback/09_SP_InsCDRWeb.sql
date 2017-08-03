GO
alter PROCEDURE dbo.InsCDRWeb
(
	 @CDRWebID int
	,@PedidoID int
	,@PedidoNumero int
	,@CampaniaID int
	,@ConsultoraID int
	--,@FechaRegistro datetime
	--,@Estado int
	--,@FechaCulminado datetime
	,@Importe decimal(9,2)
	,@RetornoID int output
)
AS
BEGIN	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if	@CDRWebID = 0
	begin
		insert into CDRWeb
		(
			PedidoID
			,PedidoNumero
			,CampaniaID
			,ConsultoraID
			,FechaRegistro
			,Estado
			,FechaCulminado
			,Importe
		)
		values
		(
			@PedidoID
			,@PedidoNumero
			,@CampaniaID
			,@ConsultoraID
			,@FechaGeneral
			,'1'
			,NULL
			,NULL
		)

		SET @RetornoID = SCOPE_IDENTITY();
	end
	else
	begin
		SET @RetornoID = @CDRWebID;
	end
END
GO