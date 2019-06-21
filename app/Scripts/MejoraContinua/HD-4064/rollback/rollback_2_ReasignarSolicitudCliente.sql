GO
USE BelcorpPeru
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpMexico
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpColombia
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpSalvador
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpPuertoRico
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpPanama
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpGuatemala
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpEcuador
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpDominicana
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpCostaRica
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpChile
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
USE BelcorpBolivia
GO

ALTER proc [dbo].[ReasignarSolicitudCliente]
(
@SolicitudId bigint,
@CodigoUbigeo VARCHAR(30),
@CampaniaID varchar(6),
@PaisID int,
@MarcaId INT,
@MotivoSolicitudId Int,
@RazonMotivoSolicitud Varchar(500)
)

as
begin
declare @TmpSolicitudCliente table ( ID BIGINT IDENTITY(1, 1), SolicitudClienteID BIGINT, NumIteracion INT, Estado char(1))
declare @TmpResultadoCliente table ( Resultado INT, Mensaje VARCHAR(500) )

DECLARE @CantidadRechazos int, @Definitivo int = 1
DECLARE @ConsultoraReasignada varchar(30)
DECLARE @ConsultoraReasignadaID bigint
declare @TmpConsultorasAsignadas table ( CodigoConsultora VARCHAR(30), MarcaID INT )

 SELECT @CantidadRechazos = CONVERT(INT, Codigo)
 FROM TablaLogicaDatos with(nolock)
 WHERE TablaLogicaDatosID = 5601

 DECLARE @numIteracion  INT,
    @CodigoConsultora VARCHAR(30),
    @ConsultoraID  BIGINT,
    @CodigoUbigeoSC  VARCHAR(30),
    @NombreCompleto  VARCHAR(110),
    @Email    VARCHAR(110),
    @Telefono   VARCHAR(110),
    @Mensaje   VARCHAR(810),
    @Campania   VARCHAR(10),
    @MarcaIDSC   INT,
    @Estado    CHAR(1),
	@Direccion VARCHAR(800)

SELECT @CodigoUbigeoSC = CodigoUbigeo,
     @NombreCompleto = NombreCompleto,
     @numIteracion = NumIteracion,
     @Email = Email,
     @Telefono = Telefono,
     @Mensaje = Mensaje,
     @Campania = Campania,
     @MarcaIDSC = MarcaID,
     @ConsultoraID = ConsultoraID  ,
     @Estado = Estado ,
	 @Direccion = Direccion
   FROM SolicitudCliente with(nolock)
   WHERE SolicitudClienteID = @SolicitudID


if @numIteracion < @CantidadRechazos
begin
 set @Definitivo = 0
 SELECT @ConsultoraReasignada = DBO.ObtenerConsultoraSolicitudCliente(@CodigoUbigeo, @CampaniaID, @PaisID, @MarcaId, null,@SolicitudId)
 select @ConsultoraReasignadaID = ConsultoraID from ods.Consultora where Codigo = @ConsultoraReasignada
 SET @numIteracion = @numIteracion + 1

 -- print 'Codigo de Nueva Consultora: ' + @ConsultoraReasignada

 IF( @ConsultoraReasignada <> '')
 begin

  DECLARE @SolicitudDetalle AS dbo.SolicitudDetalleType

  INSERT INTO @SolicitudDetalle (CUV, Producto, Cantidad, Precio, Tono)
  SELECT CUV, Producto, Cantidad, Precio, Tono FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudID

  INSERT INTO @TmpResultadoCliente
  EXEC RegistrarSolicitudCliente  @ConsultoraReasignada, @ConsultoraReasignadaID, @CodigoUbigeoSC, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, @MarcaIDSC, @numIteracion, @Direccion, @SolicitudDetalle

  Declare @Resultado varchar(100)
  Select top 1 @Resultado = Mensaje + ' / '+ Cast( t.Resultado as varchar(50)) from @TmpResultadoCliente t
  -- print 'Resultado de la inserción de la solicitud: ' + @Resultado
  -- print '@MarcaID es: ' + cast(@MarcaID as varchar(10))

  INSERT INTO @TmpConsultorasAsignadas VALUES (@ConsultoraReasignada, @MarcaID)

 end
 else
  set @Definitivo = 1
end
 Declare @Resultado2 varchar(100)
 Select  @Resultado2 = (Cast( ta.CodigoConsultora as  varchar(10)) + ' / '+ Cast( ta.MarcaID as  varchar(10))) from @TmpConsultorasAsignadas ta

 -- print 'Valor del @Definitivo es: ' + Cast( @Definitivo as  varchar(10))
 -- print 'cantidad de valores en la tabla @TmpConsultorasAsignadas:'  + Cast( @Resultado2 as  varchar(10))


exec  UpdRechazarSolicitud @SolicitudId,@Definitivo,@MotivoSolicitudId,@RazonMotivoSolicitud

 SELECT
  C.Codigo,
  C.PrimerNombre AS Nombre,
  U.Email,
  M.Descripcion AS MarcaNombre
 FROM @TmpConsultorasAsignadas TCON
 INNER JOIN Usuario U with(nolock) on TCON.CodigoConsultora = U.CodigoConsultora
 INNER JOIN ods.Consultora C with(nolock) ON U.CodigoConsultora = C.Codigo
 INNER JOIN Marca M with(nolock) ON TCON.MarcaId = M.MarcaId

end


GO
