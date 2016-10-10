USE BelcorpSalvador
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'OrigenPedidoWeb') = 0
		ALTER TABLE dbo.PedidoWebDetalle 
		ADD OrigenPedidoWeb int
go

--TABLAS

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OfertaFinalConsultora_Log]') AND (type = 'U') )
	DROP TABLE [dbo].[OfertaFinalConsultora_Log]
GO

CREATE TABLE dbo.OfertaFinalConsultora_Log
(
	OfertaFinalConsultoraID INT PRIMARY KEY IDENTITY(1,1),
	campaniaID INT,
	codigoConsultora VARCHAR(20),
	CUV VARCHAR(20),
	cantidad INT,
	Fecha DATETIME,
	TipoOfertaFinal VARCHAR(4),
	GAP DECIMAL(18,2)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CatalogoPersonalizadoRegionZona]') AND (type = 'U') )
	DROP TABLE [dbo].CatalogoPersonalizadoRegionZona
GO

create table dbo.CatalogoPersonalizadoRegionZona
(
	CatalogoPersonalizadoRegionZonaID int primary key identity(1,1),
	CodigoRegion varchar(2),
	CodigoZona varchar(4),
	Estado bit
)

go

--FIN TABLAS

--SINONIMOS
IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[ProductosLanzamiento]') AND (type = N'SN') )
	DROP SYNONYM [ods].[ProductosLanzamiento]
GO

CREATE SYNONYM [ods].[ProductosLanzamiento] FOR [ODS_SV].[dbo].[ProductosLanzamiento]
GO
--FIN SINONIMOS

--PROCEDURES

ALTER PROCEDURE [dbo].InsPedidoWebDetalle_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@ClienteID smallint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@PedidoID int,
	@OfertaWeb bit,
	@ConfiguracionOfertaID int,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
	declare @orden int = 0

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		, @orden = max(ISNULL(OrdenPedidoWD,0))
	FROM dbo.PedidoWebDetalle 
	WHERE 
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @orden = ISNULL(@orden, 0) + 1

	INSERT INTO dbo.PedidoWebDetalle 
	(CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
	ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
	CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb)
	VALUES 
	(@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
	@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
	@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb)

END
GO

ALTER PROCEDURE dbo.UpdPedidoWebDetalle_SB2
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN
	
	if @OrdenPedidoWD = 1
	begin
		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else 
		set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		OrigenPedidoWeb = @OrigenPedidoWeb
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID

END
GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

Declare @CantidadActual int 

	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					  END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),
	OrigenPedidoWeb = @OrigenPedidoWeb
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[registrarLogOfertaFinal_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].registrarLogOfertaFinal_SB2
GO

CREATE PROCEDURE [dbo].registrarLogOfertaFinal_SB2
	@CampaniaID int,
	@CodigoConsultora varchar(20),
	@CUV varchar(20),
	@Cantidad int,
	@TipoOfertaFinal varchar(4),
	@GAP decimal(18,2)
AS	
BEGIN		
	INSERT INTO dbo.OfertaFinalConsultora_Log(campaniaID, codigoConsultora, CUV, cantidad, Fecha, TipoOfertaFinal, GAP)
	VALUES(@CampaniaID, @CodigoConsultora, @CUV, @Cantidad, GETDATE(), @TipoOfertaFinal, @GAP)
END
GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]      
 @CampaniaID INT,          
 @ConsultoraID BIGINT          
AS          
/*          
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031          
*/          
BEGIN          
 SET NOCOUNT ON          
  -- Depuramos las tallas y colores          
   EXEC DepurarTallaColorCUV @CampaniaID         
   EXEC DepurarTallaColorLiquidacion @CampaniaID          
 /*Para Nuevas obtener el numero de pedido de la consultora.*/        
 DECLARE @NumeroPedido  INT        
 SELECT @NumeroPedido = consecutivonueva + 1        
 FROM ods.Consultora         
 WHERE ConsultoraID=@ConsultoraID        
 /*Revisar si la consultora pertenece al programa Nuevas.*/          
 DECLARE @ProgramaNuevoActivado INT        
 DECLARE @CodigoPrograma  VARCHAR(3)        
         
 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),         
   @CodigoPrograma = CP.CodigoPrograma        
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora        
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1        
 GROUP BY C.ConsultoraID, CP.CodigoPrograma        
         
  SELECT pwd.CampaniaID,          
      pwd.PedidoID,           
      pwd.PedidoDetalleID,           
      isnull(pwd.MarcaID,0) as MarcaID,           
      pwd.ConsultoraID,          
      pwd.ClienteID,      
   pwd.OrdenPedidoWD,           
      pwd.Cantidad,           
      pwd.PrecioUnidad,           
      pwd.ImporteTotal,           
      pwd.CUV,         
      pwd.EsKitNueva,         
      CASE          
  WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV           
  ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,         
      c.Nombre,           
      pwd.OfertaWeb,          
      pc.IndicadorMontoMinimo,          
      ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,          
      ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,          
      ISNULL(pwd.TipoPedido, 'W') TipoPedido,          
      CASE          
  WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN          
  (          
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O           
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID           
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID          
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1        
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID              
     WHERE          
     TE.FLAGACTIVO = 1           
    AND O.CODIGOOFERTA = pc.codigotipooferta          
    AND T.CUV = pwd.CUV          
  )          
  ELSE          
  (    
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O           
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID           
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID          
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1            
     WHERE       
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)               
     AND TE.FLAGACTIVO = 1           
    AND O.CODIGOOFERTA = pc.codigotipooferta   
    AND E.CUV2 = pwd.CUV         
  )          
  END DescripcionOferta,          
   M.Descripcion AS DescripcionLarga, --R2469        
   'NO DISPONIBLE' AS Categoria, --R2469        
   TE.DescripcionEstrategia as DescripcionEstrategia, --R2469        
 CASE WHEN TE.FlagNueva =1 THEN         
  CASE WHEN @ProgramaNuevoActivado > 0 THEN 1         
  END        
  ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621        
 PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/     
 PW.DescuentoProl, 
 PW.MontoEscala, 
 PW.MontoAhorroCatalogo, 
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb      
 FROM dbo.PedidoWebDetalle pwd          
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID      
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV          
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID          
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV            
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV          
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP          
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID          
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin        
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))       
   AND EST.Activo=1       
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)         
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)         
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID           
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)       
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId        
 WHERE pwd.CampaniaID = @CampaniaID          
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL       
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC          
 SET NOCOUNT OFF          
END 

go

--FIN PROCEDURES

--SHOWROOM

if not exists (select 1 from ConfiguracionOferta where Descripcion = 'Show Room')
begin

insert into dbo.ConfiguracionOferta (TipoOfertaSisID,CodigoOferta,Descripcion,EstadoRegistro) 
values (1707,'105','Show Room',1)

end

go

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'ShowRoom')
	DROP SCHEMA [ShowRoom]
go

CREATE SCHEMA [ShowRoom]

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'EventoConsultoraType') = 0  
  CREATE TYPE ShowRoom.EventoConsultoraType AS TABLE ( 
	EventoConsultoraID int, EventoID int, CampaniaID int, CodigoConsultora varchar(20), Segmento varchar(50), MostrarPopup bit,
	FechaCreacion datetime, UsuarioCreacion varchar(20), FechaModificacion datetime, UsuarioModificacion varchar(20))
GO

if exists (select 1 from sysobjects where id = object_id('ShowRoom.Evento') and type = 'U')
   drop table ShowRoom.Evento
go

if exists (select 1 from sysobjects where id = object_id('ShowRoom.EventoConsultora') and type = 'U')
   drop table ShowRoom.EventoConsultora
go

create table ShowRoom.Evento(
	EventoID int identity(1,1) primary key,
	CampaniaID int,
	Nombre varchar(150),
	Imagen1 varchar(150),
	Imagen2 varchar(150),
	Descuento decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(20),
	FechaModificacion datetime,
	UsuarioModificacion varchar(20),
	TextoEstrategia varchar(150),
	OfertaEstrategia decimal(18,2),
	Tema varchar(150),
	DiasAntes int,
	DiasDespues int,
	NumeroPerfiles int,
	ImagenCabeceraProducto varchar(150),
	ImagenVentaSetPopup varchar(150),
	ImagenVentaTagLateral varchar(150),
	ImagenPestaniaShowRoom varchar(150),
	Estado int,
	RutaShowRoomPopup varchar(500),
	RutaShowRoomBannerLateral varchar(500),
	ImagenPreventaDigital varchar(150)
)

go

create table ShowRoom.EventoConsultora
(
	EventoConsultoraID int identity(1,1) primary key,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20),
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

go

CREATE NONCLUSTERED INDEX IX_ShowroomConsultora ON Showroom.Eventoconsultora (CodigoConsultora);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Perfil]') AND (type = 'U') )
	DROP TABLE [ShowRoom].[Perfil]
GO

create table ShowRoom.Perfil
(
	PerfilID int primary key identity(1,1),
	PerfilDescripcion varchar(150),
	EventoID int
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoom]') AND (type = 'U') )
	DROP TABLE [ShowRoom].[OfertaShowRoom]
GO

create table ShowRoom.OfertaShowRoom
(
	OfertaShowRoomID int primary key identity(1,1),
	CampaniaID int,
	CUV varchar(20),
	TipoOfertaSisID int,
	ConfiguracionOfertaID int,
	Descripcion varchar(250),
	PrecioOferta numeric,
	Stock int,
	StockInicial int,
	ImagenProducto varchar(150),
	Orden int,
	UnidadesPermitidas int,
	FlagHabilitarProducto bit,
	DescripcionLegal varchar(250),
	CategoriaID varchar(20),
	DescripcionProducto1 varchar(250),
	DescripcionProducto2 varchar(250),
	DescripcionProducto3 varchar(250),
	ImagenProducto1 varchar(150),
	ImagenProducto2 varchar(150),
	ImagenProducto3 varchar(150),
	PerfilID int,
	UsuarioRegistro varchar(50),
	FechaRegistro datetime,
	UsuarioModificacion varchar(50),
	FechaModificacion datetime,
	ImagenMini varchar(150)
)

go

ALTER TABLE ShowRoom.OfertaShowRoom  WITH CHECK ADD FOREIGN KEY([ConfiguracionOfertaID])
REFERENCES [dbo].[ConfiguracionOferta] ([ConfiguracionOfertaID])
GO

--ALTER TABLE ShowRoom.OfertaShowRoom  WITH CHECK ADD FOREIGN KEY([PerfilID])
--REFERENCES [ShowRoom].[Perfil] ([PerfilID])
--GO

ALTER TABLE ShowRoom.OfertaShowRoom  WITH CHECK ADD  CONSTRAINT [CK_Vendor_Stock] CHECK  (([Stock]>=(0)))
GO

ALTER TABLE ShowRoom.OfertaShowRoom CHECK CONSTRAINT [CK_Vendor_Stock]
GO

CREATE NONCLUSTERED INDEX IX_ShowroomOfertaShowRoom ON ShowRoom.OfertaShowRoom (CUV,CampaniaID);

GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalle]') AND (type = 'U') )
	DROP TABLE [ShowRoom].[OfertaShowRoomDetalle]
GO

create table ShowRoom.OfertaShowRoomDetalle
(
	OfertaShowRoomDetalleID int primary key identity(1,1),
	CampaniaID int,
	CUV varchar(20),
	NombreProducto varchar(100),
	Descripcion1 varchar(150),
	Descripcion2 varchar(150),
	Descripcion3 varchar(150),
	Imagen varchar(150)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PerfilOfertaShowRoom]') AND (type = 'U') )
	DROP TABLE [ShowRoom].PerfilOfertaShowRoom
GO

create table ShowRoom.PerfilOfertaShowRoom
(
	PerfilOfertaShowRoomID int primary key identity(1,1),
	EventoID int,
	PerfilID int,
	CampaniaID int,
	CUV varchar(20),
	Orden int
)

go

/*Procedures*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomEventoByCampaniaID]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomEventoByCampaniaID
GO

create procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201608
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomEvento
GO

create procedure [ShowRoom].[InsertShowRoomEvento]
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@RutaShowRoomPopup varchar(500),
@RutaShowRoomBannerLateral varchar(500),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, RutaShowRoomPopup, RutaShowRoomBannerLateral, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles, @RutaShowRoomPopup, @RutaShowRoomBannerLateral, 
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1)

set @EventoID = @@IDENTITY

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomEvento
GO

create procedure [ShowRoom].[UpdateShowRoomEvento]
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@RutaShowRoomPopup varchar(500),
@RutaShowRoomBannerLateral varchar(500),
@UsuarioModificacion varchar(20),
@Estado int
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	RutaShowRoomPopup = @RutaShowRoomPopup,
	RutaShowRoomBannerLateral = @RutaShowRoomBannerLateral,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCargarMasivaConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCargarMasivaConsultora
GO

create procedure [ShowRoom].InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
@FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomConsultora
GO

create procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201607,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomConsultoraMostrarPopup]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomConsultoraMostrarPopup
GO

create procedure ShowRoom.UpdateShowRoomConsultoraMostrarPopup
@CampaniaID int,
@CodigoConsultora varchar(20),
@MostrarPopup bit
as
/*
ShowRoom.UpdateShowRoomConsultoraMostrarPopup 201607,'0193037',1
*/
begin

update ShowRoom.EventoConsultora
set	MostrarPopup = @MostrarPopup
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora	

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetProductosShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetProductosShowRoom
GO

create procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201607,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.DescripcionProducto1,'') DescripcionProducto1,
	ISNULL(OS.DescripcionProducto2,'') DescripcionProducto2,
	ISNULL(OS.DescripcionProducto3,'') DescripcionProducto3,
	ISNULL(OS.ImagenProducto1,'') ImagenProducto1,
	ISNULL(OS.ImagenProducto2,'') ImagenProducto2,
	ISNULL(OS.ImagenProducto3,'') ImagenProducto3
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.Orden desc 

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetPriorizacionShowRoomByTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetPriorizacionShowRoomByTipoOferta
GO

CREATE PROCEDURE ShowRoom.GetPriorizacionShowRoomByTipoOferta
(
	@ConfiguracionOfertaID int,
	@CampaniaID int
)
AS
/*
ShowRoom.GetPriorizacionShowRoomByTipoOferta 9,2960
*/
DECLARE @Valor int;
BEGIN
	SELECT @Valor = isnull(max(O.orden),0) + 1  
		FROM ShowRoom.OfertaShowRoom O
		WHERE O.ConfiguracionOfertaID = @ConfiguracionOfertaID
			  AND O.CampaniaID = @CampaniaID
	select @Valor
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ValidarPriorizacionShowRoomByTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ValidarPriorizacionShowRoomByTipoOferta
GO

CREATE PROCEDURE ShowRoom.ValidarPriorizacionShowRoomByTipoOferta
(
	@ConfiguracionOfertaID int,
	@CampaniaID int,
	@Orden int
)
AS
/*
ShowRoom.ValidarPriorizacionShowRoomByTipoOferta 9,2960,9
*/
BEGIN
DECLARE @Valor  int = 0
	SELECT @Valor = count(*) 
		from ShowRoom.OfertaShowRoom o
	WHERE 
		O.ConfiguracionOfertaID = @ConfiguracionOfertaID
		AND O.CampaniaID = @CampaniaID
		and o.Orden = @Orden

	SELECT @Valor
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsOfertaShowRoom
GO

CREATE PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@DescripcionProducto1 varchar(250),
	@DescripcionProducto2 varchar(250),
	@DescripcionProducto3 varchar(250),
	@ImagenProducto1 varchar(150),
	@ImagenProducto2 varchar(150),
	@ImagenProducto3 varchar(150),
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, DescripcionProducto1, DescripcionProducto2, DescripcionProducto3, ImagenProducto1,
		ImagenProducto2, ImagenProducto3, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, PerfilID
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, 99, @DescripcionProducto1, @DescripcionProducto2, @DescripcionProducto3, @ImagenProducto1,
		@ImagenProducto2, @ImagenProducto3, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(),1
	)
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdOfertaShowRoom
GO

CREATE PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@DescripcionProducto1 varchar(250),
	@DescripcionProducto2 varchar(250),
	@DescripcionProducto3 varchar(250),
	@ImagenProducto1 varchar(150),
	@ImagenProducto2 varchar(150),
	@ImagenProducto3 varchar(150),
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioOferta decimal(18,2)
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			DescripcionProducto1 = @DescripcionProducto1,
			DescripcionProducto2 = @DescripcionProducto2,
			DescripcionProducto3 = @DescripcionProducto3,
			ImagenProducto1 = @ImagenProducto1,
			ImagenProducto2 = @ImagenProducto2,
			ImagenProducto3 = @ImagenProducto3,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate()
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DelOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DelOfertaShowRoom
GO

CREATE PROCEDURE ShowRoom.DelOfertaShowRoom
(
	@CampaniaID int,
	@CUV VARCHAR(20),
	@UsuarioModificacion varchar(50)
)
AS
BEGIN

	UPDATE ShowRoom.OfertaShowRoom
		SET FlagHabilitarProducto = 0,
			UsuarioModificacion = @UsuarioModificacion,
			FechaModificacion = getdate()
	WHERE 
		CUV = @CUV
		AND CampaniaID = @CampaniaID
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[RemoverOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].RemoverOfertaShowRoom
GO

create procedure ShowRoom.RemoverOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.RemoverOfertaShowRoom 2960,'99009'
*/
begin

DELETE FROM ShowRoom.OfertaShowRoom
WHERE 
	CUV = @CUV
	AND CampaniaID = @CampaniaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

create procedure ShowRoom.GetShowRoomOfertas
@CampaniaID int
as
/*
ShowRoom.GetShowRoomOfertas 201607
*/
begin

select 
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,p.PrecioCatalogo,o.Stock,
o.StockInicial,ImagenProducto,o.Orden,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.CategoriaID,
isnull(o.DescripcionProducto1,'') as DescripcionProducto1, isnull(o.DescripcionProducto2,'') as DescripcionProducto2,
isnull(o.DescripcionProducto3,'') as DescripcionProducto3,isnull(o.ImagenProducto1,'') as ImagenProducto1,
isnull(o.ImagenProducto2,'') as ImagenProducto2, isnull(o.ImagenProducto3,'') as ImagenProducto3,
o.PerfilID,o.UsuarioRegistro,o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,p.MarcaID 
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial p on
	o.CUV = p.CUV
	and o.CampaniaID = p.CampaniaID
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
where 
	c.Codigo = @CampaniaID
	and o.FlagHabilitarProducto = 1
order by o.Orden asc

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ValidarUnidadesPermitidasByCUVShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ValidarUnidadesPermitidasByCUVShowRoom
GO

create procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ValidarUnidadesPermitidaPedidoShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ValidarUnidadesPermitidaPedidoShowRoom
GO

CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[CantidadPedidoByConsultoraShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].CantidadPedidoByConsultoraShowRoom
GO

create procedure ShowRoom.CantidadPedidoByConsultoraShowRoom
@CampaniaID INT,
@CUV VARCHAR(20),
@ConsultoraID INT
as
/*
ShowRoom.CantidadPedidoByConsultoraShowRoom 201607, '99001', 8828
*/
begin

SET NOCOUNT ON
		DECLARE @Cantidad INT
		DECLARE @CUVPadre VARCHAR(10)
		SET @CUVPadre = @CUV
		-- Verificamos si el cuv a validar es una talla o color
		IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
		BEGIN
			SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)

			SET @Cantidad = (SELECT isnull((SELECT SUM(Cantidad) FROM PedidoWebDetalle
							 WHERE
						 			CampaniaID   = @CampaniaID
						 		AND ConsultoraID = @ConsultoraID
						 		AND CUV IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
						 		AND CUV <> @CUV),0))
		END
		ELSE
		BEGIN
			SET @Cantidad = 0
		END
		
		SELECT @Cantidad
	SET NOCOUNT OFF

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ValidarStockOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ValidarStockOfertaShowRoom
GO

create procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoom
GO

create procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomUpd]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomUpd
GO

CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomDel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomDel
GO

CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeshabilitarShowRoomEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeshabilitarShowRoomEvento
GO

create procedure ShowRoom.DeshabilitarShowRoomEvento
@EventoID int,
@CampaniaID int,
@UsuarioModificacion varchar(20)
as
begin

update ShowRoom.Evento set Estado = 0, UsuarioModificacion = @UsuarioModificacion
where EventoID = @EventoID and CampaniaID = @CampaniaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[EliminarShowRoomEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].EliminarShowRoomEvento
GO

create procedure ShowRoom.EliminarShowRoomEvento
@EventoID int,
@CampaniaID int
as
begin

delete from ShowRoom.Evento
where EventoID = @EventoID and CampaniaID = @CampaniaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GuardarImagenShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GuardarImagenShowRoom
GO

create procedure ShowRoom.GuardarImagenShowRoom
@EventoID int,
@NombreImagenFinal varchar(150),
@Tipo int,
@UsuarioModificacion varchar(20)
as
/*
ShowRoom.GuardarImagenShowRoom 2,'IMAGEN_PRUEBA.jpg',1,'DEMO'
ShowRoom.GuardarImagenShowRoom 2,'IMAGEN_PRUEBA.jpg',5,'DEMO'
*/
begin 

	if (@Tipo = 1)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			Imagen1 = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 2)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			ImagenVentaSetPopup = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 3)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			Imagen2 = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 4)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			ImagenVentaTagLateral = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 5)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			ImagenCabeceraProducto = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 6)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			ImagenPestaniaShowRoom = @NombreImagenFinal
		where EventoID = @EventoID
	end

	if (@Tipo = 7)
	begin
		update ShowRoom.Evento set 
			UsuarioModificacion = @UsuarioModificacion,
			ImagenPreventaDigital = @NombreImagenFinal
		where EventoID = @EventoID
	end

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertarShowRoomPerfil]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertarShowRoomPerfil
GO

create procedure ShowRoom.InsertarShowRoomPerfil
@NumeroPerfiles int,
@FormatoPerfiles varchar(50),
@EventoID int
as
/*
ShowRoom.InsertarShowRoomPerfil 14,'CL_201612_Perfil',1
*/
begin
	declare @Contador int = 1
	declare @NumeroPerfil varchar(2) = ''

	while (@Contador <= @NumeroPerfiles)
	begin

	set @NumeroPerfil = RIGHT('0'+ convert(varchar(2),@Contador), 2)

	insert into ShowRoom.Perfil (PerfilDescripcion,EventoID)
	values (@FormatoPerfiles + @NumeroPerfil, @EventoId)

	set @Contador = @Contador + 1 

	end
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[EliminarShowRoomPerfiles]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].EliminarShowRoomPerfiles
GO

create procedure ShowRoom.EliminarShowRoomPerfiles
@EventoID int
as
/*
ShowRoom.EliminarShowRoomPerfiles 1
*/
begin

delete from ShowRoom.Perfil where EventoID = @EventoID

end

go
/*Fin Procedures*/

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists(select 1 from Permiso where Descripcion = 'Administrar ShowRoom')
begin
	
	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = 111;
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios)
	VALUES(@PermisoID+1, 'Administrar ShowRoom', 111, @OrdenItem+1,'ShowRoom/AdministrarShowRoom',0,'Header','',0,0,0)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

go

-- SPRINT 2

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'FechaCreacion') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD FechaCreacion datetime
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'UsuarioCreacion') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD UsuarioCreacion varchar(50)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'FechaModificacion') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD FechaModificacion datetime
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'UsuarioModificacion') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD UsuarioModificacion varchar(50)
go

if (SELECT count(*) FROM sys.indexes  where name = 'IX_ShowRoomOfertaShowRoomDetalle') = 0
	CREATE NONCLUSTERED INDEX IX_ShowRoomOfertaShowRoomDetalle ON ShowRoom.OfertaShowRoomDetalle (CampaniaID,CUV);
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'Orden') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN Orden
go

ALTER TABLE ShowRoom.OfertaShowRoom ADD Orden int

go


if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CategoriaID') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN CategoriaID
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'DescripcionProducto1') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN DescripcionProducto1
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'DescripcionProducto2') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN DescripcionProducto2
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'DescripcionProducto3') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN DescripcionProducto3
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'ImagenProducto1') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN ImagenProducto1
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'ImagenProducto2') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN ImagenProducto2
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'ImagenProducto3') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN ImagenProducto3
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PerfilID') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom DROP COLUMN PerfilID
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	drop procedure ShowRoom.UpdStockOfertaShowRoomMasivo

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
  DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int
  )
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE (
	CUV varchar(20), NombreSet varchar(250), NombreProducto varchar(150), Descripcion1 varchar(150),
	Descripcion2 varchar(150), Descripcion3 varchar(150)
  )
GO

/*Nuevos Stores Procedures*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
GO

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select 
@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetProductosShowRoomDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.GetProductosShowRoomDetalle
GO

create procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201611,'99009'
ShowRoom.GetProductosShowRoomDetalle 201611,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsOfertaShowRoomDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.InsOfertaShowRoomDetalle
GO

create procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdOfertaShowRoomDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.UpdOfertaShowRoomDetalle
GO

create procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[EliminarOfertaShowRoomDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.EliminarOfertaShowRoomDetalle
GO

create procedure ShowRoom.EliminarOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5)
as
begin

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[EliminarOfertaShowRoomDetalleAll]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.EliminarOfertaShowRoomDetalleAll
GO

create procedure ShowRoom.EliminarOfertaShowRoomDetalleAll
@CampaniaID int,
@CUV varchar(5)
as
begin

delete from ShowRoom.OfertaShowRoomDetalle
where
	CampaniaID = @CampaniaID
	and CUV = @CUV
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPerfiles]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.GetShowRoomPerfiles
GO

create procedure ShowRoom.GetShowRoomPerfiles
@EventoID int
as
/*
ShowRoom.GetShowRoomPerfiles 1
*/
begin

select 
	PerfilID,
	PerfilDescripcion,
	EventoID
from ShowRoom.Perfil 
where 
	EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPerfilOfertaCuvs]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.GetShowRoomPerfilOfertaCuvs
GO

CREATE PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 1002,2015,201612
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GuardarPerfilOfertaShowRoom]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.GuardarPerfilOfertaShowRoom
GO

create procedure ShowRoom.GuardarPerfilOfertaShowRoom
@PerfilID int,
@EventoID int,
@CampaniaID int,
@CadenaCuv varchar(500)
as
begin

begin tran

delete from ShowRoom.PerfilOfertaShowRoom
where
	EventoID = @EventoID
	and PerfilID = @PerfilID
	and CampaniaID = @CampaniaID

declare @tablaCuv table ( CUV varchar(5), Orden int )
declare @Orden int = 0

DECLARE @strCadena VARCHAR(255)
DECLARE @strValor VARCHAR(6)
DECLARE @intBandera BIT
DECLARE @intTamano SMALLINT

SET @strCadena = @CadenaCuv
SET @intBandera = 0

WHILE @intBandera = 0
BEGIN
  BEGIN TRY
    SET @strValor = RIGHT(LEFT(@strCadena,CHARINDEX(',', @strCadena,1)-1),CHARINDEX(',', @strCadena,1)-1)
    
	set @Orden = @Orden + 1
	insert into @tablaCuv (CUV, Orden) values (@strValor, @Orden)

    SET @intTamano = LEN(@strValor) 
 
    SET @strCadena = SUBSTRING(@strCadena,@intTamano + 2, LEN(@strCadena)) 
  END TRY
  BEGIN CATCH 
	set @Orden = @Orden + 1
    insert into @tablaCuv (CUV, Orden) values (@strCadena, @Orden)
    SET @intBandera = 1
  END CATCH 
END

insert into ShowRoom.PerfilOfertaShowRoom (EventoID,PerfilID,CampaniaID,CUV,Orden)
select @EventoID, @PerfilID, @CampaniaID, CUV, Orden
from @tablaCuv

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertasConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE ShowRoom.GetShowRoomOfertasConsultora
GO

create procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201611,'0193037'
*/
begin

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join ShowRoom.EventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
order by pos.Orden

end

go

/*Fin Nuevos Stores Procedures*/

/*Stores Modificados*/

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END

go

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150)
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER procedure [ShowRoom].[GetProductosShowRoom]
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201612,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE [dbo].[InsPedidoWebDetalleOferta_SB2]
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

go

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10)
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'00025',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'02767',2701,2161,'50','5052'
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID,null
FROM OfertaProducto op
inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID,null    
 FROM ShowRoom.OfertaShowRoom op    
 inner join ods.Campania c on     
 op.CampaniaID = c.CampaniaID    
where --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	select 1 from dbo.ProductoSugerido 
			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
begin
	set @TieneSugerido = 1
end
	
IF(@Criterio = 1)
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcc.CUVRevista IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
END
ELSE
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
			(	SELECT E.TipoEstrategiaID FROM Estrategia E
				INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
				WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcc.CUVRevista IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on
		op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	left join MatrizComercial mc on
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON
		EST.CampaniaID = p.AnoCampania
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV	TCC WHERE TCC.CUV = p.CUV))
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	where
		p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion))>0
END

END

go

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END

go

/*Fin Stores Modificados*/

--FIN SHOWROOM

ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
@CodigoConsultora varchar(25)  
AS
/*
 GetSesionUsuario_SB2 '009746900'  
*/
BEGIN  
	DECLARE @PasePedidoWeb int  
	DECLARE @TipoOferta2 int  
	DECLARE @CompraOfertaEspecial int  
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	  
	declare @PaisID int  
	declare @UsuarioPrueba bit  
	declare @CodConsultora varchar(20)  
	declare @CampaniaID int  
	declare @ZonaID int  
	declare @RegionID int  
	declare @ConsultoraID bigint  
	declare @IndicadorPermiso int  
	declare @CodigoFicticio varchar(20)  
	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),  
		@PaisID = IsNull(PaisID,0),  
		@CodConsultora = CodigoConsultora  
	from usuario with(nolock)  
	where codigousuario = @CodigoConsultora  
    
	declare @CountCodigoNivel bigint  
  
	/*Oferta Final y Catalogo Personalizado*/	
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select 
		@CodigoZona = IsNull(z.Codigo,''),    
		@CodigoRegion = IsNull(r.Codigo,'')   
	from ods.consultora c with(nolock)   
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora   
	
	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOfertaFinalZonaValida = 1

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	/*Fin Oferta Final y Catalogo Personalizado*/

	IF @UsuarioPrueba = 0   
	BEGIN  
		select @ZonaID = IsNull(ZonaID,0),  
			@RegionID = IsNull(RegionID,0),  
			@ConsultoraID = IsNull(ConsultoraID,0)  
		from ods.consultora with(nolock)  
		where codigo = @CodConsultora  
		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)  
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))  
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))  
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))  
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		
			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
			declare @CampaniaFacturada int = 0
		
			 select top 1 @CampaniaFacturada = p.CampaniaID
			FROM ods.Pedido(NOLOCK) P 
				INNER JOIN ods.Consultora(NOLOCK) CO ON 
					P.ConsultoraID=CO.ConsultoraID
				WHERE 
					co.ConsultoraID=@ConsultoraID
					and	P.CampaniaID <> @ODSCampaniaID
					and	CO.RegionID=@RegionID
					and	CO.ZonaID=@ZonaID
			order by PedidoID desc

			SET @FechaLimitePago = (
				SELECT FECHALIMITEPAGO 
				FROM ODS.Cronograma 
				WHERE CampaniaID=@CampaniaFacturada AND RegionID=@RegionID AND ZonaID = @ZonaID  AND EstadoActivo=1
			)
			SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))  
  
		--SSAP CGI(Id Solicitud=1402)  
		--begin  
		declare @IndicadorOfertaFIC int  
		declare @ImagenUrlOfertaFIC varchar(500)  
		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))  
		if @IndicadorOfertaFIC>=1  
		begin  
			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))  
		end  
		else  
		begin  
			SET @ImagenUrlOfertaFIC = ''  
		end  
		--end  
		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID        
  
		SELECT   
			u.PaisID,  
			p.CodigoISO,  
			c.RegionID,  
			r.Codigo AS CodigorRegion,  
			ISNULL(c.ZonaID,0) AS ZonaID,  
			ISNULL(z.Codigo,'') AS CodigoZona,  
			c.ConsultoraID,  
			u.CodigoUsuario,  
			u.CodigoConsultora,  
			u.Nombre AS NombreCompleto,  
			ISNULL(ur.RolID,0) AS RolID,  
			u.EMail,  
			p.Simbolo,  
			c.TerritorioID,  
			t.Codigo AS CodigoTerritorio,  
			c.MontoMinimoPedido,  
			c.MontoMaximoPedido,  
			p.CodigoFuente,  
			p.BanderaImagen,  
			p.Nombre as NombrePais,  
			u.CambioClave,  
			u.Telefono,  
			u.Celular,  
			ISNULL(s.descripcion,'') as Segmento,  
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  
			u.UsuarioPrueba,  
			ISNULL(u.Sobrenombre,'') as Sobrenombre,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  
			ISNULL(@TipoOferta2,0) as TipoOferta2,  
			1 as CompraKitDupla,  
			1 as CompraOfertaDupla,  
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  
			0 as ProgramaReconocimiento,  
			ISNULL(s.segmentoid, 0) as segmentoid,  
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,  
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			@IndicadorPermiso IndicadorPermisoFIC,  
			ro.Descripcion as RolDescripcion,   
			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)  
			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)  
			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,  
			isnull(c.EsJoven,0) EsJoven,  
			(case     
				when @CountCodigoNivel =0 then 0  --1589  
				when @CountCodigoNivel>0 then 1 End) Lider,--1589      
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  
			isnull(p.PortalLideres,0) PortalLideres,--1589  
			isnull(p.LogoLideres,null) LogoLideres, --1589   
			null as ConsultoraAsociada, --1688   
			isnull(si.descripcion,null) SegmentoConstancia, --2469  
			isnull(se.Codigo,null) Seccion, --2469  
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469  
			case When cl.ConsultoraID is null then 0  
				else 1 end esConsultoraLider,  
			u.EMailActivo, --2532  
			si.SegmentoInternoId,
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
						ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida
		FROM [dbo].[Usuario] u with(nolock)  
		LEFT JOIN (  
			select *  
			from ods.consultora with(nolock)  
			where ConsultoraId = @ConsultoraID  
		) c ON
			u.CodigoConsultora = c.Codigo  
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo  
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario  
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID  
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469  
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469  
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID  
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  
		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID  
            AND c.SeccionID = t.SeccionID  
            AND c.ZonaID = t.ZonaID  
            AND c.RegionID = t.RegionID  
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid  
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID  
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469  
		WHERE ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora  
	END  
	ELSE  
	BEGIN  
		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)  
		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))  
  
		SELECT   
			u.PaisID,  
			p.CodigoISO,  
			c.RegionID,  
			r.Codigo AS CodigorRegion,  
			ISNULL(c.ZonaID,0) AS ZonaID,  
			ISNULL(z.Codigo,'') AS CodigoZona,  
			c.ConsultoraID,  
			u.CodigoUsuario,  
			u.CodigoConsultora,  
			u.Nombre AS NombreCompleto,  
			ISNULL(ur.RolID,0) AS RolID,  
			u.EMail,  
			p.Simbolo,  
			c.TerritorioID,  
			t.Codigo AS CodigoTerritorio,  
			c.MontoMinimoPedido,  
			c.MontoMaximoPedido,  
			p.CodigoFuente,  
			p.BanderaImagen,  
			p.Nombre as NombrePais,  
			u.CambioClave,  
			u.Telefono,  
			u.Celular,  
			ISNULL(s.descripcion,'') as Segmento,  
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  
			u.UsuarioPrueba,  
			ISNULL(u.Sobrenombre,'') as Sobrenombre,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  
			ISNULL(@TipoOferta2,0) as TipoOferta2,  
			1 as CompraKitDupla,  
			1 as CompraOfertaDupla,  
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  
			0 as ProgramaReconocimiento,  
			ISNULL(s.segmentoid, 0) as segmentoid,  
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,  
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			@IndicadorPermiso IndicadorPermisoFIC,  
			ro.Descripcion as RolDescripcion,   
			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)  
			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)  
			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,  
			(case     
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589  
				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589     
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  
			isnull(p.PortalLideres,0) PortalLideres,--1589  
			isnull(p.LogoLideres,null) LogoLideres, --1589   
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688  
			u.EMailActivo, --2532  
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida
		FROM [dbo].[Usuario] u (nolock)  
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo  
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario  
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID  
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID  
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  
		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID  
            AND c.SeccionID = t.SeccionID  
            AND c.ZonaID = t.ZonaID  
            AND c.RegionID = t.RegionID  
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid  
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario  
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora  
		WHERE ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora  
	END  
END   

go