
USE [BelcorpBolivia]
GO




ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]

(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;






GO




USE [BelcorpChile]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO




USE [BelcorpColombia]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpCostaRica]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpDominicana]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpEcuador]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpGuatemala]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpMexico]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpPanama]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpPeru]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpPuertoRico]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO

USE [BelcorpSalvador]
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalleSeguimiento]
(

@FilasPagina INT, 

@Fila INT, 

@Cantidad INT, 

@ColumnaOrden VARCHAR (50), 

@DireccionOrden VARCHAR (5),

@CodigoConsultora VARCHAR(25),

@CampaniaID INT

)

AS

BEGIN

DECLARE @CampaniaIDca INT

SET @CampaniaIDca = (SELECT CampaniaID FROM ODS.Campania where Codigo = @CampaniaID)



DECLARE @OrdenInverso nvarchar(1024)    

	DECLARE @SentenciaSQL nvarchar(3072)   

	DECLARE @SentenciaPrincipal nvarchar(3072)   

	DECLARE @ParametroSQL nvarchar(512)    

	DECLARE @Orden sysname    



	SET @Orden = @ColumnaOrden + ' ' + @DireccionOrden  

	SET @OrdenInverso = @ColumnaOrden + ' ' + CASE WHEN @DireccionOrden = 'DESC' THEN 'ASC' ELSE 'DESC' END 



	SET @SentenciaPrincipal = ' 

								CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoSeguimientoID AS VARCHAR(20)) AS PedidoSeguimientoID, 

								CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID, C.NombreCompleto,

								CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto, M.Nombre AS Marca, CAST(ISNULL(P.Cantidad, ''0'') AS VARCHAR(20)) AS Cantidad, 

								CAST(P.AccionId AS VARCHAR(20)) AS AccionId, CONVERT( VARCHAR(10),P.FechaAccion  , 103) +space(2)+CONVERT( VARCHAR(5),P.FechaAccion  , 108) AS FechaAccion

								FROM PedidoWebDetalleSeguimiento AS P

								INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID

								JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV

								JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID

								WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID

								AND PC.CampaniaID = @CampaniaIDca'





   SET @SentenciaSQL = '

		DECLARE @Residuo int ' +    

		'SET @Residuo = @Filas % @FilasPagina ' +    

		'SELECT * ' + 

		'FROM (' +    

		'SELECT TOP (CASE WHEN @Residuo = 0 AND @Filas>0 ' +    

		'OR @Filas / @FilasPagina > @Fila / @FilasPagina ' +    

		'THEN @FilasPagina ELSE @Residuo END) * ' +    

		'FROM(' +

		'SELECT TOP (@FilasPagina + @Fila) ' +

         @SentenciaPrincipal +

		 '  ORDER BY ' + @Orden +

         ') t ' +

         '  ORDER BY ' + @OrdenInverso +

	     ') t ' +

         '  ORDER BY ' + @Orden



		SET @ParametroSQL = '@FilasPagina int, ' +    

						    '@Fila int, ' +

						    '@Filas int, ' + 

							'@CodigoConsultora VARCHAR(25), ' +

							'@CampaniaID INT ,' +

							'@CampaniaIDca INT'







EXECUTE sp_executesql @stmt             = @SentenciaSQL,    

					  @params           = @ParametroSQL,    

					  @FilasPagina      = @FilasPagina,    

					  @Fila             = @Fila, 

					  @Filas            = @Cantidad,

					  @CodigoConsultora = @CodigoConsultora,

					  @CampaniaID       =  @CampaniaID,

					  @CampaniaIDca     = @CampaniaIDca  





END;





GO
