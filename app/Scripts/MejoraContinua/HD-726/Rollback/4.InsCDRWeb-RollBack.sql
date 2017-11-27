USE BelcorpPeru
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.InsCDRWeb
(
@CDRWebID int
,@PedidoID int
,@PedidoNumero int
,@CampaniaID int
,@ConsultoraID int
--,@FechaRegistro datetime
--,@Estado int
--,@FechaCulminado datetime
,@Importe decimal(9,2)
,@TipoDespacho bit  = null --EPD-1919
,@FleteDespacho decimal(15,2) = null --EPD-1919
,@MensajeDespacho varchar(500) = null --EPD-1919
,@RetornoID int output
)
AS
BEGIN
SET @RetornoID = 0
DECLARE @FechaGeneral DATETIME
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if	@CDRWebID = 0
begin
insert into CDRWeb
(
PedidoID
,PedidoNumero
,CampaniaID
,ConsultoraID
,FechaRegistro
,Estado
,FechaCulminado
,Importe
,TipoDespacho --EPD-1919
,FleteDespacho --EPD-1919
,MensajeDespacho -- EPD-1919
)
values
(
@PedidoID
,@PedidoNumero
,@CampaniaID
,@ConsultoraID
,@FechaGeneral
,'1'
,NULL
,NULL
,@TipoDespacho -- EPD-1919
,@FleteDespacho --EPD-1919
,@MensajeDespacho --EPD-1919
)

SET @RetornoID = SCOPE_IDENTITY();
end
else
begin
SET @RetornoID = @CDRWebID;
end
END
GO

