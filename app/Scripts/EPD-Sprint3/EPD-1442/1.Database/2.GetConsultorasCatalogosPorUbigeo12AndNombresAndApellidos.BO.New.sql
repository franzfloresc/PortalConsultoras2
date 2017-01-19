USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos]
GO


CREATE PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo12AndNombresAndApellidos  
 @PaisId int,  
 @CodigoUbigeo varchar(12),  
 @Nombres varchar(51),  
 @Apellidos varchar(51),  
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
  
 DECLARE @TerritorioObjetivo TABLE (TerritorioID INT, CodigoUbigeo VARCHAR(24))  
 IF @tipoFiltroUbigeo = 2  
 BEGIN  
  INSERT INTO @TerritorioObjetivo(TerritorioID,CodigoUbigeo)  
  SELECT T.TERRITORIOID, T.CODIGOUBIGEO  
  FROM dbo.TERRITORIO T  
  WHERE T.CODIGOUBIGEO LIKE CONCAT(@CodigoUbigeo,'%');  
 END  
 ELSE IF @tipoFiltroUbigeo = 3  
 BEGIN  
  INSERT INTO @TerritorioObjetivo(TerritorioID,CodigoUbigeo)  
  SELECT TT.TERRITORIOID, T.CODIGOUBIGEO  
  FROM dbo.TERRITORIO T  
  INNER JOIN ods.UBIGEO U ON U.UBIGEOID = T.TERRITORIOID  
  INNER JOIN ods.TERRITORIO TT ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO  
  WHERE T.CODIGOUBIGEO LIKE CONCAT(@CodigoUbigeo,'%');  
 END  
 ELSE  
 BEGIN  
  INSERT INTO @TerritorioObjetivo(TerritorioID,CodigoUbigeo)  
  SELECT T.TERRITORIOID, T.CODIGOUBIGEO  
  FROM ods
.TERRITORIO T  
  WHERE T.CODIGOUBIGEO LIKE CONCAT(@CodigoUbigeo,'%');  
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
  TOb.CodigoUbigeo as Ubigeo,
  UBE.UnidadGeografica1,
  UBE.UnidadGeografica2,
  UBE.UnidadGeografica3
 FROM ods.consultora C with(nolock)  
 INNER JOIN @TerritorioObjetivo TOb ON C.TerritorioID = TOb.TerritorioID   
 INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) ON C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1  
 INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1  
 INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1  
 INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1  
 INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora   
 LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario  
 LEFT JOIN Ubigeo UBE with(nolock) ON TOb.CodigoUbigeo = UBE.CodigoUbigeo 
 CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC  
 WHERE  
  C.AutorizaPedido = '1'  
  AND  
  CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%')  
  AND  
  CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%')    
  AND  
  (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) 
END  


