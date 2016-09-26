USE BelcorpChile
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

CREATE SYNONYM [ods].[ProductosLanzamiento] FOR [ODS_CL].[dbo].[ProductosLanzamiento]
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

create procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
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
 -----------------------------------------------------------
Actualizacion: Agregado validacion si es de tipo ShowRoom
Autor: CJ
Fecha: 22/04/2016
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
where
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

alter procedure [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'02767',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'00040',2701,2161,'50','5052'
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

end

go

--FIN SHOWROOM

ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
 @CodigoConsultora varchar(25)  
AS  
/*
GetSesionUsuario_SB2 '071346927'
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
	declare @valorInscrita int  
  
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
               
		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID      
		select top 1 @valorInscrita=isnull(IndicadorActiva,0)
		from ods.ConsultoraFlexipago with(nolock)
		where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID
		
		if @valorInscrita=0
		BEGIN
			select top 1 @valorInscrita = isnull(Estado,0) from [dbo].[FlexipagoInsDes] with(nolock)
			where CodigoConsultora = @CodConsultora
			order by FlexipagoInsDesID desc		

			Set @valorInscrita = isnull(@valorInscrita,0)
		End	
			
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
			--ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			ISNULL((select top 1 Invitado from ods.ConsultoraFlexipago with(nolock)
				where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID),0) as IndicadorFlexiPago,--2461
			ISNULL(u.InvitacionRechazada,0) As InvitacionRechazada,--2416
			@valorInscrita InscritaFlexipago,--2461
			isnull(c.CampanaInvitada,0)  CampanaInvitada, --2461    
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			ro.Descripcion as RolDescripcion,  
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
			si.SegmentoInternoId,
			u.EMailActivo, --2532
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida
		FROM dbo.Usuario u with(nolock)  
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
		WHERE 
			ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora  
	END  
	ELSE  
	BEGIN  
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
			ISNULL(u.InvitacionRechazada,0) As InvitacionRechazada,--2461
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			ro.Descripcion as RolDescripcion,  
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
		FROM dbo.Usuario u (nolock)  
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
		WHERE 
			ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora  
	END
END

go