GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
@CampaniaID INT,      
@ConsultoraID INT      
AS      
DECLARE @ultimacampaniafacturable INT      
DECLARE @idultimacampaniafacturable INT      
DECLARE @idcampaniaingreso INT      
SELECT @idcampaniaingreso = AnoCampanaIngreso,      
  @ultimacampaniafacturable = isnull(UltimaCampanaFacturada,0)      
FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID
DECLARE @NumeroPedido INT      
--IF @ultimacampaniafacturable>0      
--begin      
 DECLARE @campaniafacturableingreso INT      
 set @campaniafacturableingreso = @ultimacampaniafacturable-@idcampaniaingreso      
--end            
  DECLARE @NroCampania INT
  SELECT TOP 1 @NroCampania=nrocampanias FROM pais with(nolock) WHERE nrocampanias is not null   
  DECLARE @indicador INT      
  set @indicador=0      
  DECLARE @campaniacompare INT    
    
   IF substring(cast(@ultimacampaniafacturable as varchar(6)),5,2) = cast(@NroCampania as char(2))      
  begin
    set @campaniacompare=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as INT)+1 as varchar(4)) + '01' as INT)      
  end      
  else      
  begin      
	set @campaniacompare = @ultimacampaniafacturable + 1        
  end
   
---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado      
--SELECT @CampaniaID,@campaniacompare    
IF @campaniafacturableingreso = 0 and @CampaniaID = @campaniacompare      
begin
 set @NumeroPedido = 1      
 DECLARE @CampaniaID_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin 
	set @CampaniaID_=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID_= @CampaniaID - 1       
  end
  DECLARE @idCampaniaID1_ INT      
 SELECT @idCampaniaID1_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID_ 
 IF (SELECT count(*) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1_) and consultoraid=@ConsultoraID)=1      
   begin         
  set @indicador=1      
   end
end      
      
---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados      
IF @campaniafacturableingreso =1 and @CampaniaID=@campaniacompare      
begin      
 set @NumeroPedido=2           
 DECLARE @CampaniaID2_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID2_=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID2_= @CampaniaID-1      
  end      
   DECLARE @CampaniaID3_ INT       
   IF substring(cast(@CampaniaID2_ as varchar(6)),5,2)='01'      
    begin      
  set @CampaniaID3_=cast(cast( cast(substring(cast(@CampaniaID2_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
 end      
 else      
  begin        
  set @CampaniaID3_= @CampaniaID2_-1       
 end      
 DECLARE @idCampaniaID3_ INT      
 DECLARE @idCampaniaID2_ INT       
 SELECT @idCampaniaID3_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID3_      
 SELECT @idCampaniaID2_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID2_      
         
 IF (SELECT count(*) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID2_,@idCampaniaID3_) and consultoraid=@ConsultoraID)=2      
   begin      
 set @indicador=1      
   end      
end      
      
---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados      
IF @campaniafacturableingreso =2 and @CampaniaID=@campaniacompare      
begin      
 set @NumeroPedido=3   
 DECLARE @CampaniaID4_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID4_=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID4_= @CampaniaID-1      
end      
  DECLARE @CampaniaID5_ INT       
  IF substring(cast(@CampaniaID4_ as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID5_=cast(cast( cast(substring(cast(@CampaniaID4_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID5_= @CampaniaID4_-1      
  end      
  DECLARE @CampaniaID6_ INT       
  IF substring(cast(@CampaniaID5_ as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID6_=cast(cast( cast(substring(cast(@CampaniaID5_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin       
 set @CampaniaID6_= @CampaniaID5_-1      
  end      
 DECLARE @idCampaniaID4_ INT      
 DECLARE @idCampaniaID5_ INT      
 DECLARE @idCampaniaID6_ INT      
 SELECT @idCampaniaID4_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID4_      
 SELECT @idCampaniaID5_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID5_      
 SELECT @idCampaniaID6_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID6_      
     
 IF (SELECT count(*) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID4_,@idCampaniaID5_,@idCampaniaID6_) and consultoraid=@ConsultoraID)=3      
   begin       
 set @indicador=1       
   end        
End      
--SELECT @campaniafacturableingreso,@CampaniaID,@campaniacompare     
---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados      
  --SELECT @campaniafacturableingreso,@CampaniaID,@campaniacompare  
IF @campaniafacturableingreso =3and @CampaniaID=@campaniacompare             
begin      
set @NumeroPedido=4      
 DECLARE @CampaniaID7_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID7_=cast(cast( cast(substring(cast(@CampaniaID as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else         
  begin            
 set @CampaniaID7_= @CampaniaID-1      
  end        
  DECLARE @CampaniaID8_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'       
  begin      
 set @CampaniaID8_=cast(cast( cast(substring(cast(@CampaniaID7_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID8_= @CampaniaID7_-1      
  end      
  DECLARE @CampaniaID9_ INT       
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID9_=cast(cast( cast(substring(cast(@CampaniaID8_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID9_= @CampaniaID8_-1      
  end        
  DECLARE @CampaniaID10_ INT             
  IF substring(cast(@CampaniaID as varchar(6)),5,2)='01'      
  begin      
 set @CampaniaID10_=cast(cast( cast(substring(cast(@CampaniaID9_ as varchar(6)),1,4)as INT)-1 as varchar(4)) + cast(@NroCampania as varchar(2)) as INT)      
  end      
  else      
  begin        
 set @CampaniaID10_= @CampaniaID9_-1           
  end        
  DECLARE @idCampaniaID7_ INT        
 DECLARE @idCampaniaID8_ INT        
 DECLARE @idCampaniaID9_ INT        
 DECLARE @idCampaniaID10_ INT        
 SELECT @idCampaniaID7_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID7_        
 SELECT @idCampaniaID8_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID8_        
 SELECT @idCampaniaID9_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID9_        
 SELECT @idCampaniaID10_ = campaniaid FROM ods.Campania with(nolock) WHERE codiGO=@CampaniaID10_       
   IF (SELECT count(*) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID7_,@idCampaniaID8_,@idCampaniaID9_,@idCampaniaID10_) and consultoraid=@ConsultoraID)=4     
     begin      
 set @indicador=1        
   end       
end      
   
IF @campaniafacturableingreso>=0 and  @campaniafacturableingreso<=3 and @indicador=1       
begin            
   --SELECT @CampaniaID,@NumeroPedido  
 SELECT TOP 4 OfertaNuevaId,      
   NumeroPedido,      
   ImagenProducto01,      
   Descripcion,      
   CUV,      
   PrecioNormal,      
   PrecioParaTi,      
   MarcaID,      
   IndicadorMontoMinimo,      
   DescripcionProd,      
   UnidadesPermitidas,      
   (case when len(IndicadorPedido) >0  then 1      
       else 0 end) IndicadorPedido,
	   ganahasta      
 FROM            
 (      
  SELECT       
    og.OfertaNuevaId,      
    og.NumeroPedido,      
    case isnull(og.FlagImagenActiva,0)      
     when 1      
     then og.ImagenProducto01      
     when 2      
     then og.ImagenProducto02      
     when 3      
     then og.ImagenProducto03      
     else      
      ''       
    end ImagenProducto01,      
    og.Descripcion,      
    og.CUV,      
    og.PrecioNormal,      
    og.PrecioParaTi,      
    pc.MarcaID,      
        pc.IndicadorMontoMinimo,      
        coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,      
    dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,      
    isnull(pwd.CUV,'') IndicadorPedido,
	isnull(og.ganahasta, 0) ganahasta
  FROM dbo.OfertaNueva  og with(nolock)      
    inner join ods.ProductoComercial pc with(nolock)     
    on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania      
    inner join ods.Campania ca with(nolock)     
    on pc.CampaniaID = ca.CampaniaID      
    left join dbo.ProductoDescripcion pd with(nolock)     
    on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV      
    LEFT JOIN PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV  and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID      
    WHERE ca.CodiGO = @CampaniaID      
    and og.FlagHabilitarOferta = 1      
    and og.NumeroPedido=@NumeroPedido      
  and og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)      
 ) a      
 
 WHERE a.UnidadesPermitidas > 0  
order by 5 asc     
end  
else      
begin        
 SELECT OfertaNuevaId,      
    NumeroPedido,      
      ImagenProducto01,      
      Descripcion,      
      CUV,      
      PrecioNormal,      
      PrecioParaTi,      
      '' MarcaID,      
      '' IndicadorMontoMinimo,      
      '' DescripcionProd,      
   UnidadesPermitidas,      
   0 IndicadorPedido,
   0 ganahasta      
 FROM OfertaNueva  with(nolock)    
 WHERE OfertaNuevaID<0    
 order by 5 asc    
end      

GO
