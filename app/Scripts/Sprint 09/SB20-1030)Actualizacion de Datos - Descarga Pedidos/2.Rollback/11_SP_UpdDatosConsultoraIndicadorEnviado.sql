ALTER PROCEDURE UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
AS
BEGIN
	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if @Estado = 2
	begin
		update usuario
		set Modificado = 0
		where codigoconsultora in
		(
			select codigoconsultora
			from LogCargaConsultora
			where NroLote = @NroLote
		)
	end

	update ConsultoraDescarga
	set FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
END
GO