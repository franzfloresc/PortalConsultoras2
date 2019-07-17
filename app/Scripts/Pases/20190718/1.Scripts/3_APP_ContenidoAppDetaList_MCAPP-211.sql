USE BelcorpPeru
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

USE BelcorpMexico
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

