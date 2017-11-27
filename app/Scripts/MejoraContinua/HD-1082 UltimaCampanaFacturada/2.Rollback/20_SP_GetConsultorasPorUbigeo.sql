GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
@PaisId int,    
@CodigoUbigeo varchar(24),    
@Campania int,    
@MarcaId int,
@tipoFiltroUbigeo int
AS    
BEGIN
   ---- VALIDANDO EDAD LIMITE SI LA MARCA ES CYZONE Y FILTRAMOS POR CAMPAÑA RECIBIDA    
   ----COMO PARÁMETRO  
   ----ESTE VALOR VA CAMBIAR SEGÚN EL VALOR QUE SE OBTENGA EN EL PASE    
    DECLARE @EDADLIMITE INT     
    SET @EDADLIMITE = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605    
    )   
  
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

   DECLARE @TerritorioObjetivo TABLE (TerritorioID INT)

  IF @tipoFiltroUbigeo = 2
   BEGIN
    INSERT INTO @TerritorioObjetivo
    SELECT  T.TERRITORIOID FROM dbo.TERRITORIO  T WHERE T.CODIGOUBIGEO = @CodigoUbigeo
   END 
   ELSE IF @tipoFiltroUbigeo = 3
   BEGIN
    INSERT INTO @TerritorioObjetivo
    SELECT TT.TERRITORIOID
        FROM dbo.TERRITORIO T
        INNER JOIN ods.UBIGEO U ON U.UBIGEOID = T.TERRITORIOID
        INNER JOIN ods.TERRITORIO TT ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
        WHERE T.CODIGOUBIGEO = @CodigoUbigeo
   END 
   ELSE 
   BEGIN 
    -- Cuando el parametro @tipoFiltroUbigeo <> 2 & 3 
    INSERT INTO @TerritorioObjetivo
    SELECT  T.TERRITORIOID FROM ods.TERRITORIO  T WHERE T.CODIGOUBIGEO = @CodigoUbigeo
   END 


  INSERT INTO #TempConsultoraUbigeo  
    SELECT   
     distinct    
    C.ConsultoraID,    
    C.Codigo,    
    @CodigoUbigeo as CodigoUbigeo,    
    C.NombreCompleto as NombreCompletoConsultora,    
    U.Email,       
    FechaNacimiento,    
    MONTOULTIMOPEDIDO,    
    UltimaCampanaFacturada, u.CodigoUsuario,c.ZonaID,c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC  
    ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE   
     C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo)  
     AND ACC.EsAfiliado = 1 --CO572 

    --R2442 -  JC - Ya no filtrará por Campaña actual  
    IF @MarcaId = 3    
    BEGIN    
    DELETE FROM #TempConsultoraUbigeo 
    WHERE ID IN(  
    SELECT ID FROM #TempConsultoraUbigeo  
    WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE) 
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT  ConsultoraID,Codigo,CodigoUbigeo,NombreCompletoConsultora as NombreCompleto,  
    Email  
    FROM #TempConsultoraUbigeo  
    WHERE  DBO.ValidarAutorizacion(@PaisId, CodigoUsuario)  = 3 AND(   
    dbo.GetMultipleCampaniaAnteriorPais((SELECT campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,ZonaID,RegionID,ConsultoraID)),@PaisId,1) = UltimaCampanaFacturada OR
    dbo.GetMultipleCampaniaAnteriorPais((SELECT campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,ZonaID,RegionID,ConsultoraID)),@PaisId,2) = UltimaCampanaFacturada )--R2626
    order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
   DROP TABLE #TempConsultoraUbigeo  
END
GO