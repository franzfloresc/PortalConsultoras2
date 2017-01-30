USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultorasPorZona]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetConsultorasPorZona]
GO


CREATE PROCEDURE dbo.GetConsultorasPorZona  
 @PaisId INT,  
 @CodigoRegion VARCHAR(8),  
 @CodigoZona VARCHAR(8)  
AS  
BEGIN     
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
  ISNULL(UB.CodigoUbigeo,'')Ubigeo, --EPD-240  
  ISNULL(UR.RolId,0) as RolId,  
  ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,  
  'S' as AutorizaPedido, -- when '1' then 'S'  
  ACC.EsAfiliado,  
  ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
  ISNULL(UB.UnidadGeografica1,'') AS UnidadGeografica1,
  ISNULL(UB.UnidadGeografica2,'') AS UnidadGeografica2,
  ISNULL(UB.UnidadGeografica3,'') AS UnidadGeografica3  --ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual  
 FROM ods.consultora C with(nolock)  
 INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1  
 INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.Codigo = @CodigoRegion AND R.EstadoActivo = 1  
 INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.Codigo = @CodigoZona AND Z.EstadoActivo = 1  
 INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1  
 INNER JOIN ods.Territorio T with(nolock) ON C.TerritorioID = T.TerritorioID AND T.EstadoActivo = 1  
 INNER JOIN ods.Ubigeo UB with(nolock) ON T.CodigoUbigeo = UB.CodigoUbigeo -------EPD-240  
 INNER JOIN usuario U with(nolock) ON C
.Codigo = U.CodigoConsultora  
 LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario  
 CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC  
 WHERE  
  C.AutorizaPedido = '1'  
  AND  
  (    
dbo.GetMultipleCampaniaAnteriorPais(CC.CampaniaId,@PaisId,1) = UltimaCampanaFacturada  
   OR  
   dbo.GetMultipleCampaniaAnteriorPais(CC.CampaniaId,@PaisId,2) = UltimaCampanaFacturada  
  )  
 ORDER BY  
  C.UltimaCampanaFacturada DESC,  
  C.MontoUltimoPedido DESC;  
END  


