GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT * from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO