GO
CREATE FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO