GO
ALTER PROCEDURE dbo.UpdEstadoCDRWeb
	@CDRWebID int
	,@Estado int
	,@RetornoID int output
	,@TipoDespacho bit  = null --EPD-1919
	,@FleteDespacho decimal(15,2) = null --EPD-1919
	,@MensajeDespacho varchar(500) = null --EPD-1919
AS
/*
declare @retorno int
execute UpdEstadoCDRWeb 1,2,@retorno output
*/
BEGIN
	set @RetornoID = 0;
	set @CDRWebID = isnull(@CDRWebID, 0);
	set @Estado = isnull(@Estado, 0);
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	
	if	@CDRWebID > 0 and @Estado > 0
	begin
		update CDRWeb
		set
			Estado = @Estado
			,FechaCulminado = case when @Estado = 2 then @FechaGeneral else FechaCulminado end
			,FechaAtencion = case when @Estado = 2 then null else FechaAtencion end		
			,TipoDespacho = isnull(@TipoDespacho,0) --EPD-1919
			,FleteDespacho = isnull(@FleteDespacho,0.00) --EPD-1919
			,MensajeDespacho = isnull(@MensajeDespacho,'') --EPD-1919
		where CDRWebID = @CDRWebID;
		
		if @Estado = 2 or @Estado = 1
		begin
			update CDRWebDetalle
			set Estado = @Estado
			where CDRWebID = @CDRWebID;
			
			SET @RetornoID = 1;
		end
	end
END
GO