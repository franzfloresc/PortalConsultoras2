USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO

CREATE PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppDetaList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppDetaList]
GO
ALTER PROCEDURE [dbo].[ContenidoAppDetaList]
	@IdContenido int,
	@Codigo varchar(150)
AS
BEGIN
		IF @Codigo = 'HISTORIAS_RESUMEN'			
			SELECT  
				P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
				P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
				P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
				P.Seccion,Q.Codigo as DetaCodigo,
				Q.Descripcion as DetaAccionDescripcion,
				R.Descripcion as DetaCodigoDetalleDescripcion
			FROM dbo.ContenidoAppDeta AS P with(nolock)
			LEFT JOIN dbo.ContenidoAppDetaAct AS Q with(nolock) ON P.Accion = Q.Codigo
			LEFT JOIN dbo.ContenidoAppDetaAct AS R with(nolock) ON P.CodigoDetalle = R.Codigo
			WHERE
					P.IdContenido = @IdContenido AND
					P.Estado = 1
					order by P.Orden ASC;			
		ELSE IF @Codigo = 'GANA_EN_UN_CLICK'			
				 SELECT  
					P.IdcontenidoDeta,P.Idcontenido,P.CodigoDetalle,
					P.Descripcion,P.RutaContenido,P.Accion,P.Orden,
					P.Estado,P.Tipo,P.Campania,P.Region,P.Zona,
					P.Seccion					
				FROM dbo.ContenidoAppDeta AS P with(nolock)
				WHERE
						P.IdContenido = @IdContenido AND
						P.Estado = 1
						order by P.Orden ASC;
END

GO

