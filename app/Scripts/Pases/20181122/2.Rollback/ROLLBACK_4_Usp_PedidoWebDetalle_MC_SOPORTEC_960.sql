USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[Usp_PedidoWebDetalle]
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
CAST(P.PedidoId AS VARCHAR(20)) AS PedidoId, CAST(P.PedidoDetalleID AS VARCHAR(20)) AS PedidoDetalleID,
CAST(ISNULL(P.ClienteID, ''0'') AS VARCHAR(25)) AS ClienteID, C.NombreCompleto,
CAST(P.Cuv AS VARCHAR(20)) AS Cuv, PC.Descripcion AS Producto,
M.Nombre AS Marca, CAST(P.Cantidad AS VARCHAR(20)) AS Cantidad,
CAST(P.PrecioUnidad AS VARCHAR(20)) AS PrecioUnidad,
CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
ISNULL(P.TipoPedido,'''') AS TipoPedido,
convert(varchar(10), p.fechacreacion, 103)+space(2)+convert(varchar(5), p.fechacreacion, 108) as FechaIngreso,
isnull(convert(varchar(10), p.fechamodificacion, 103)+space(2)+convert(varchar(5), p.fechamodificacion, 108),'''') as FechaActualizacion
FROM PedidoWebDetalle AS P
INNER JOIN ODS.Consultora AS C ON P.ConsultoraID = C.ConsultoraID
JOIN ODS.ProductoComercial AS PC ON P.CUV = PC.CUV
and pc.CampaniaID in (select CampaniaID from ods.campania where codigo=@CampaniaID) --Filtrando por campañaID ya que hay un mismo cup para varias campañas
JOIN ODS.Marca AS M ON P.MarcaID = M.MarcaID
join pedidoweb as pw on p.pedidoid = pw.pedidoid
and p.ConsultoraID=pw.ConsultoraID --Agregando cruce por consultora para no duplicar datos
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
' ORDER BY ' + @Orden +
') t ' +
' ORDER BY ' + @OrdenInverso +
') t ' +
' ORDER BY ' + @Orden
SET @ParametroSQL = '@FilasPagina int, ' +
'@Fila int, ' +
'@Filas int, ' +
'@CodigoConsultora VARCHAR(25), ' +
'@CampaniaID INT ,' +
'@CampaniaIDca INT'
EXECUTE sp_executesql @stmt = @SentenciaSQL,
@params = @ParametroSQL,
@FilasPagina = @FilasPagina,
@Fila = @Fila,
@Filas = @Cantidad,
@CodigoConsultora = @CodigoConsultora,
@CampaniaID = @CampaniaID,
@CampaniaIDca = @CampaniaIDca
END
GO

