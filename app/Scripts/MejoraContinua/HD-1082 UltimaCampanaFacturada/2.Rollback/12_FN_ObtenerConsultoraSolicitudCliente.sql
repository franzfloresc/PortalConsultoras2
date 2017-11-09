GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]        
(      
 @CodigoUbigeo VARCHAR(30),      
 @CampaniaID  VARCHAR(6),      
 @PaisID   INT,      
 @MarcaID  INT ,  
 @Paises varchar(150) = null,
 @SolicitudClienteID BIGINT
)     
    
RETURNS VARCHAR(30)      
AS      
BEGIN      
 DECLARE @EdadMaxima   INT,      
   @intTotalCampanias INT,      
   @CodigoConsultora VARCHAR(50) ,  
   @FiltroUbigeo int   
    

--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT
	SET @SolicitudCLienteOrigen= (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END
	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT)
	BEGIN
		INSERT INTO @TmpConsultorasID 
		SELECT ConsultoraID 
		FROM SolicitudCliente WITH(NOLOCK)
		WHERE SolicitudClienteID IN (
			  SELECT SolicitudClienteID 
			  from SolicitudCliente 
			  where SolicitudClienteID=@SolicitudCLienteOrigen
				 OR SolicitudClienteOrigen=@SolicitudCLienteOrigen)
	END
-----------------------------------

   SELECT @FiltroUbigeo = CONVERT(INT, Codigo)     
   FROM TablaLogicaDatos with(nolock)    
   WHERE TablaLogicaDatosID = 6601     
        
  
    
 SET @intTotalCampanias = (SELECT NroCampanias FROM dbo.Pais WHERE PaisID = @PaisID)        
 IF @MarcaID = 3    
  SELECT @EdadMaxima = codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 5605      
 ELSE      
  SET @EdadMaxima = 100      
  
 DECLARE @PaisActivo char(2)    
     
 select @PaisActivo = CodigoISO from Pais Where EstadoActivo = 1   
  
 if  @Paises = null  
 select @Paises = Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606    
     
 IF(CHARINDEX(@PaisActivo,@Paises) >0)    
 BEGIN    
   
 if @FiltroUbigeo = 1  
  begin  
   SELECT TOP 1 @CodigoConsultora = co.Codigo   
   FROM ods.Consultora CO       
    INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
    INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
   WHERE      
     CO.ZonaID IN   
     (SELECT DISTINCT T.ZonaID FROM ods.Territorio T  
     INNER JOIN  dbo.Ubigeo U on u.CodigoUbigeo = t.CodigoUbigeo  
     WHERE u.CodigoUbigeo = @CodigoUbigeo)    
    AND ACC.EsAfiliado = 1      
    AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3     
    AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
    AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
    AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
  ORDER BY MontoUltimoPedido DESC  
 End  
 else  
 begin  
  if @FiltroUbigeo = 2  
   begin  
     SELECT TOP 1 @CodigoConsultora = co.Codigo   
     FROM ods.Consultora CO       
      INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
      INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
     WHERE      
       CO.ZonaID IN   
       (SELECT DISTINCT T.ZonaID FROM ods.Territorio T  
       inner join dbo.Territorio tt on tt.TerritorioID = t.TerritorioID  
       INNER JOIN  dbo.Ubigeo U on u.CodigoUbigeo = t.CodigoUbigeo  
       WHERE u.CodigoUbigeo = @CodigoUbigeo)    
      AND ACC.EsAfiliado = 1      
      AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3    
      AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
      AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
      AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
    ORDER BY MontoUltimoPedido DESC  
   end  
  else  
   begin   
   SELECT TOP 1 @CodigoConsultora = co.Codigo   
     FROM ods.Consultora CO       
      INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
      INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
     WHERE      
       CO.ZonaID IN   
       (SELECT DISTINCT T.ZonaID FROM ods.Territorio T  
       inner join ods.Ubigeo OU  on ou.CodigoUbigeo = t.CodigoUbigeo  
       inner join dbo.Territorio tt on tt.TerritorioID = OU.UbigeoID  
       INNER JOIN  dbo.Ubigeo U on u.CodigoUbigeo = tt.CodigoUbigeo  
       WHERE u.CodigoUbigeo = @CodigoUbigeo)    
      AND ACC.EsAfiliado = 1      
      AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3    
      AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
      AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
      AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
    ORDER BY MontoUltimoPedido DESC  
   End  
 End   
  
 END    
 ELSE    
 BEGIN    
 if @FiltroUbigeo = 1  
 begin  
   SELECT TOP 1 @CodigoConsultora = co.Codigo        
   FROM ods.Consultora CO       
    INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID     
    INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
   WHERE      
     TerritorioID IN   
     (SELECT TerritorioID FROM ods.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)     
    AND ACC.EsAfiliado = 1      
    AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3     
    AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
    AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
    AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
   ORDER BY MontoUltimoPedido DESC   
  end  
  else  
  begin  
  if @FiltroUbigeo = 2  
  begin  
    SELECT TOP 1 @CodigoConsultora = co.Codigo      
    FROM ods.Consultora CO       
     INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID     
     INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
    WHERE      
      TerritorioID IN   
      (SELECT TerritorioID FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)     
     AND ACC.EsAfiliado = 1      
     AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3     
     AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
     AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
     AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
    ORDER BY MontoUltimoPedido DESC   
   end  
   else  
   begin  
   SELECT TOP 1 @CodigoConsultora = co.Codigo      
    FROM ods.Consultora CO       
     INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID     
     INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo      
    WHERE      
      TerritorioID IN   
      (SELECT t.TerritorioID FROM ods.Territorio t   
      inner join ods.Ubigeo u on u.CodigoUbigeo = t.CodigoUbigeo  
      inner join dbo.Territorio tt on tt.TerritorioID = u.UbigeoID  
      WHERE tt.CodigoUbigeo = @CodigoUbigeo)     
     AND ACC.EsAfiliado = 1      
     AND dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3     
     AND DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima      
     AND UltimaCampanaFacturada = dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias)      
     AND CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)      
    ORDER BY MontoUltimoPedido DESC   
   end  
      
  end   
 END    
    
 RETURN ISNULL(@CodigoConsultora, '')    
    
END   
GO