
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'EsKitNueva') = 0
		ALTER TABLE dbo.PedidoWebDetalle 
		ADD EsKitNueva bit
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionProgramaNuevas]') AND type in (N'P', N'PC')) 
 DROP PROCEDURE [dbo].[GetConfiguracionProgramaNuevas]
GO

CREATE PROCEDURE [dbo].[GetConfiguracionProgramaNuevas]
(
	@Campania varchar(50)
)
AS
BEGIN
	
	select 
			 CodigoPrograma
			,CampaniaInicio
			,CampaniaFin
			,IndExigVent
			,IndProgObli
			,CuponKit
			,CUVKit
	from  ods.configuracionProgramaNuevas
	where CampaniaInicio <= @Campania and @Campania <= CampaniaFin

END

GO


ALTER PROCEDURE [dbo].[InsPedidoWebDetalle]
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
	@EskitNueva bit = 0
AS	
BEGIN
	SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
								FROM dbo.PedidoWebDetalle 
								WHERE 
									CampaniaID = @CampaniaID 
									AND PedidoID = @PedidoID)

	INSERT INTO dbo.PedidoWebDetalle 
	(CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
	ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
	CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva )
	VALUES 
	(@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
	@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
	@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva)

END



go


ALTER PROCEDURE GetPedidoWebDetalleByCampania  
 @CampaniaID INT,    
 @ConsultoraID BIGINT    
AS    
/*    
 GetPedidoWebDetalleByCampania 201510, 49346761    
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
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1      
			  WHERE    
			  TE.FLAGACTIVO = 1     
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
 PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/  
 
 FROM dbo.PedidoWebDetalle pwd    
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV    
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID    
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV      
	 LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV    
	 LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP    
	 LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID    
	 LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  
			AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) 
			AND EST.Activo=1 
			AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)   
	 LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID     
	 LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL) 
	 LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId  
 WHERE pwd.CampaniaID = @CampaniaID    
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL 
 ORDER BY pwd.PedidoDetalleID DESC    
 SET NOCOUNT OFF    
END   


go


ALTER PROCEDURE [dbo].[DelPedidoWebDetalleMasivo]  
 @CampaniaID INT,  
 @PedidoID INT
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais() 

declare @TempPedidoCampania table
(
	Id int identity(1,1),
	TipoOfertaSisID int,
	CUV varchar(20),
	Stock int
)

insert into @TempPedidoCampania
select TipoOfertaSisID, CUV, Cantidad
from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID and TipoOfertaSisID = 1702  
	AND ISNULL(EsKitNueva, '0') != '1'

declare @Cont int
set @Cont = 1

declare @Total int
set @Total = (select count(*) from @TempPedidoCampania)

IF @Total != 0
BEGIN

	WHILE(@Cont <= @Total)
	BEGIN
		declare @T_TipoOfertaSisID int
		declare @T_CUV varchar(20)
		declare	@T_Stock int

		select	@T_TipoOfertaSisID = TipoOfertaSisID, 
				@T_CUV = CUV, 
				@T_Stock = Stock
		from @TempPedidoCampania
		where Id = @Cont

		EXEC UpdStockOfertaProductoDel @T_TipoOfertaSisID, @CampaniaID, @T_CUV, @T_Stock

		set @Cont = @Cont + 1
	END

END

insert into PedidoWebDetalleSeguimiento
(PedidoID, MarcaID, ConsultoraID, CampaniaID, CUV, AccionId, FechaAccion, Cantidad, PrecioUnidad, FechaCreacion,ItemValidado)
select PedidoID, MarcaID, ConsultoraID, CampaniaID, CUV, 401, @FechaGeneral, Cantidad, PrecioUnidad, FechaCreacion,ModificaPedidoReservado
from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID AND ISNULL(EsKitNueva, '0') != '1'

delete
from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID AND ISNULL(EsKitNueva, '0') != '1'


go

ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion]
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
as
set nocount on;

declare @Tipo smallint
if @TipoCronograma = 1
	set @Tipo = (select isnull(ProcesoRegular,0) from [dbo].[ConfiguracionValidacion])
else if @TipoCronograma = 2
	set @Tipo = (select isnull(ProcesoDA,0) from [dbo].[ConfiguracionValidacion])
else
	set @Tipo = (select isnull(ProcesoDAPRD,0) from [dbo].[ConfiguracionValidacion])

if @TipoCronograma = 1
begin

	declare @ConfValZonaTemp table
	(
		Campaniaid int,
		Regionid int,
		Zonaid int,
		FechaInicioFacturacion smalldatetime,
		FechaFinFacturacion smalldatetime
	)

	insert into @ConfValZonaTemp
	select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion, 
			cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
	from	ods.Cronograma cr with(nolock)
	left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
	where	cr.FechaInicioFacturacion <= @FechaFacturacion and 
			cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		where isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioFacturacion <= @FechaFacturacion
		and cr.FechaFinFacturacion >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);
end
else
	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		where isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioWeb <= @FechaFacturacion
		and cr.FechaFinWeb >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);

-- Cabecera de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	p.Clientes, r.Codigo as CodigoRegion,
	z.Codigo as CodigoZona,
	--(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado
	case p.EstadoPedido when 202 then 1 else 0 end as Validado	
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Region r with(nolock) on c.RegionID = r.RegionID
	join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
where pk.NroLote = @NroLote
order by p.CampaniaID, p.PedidoID;

-- Detalle de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	pd.CUV as CodigoVenta, pr.CodigoProducto,
	/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
		then pr.FactorRepeticion * sum(pd.Cantidad)
		else sum(pd.Cantidad) end as Cantidad*/
		sum(pd.Cantidad) as Cantidad
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
	join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo,
	pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
having sum(pd.Cantidad) > 0
order by CampaniaID, PedidoID, CodigoVenta


