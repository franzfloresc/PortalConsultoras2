GO
USE BelcorpPeru
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpMexico
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpColombia
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpPanama
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpChile
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.RegistrarSolicitudCliente
 @CodigoConsultora VARCHAR(30),
 @ConsultoraID  BIGINT,
 @CodigoUbigeo  VARCHAR(40),
 @NombreCompleto  VARCHAR(110),
 @Email    VARCHAR(110),
 @Telefono   VARCHAR(110),
 @Mensaje   VARCHAR(810),
 @Campania   VARCHAR(6),
 @MarcaID   INT,
 @NumIteracion  INT,
 @Direccion varchar(800),
 @SolicitudDetalle dbo.SolicitudDetalleType READONLY,
 @SolicitudClienteOrigen BIGINT = null
AS
BEGIN
/*------------------------------------------------------------------------------------------------------------------------------------------------

Nombre    : RegistrarSolicitudCliente.
Objetivo   : Registrar las solicitudes de la cliente.
Valores Prueba  :
      DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

      --INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00009', 'ES LL HIDRACO ROSA ROMANTICA', 2, 3.5)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00006', 'LB ESS DEMQ CC 125 ML', 7, 12.90)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00008', 'ES CARDIGAN EDT CL 100 ML', 2, 25.3)
      INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio) VALUES ('00023', 'ES IMANEM EDT 100 ML', 3, NULL)
      EXEC RegistrarSolicitudCliente  '0005477', 585, '000013000001000300',
              'MARCELA DEL CARMEN VALENZUELA QUEZADA', 'amilcar.huaman@gmail.com',
              97984651325, 'Mensaje a la consultora', 201501, 2, 1, @SolicitudDetalle
      GO
      SELECT * FROM SolicitudCliente
      SELECT * FROM SolicitudClienteDetalle
      SELECT * FROM SolicitudClienteLog
      SELECT * FROM SolicitudClienteDetalleLog
      SELECT * FROM ods.Consultora where ConsultoraID = 585
      SELECT * FROM ods.Territorio WHERE TerritorioID = 17790
Creacion   : CGI(AAHA) 20140813.
Ultima Modificación :
-------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @SolicitudClienteID   BIGINT,
  @MensajeResultado   VARCHAR(500),
  @SolicitudClienteLogID  BIGINT,
  @MensajeResultadoDetalle VARCHAR(500),
  @flagDetalle    BIT,
  @TerritorioID    INT


SET @SolicitudClienteID = 0
SET @SolicitudClienteLogID = 0
SET @flagDetalle = 0
SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

BEGIN TRY

 SET @MensajeResultado = ''

 IF @CodigoConsultora IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
 ELSE IF LEN(@CodigoConsultora) > 20
  SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
  SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

 IF @ConsultoraID IS NULL OR @ConsultoraID = 0
  SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
 ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
 --JICM(Validaciones Obs R2319
 ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
  SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

 IF @CodigoUbigeo IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
 --ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Territorio WHERE CodigoUbigeo = @CodigoUbigeo)
 ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
  SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
  --JICM(Validaciones Obs R2319
 --ELSE IF RTRIM(@CodigoUbigeo) <> (SELECT top 1 RTRIM(CodigoUbigeo) FROM ods.Territorio where codigoubigeo=@CodigoUbigeo)
  --SET @MensajeResultado = @MensajeResultado + 'El Código de Ubigeo no está asociado con el ID de Consultora.|'
 --

 IF @NombreCompleto IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
 ELSE IF LEN(@NombreCompleto) > 100
  SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'


 IF @Email IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
 ELSE IF LEN(@Email) > 100
  SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

 IF @Telefono IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
 ELSE IF LEN(@Telefono) > 100
  SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

 IF @Mensaje IS NULL
  SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
 ELSE IF LEN(@Mensaje) > 800
  SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

 IF @Campania IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
 ELSE
 BEGIN
  IF @Campania IS NOT NULL AND LEN(@Campania) > 6
   SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
  ELSE IF @Campania IS NOT NULL AND NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
   SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'
 END

 IF @MarcaID IS NULL
  SET @MensajeResultado = @MensajeResultado + 'La marca no fue ingresada.|'
 ELSE
 BEGIN
  IF NOT EXISTS(SELECT MarcaID FROM ods.Marca WHERE MarcaID IN (@MarcaID))
   SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + CAST(@MarcaID AS VARCHAR(2)) + '.|'
  ELSE IF @MarcaID NOT IN (1, 2, 3)
   SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
 END

  DECLARE @UnidGeo1 VARCHAR(100),
      @UnidGeo2 VARCHAR(100),
      @UnidGeo3 VARCHAR(100)

  SELECT TOP 1 @UnidGeo1 = UnidadGeografica1 ,
      @UnidGeo2 = UnidadGeografica2 ,
      @UnidGeo3 = UnidadGeografica3
  FROM dbo.Ubigeo
  WHERE CodigoUbigeo = @CodigoUbigeo

  DECLARE @TipoDistribucion SMALLINT,
      @CodigoTipoDistribucion VARCHAR(10)

  SELECT @CodigoTipoDistribucion = Codigo FROM TablaLogicaDatos
  WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68

  SET @TipoDistribucion = CAST( @CodigoTipoDistribucion AS SMALLINT)


 IF @MensajeResultado <> ''
  EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID,0,@Direccion, @SolicitudClienteLogID OUTPUT
 ELSE
 BEGIN


  INSERT INTO SolicitudCliente
  (ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen, Direccion)
  VALUES
  (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaID, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion)

  SET @SolicitudClienteID = @@IDENTITY
  SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.'

	--********************************Buscar el cliente origen**************************
	IF @SolicitudClienteOrigen is null
	BEGIN
		SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
		IF @SolicitudClienteOrigen <> 0
		BEGIN
			UPDATE SolicitudCliente
			SET SolicitudClienteOrigen=@SolicitudClienteOrigen
			WHERE SolicitudClienteID=@SolicitudClienteID;
		END
	END
	--*********************************************************************************************************

  EXEC RegistrarSolicitudClienteLog @SolicitudClienteID, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteOrigen, @Direccion, @SolicitudClienteLogID OUTPUT


  DECLARE @CUV  VARCHAR(10),
    @Producto VARCHAR(100),
    @Cantidad INT,
    @Precio  DECIMAL(20, 2),
	@Tono VARCHAR(800),
    @i   INT,
    @total  INT


  DECLARE @TempSolicitudClienteDetalle TABLE
  (
   ID   INT IDENTITY(1, 1),
   CUV   VARCHAR(50),
   Producto VARCHAR(500),
   Cantidad INT,
   Precio  DECIMAL(20, 2),
   ---se registra el Tono
   Tono VARCHAR(800)
  )



  INSERT INTO @TempSolicitudClienteDetalle(CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM @SolicitudDetalle

  SET @i = 1
  SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)


  WHILE @i <= @total
  BEGIN
   SET @CUV  = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Producto = (SELECT Producto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Precio  = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
   SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)

   SET @MensajeResultadoDetalle = ''

   /*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/



   IF @Producto IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

   IF @Cantidad IS NULL
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la cantidad del producto solicitado.|'
   ELSE IF @Cantidad <= 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

   IF @Precio IS NOT NULL AND @Precio < 0
    SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'

   IF @MensajeResultadoDetalle <> ''
   BEGIN
    -- Insertar el log del detalle. ERROR
    SET @flagDetalle = 1
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono)
   END
   ELSE
   BEGIN
    SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.'
    -- Insertar el log del detalle. CORRECTO
    INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, FechaCreacion, Tono)
	VALUES (@SolicitudClienteID, @CUV, @Producto, @Cantidad, @Precio, getDate(), @Tono);
    INSERT INTO SolicitudClienteDetalleLog (SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, Tono)
	VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @Producto, @Cantidad, @Precio, @Tono);
   END

   SET @i = @i + 1
  END
 END



 IF @flagDetalle = 1
 BEGIN
  SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.'
  DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID
  DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID
  UPDATE SolicitudClienteLog SET SolicitudClienteID = NULL, Descripcion = @MensajeResultado WHERE SolicitudClienteLogID = @SolicitudClienteLogID

  SET @SolicitudClienteID = 0
 END

 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje


END TRY
BEGIN CATCH

 SET @MensajeResultado = ERROR_MESSAGE()  + ERROR_LINE()
 SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje

 EXEC RegistrarSolicitudClienteLog NULL, @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto,
    @Email, @Telefono, @Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, @MarcaID, @SolicitudClienteLogID OUTPUT

END CATCH

END


GO
