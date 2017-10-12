GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT * from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO