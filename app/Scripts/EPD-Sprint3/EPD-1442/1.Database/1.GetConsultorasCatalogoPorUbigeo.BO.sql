
USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultorasCatalogosPorUbigeo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConsultorasCatalogosPorUbigeo]
GO

CREATE PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo    
 @PaisId int,    
 @CodigoUbigeo varchar(24),    
 @MarcaId int,    
 @tipoFiltroUbigeo int    
AS    
BEGIN    
 DECLARE @EdadLimite INT;    
 SELECT @EdadLimite = Codigo    
 FROM TABLALOGICADATOS    
 WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605;    
    
 DECLARE @AnioLimite INT;    
 SET @AnioLimite = YEAR(getdate()) - @EdadLimite;    
  
 DECLARE @UnidadGeografica1 VARCHAR(100) = '';    
 DECLARE @UnidadGeografica2 VARCHAR(100) = '';    
 DECLARE @UnidadGeografica3 VARCHAR(100) = '';    
   
 SELECT   
  @UnidadGeografica1 = ISNULL(UnidadGeografica1,''),  
  @UnidadGeografica2 = ISNULL(UnidadGeografica2,''), 
  @UnidadGeografica3 = ISNULL(UnidadGeografica3,'')  
 FROM   
 Ubigeo U   
 WHERE codigoubigeo = @CodigoUbigeo  
     
 DECLARE @TerritorioObjetivo TABLE (TerritorioID INT)    
 IF @tipoFiltroUbigeo = 2    
 BEGIN    
  INSERT INTO @TerritorioObjetivo    
  SELECT T.TERRITORIOID    
  FROM dbo.TERRITORIO T    
  WHERE T.CODIGOUBIGEO = @CodigoUbigeo    
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
  INSERT INTO @TerritorioObjetivo    
  SELECT T.TERRITORIOID    
  FROM ods.TERRITORIO T    
  WHERE T.CODIGOUBIGEO = @CodigoUbigeo    
 END    
       
  SELECT    
  C.Codigo AS CodigoConsultora,    
  C.ConsultoraID AS IdConsultora,    
  C.NombreCompleto,    
  C.ZonaID,    
  U.Email AS Correo,    
  U.Celular,    
  U.CodigoUsuario,    
  Z.Codigo AS CodigoZona,    
  R.Codigo AS CodigoRegion,    
  S.Codigo AS CodigoSeccion,    
  CC.FechaInicioFacturacion,    
  CC.CampaniaID AS CampaniaActual,    
  CC.HoraCierreZonaNormal AS HoraCierre,       
  ISNULL(UR.RolId,0) as RolId,    
  ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,    
  'S' as AutorizaPedido, -- when '1' then 'S'    
  ACC.EsAfiliado,    
  ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,    
  --ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,    
  @CodigoUbigeo as Ubigeo,  
  ISNULL(@UnidadGeografica1, '') AS UnidadGeografica1,  
  ISNULl(@UnidadGeografica2, '') AS UnidadGeografica2,  
  ISNULL(@UnidadGeografica3, '') AS UnidadGeografica3  
 FROM ods.consultora C with(nolock)    
 INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1    
 INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1    
 INNER JOIN ods.Zona
 Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1    
 INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1    
 INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora    
 LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario    
 CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC    
 WHERE    
  C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo)    
  AND    
  C.AutorizaPedido = '1'    
  AND    
  (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite)    
  AND    
  (    
   dbo.GetMultipleCampaniaAnteriorPais(CC.CampaniaId,@PaisId,1) = UltimaCampanaFacturada    
   OR    
   dbo.GetMultipleCampaniaAnteriorPais(CC.CampaniaId,@PaisId,2) = UltimaCampanaFacturada    
  )    
 ORDER BY    
  C.UltimaCampanaFacturada DESC,    
  C.MontoUltimoPedido DESC    
END    
  

