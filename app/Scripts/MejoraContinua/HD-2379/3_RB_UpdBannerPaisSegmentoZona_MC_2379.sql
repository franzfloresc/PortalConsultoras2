USE [BelcorpPeru]
GO
           
ALTER procedure [dbo].[UpdBannerPaisSegmentoZona]  
 @CampaniaId int,  
 @BannerId int,  
 @PaisId int,  
 @Segmento int , /*Colocado por defauld por que ya no se utilizara*/ 
 @ConfiguracionZona varchar(max),
 @SegmentoInternoID varchar(max)  
as  
 declare @Val int  
 set @Val = 0  
 select @Val = count(CampaniaId)  
 from BannerPaisSegmentoZona  
 where CampaniaId = @CampaniaId and  
   BannerId = @BannerId and  
   PaisId = @PaisId  
   
 IF @Val = 0   
 BEGIN  
  INSERT INTO BannerPaisSegmentoZona  
  VALUES(@CampaniaId,@BannerId,@PaisId,@Segmento,@ConfiguracionZona,@SegmentoInternoID)/*Re2544 - CS*/ 
 END  
 ELSE  
 BEGIN  
  update BannerPaisSegmentoZona  
  set Segmento = @Segmento, ConfiguracionZona = @ConfiguracionZona  , 
  BannerPaisSegmentoZona.SegmentoInterno = @SegmentoInternoID /*Re2544 - CS*/ 
  where CampaniaId = @CampaniaId and  
    BannerId = @BannerId and  
    PaisId = @PaisId     
 END  
 
