GO
ALTER PROCEDURE dbo.UpdEstadoCDRWeb
	@CDRWebID int
	,@Estado int
	,@RetornoID int output
AS
/*
declare @retorno int
execute UpdEstadoCDRWeb 1,2,@retorno output
*/
BEGIN	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais();

	set @CDRWebID = isnull(@CDRWebID, 0);
	set @Estado = isnull(@Estado, 0);

	if	@CDRWebID > 0 and @Estado > 0
	begin
		update CDRWeb
		set Estado = @Estado
		, FechaCulminado = case when @Estado = 2 then @FechaGeneral else FechaCulminado end
		, FechaAtencion = case when @Estado = 2 then null else FechaAtencion end
		where CDRWebID = @CDRWebID
		
		if @Estado = 2 or @Estado = 1
		begin				
			update CDRWebDetalle
			set Estado = @Estado
			where CDRWebID = @CDRWebID
			
			SET @RetornoID = 1
		end
	end
END
GO