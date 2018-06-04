USE BelcorpPeru;
GO

ALTER PROCEDURE [dbo].[UpdBannerPaisSegmentoZona]
 @CampaniaId int,  
 @BannerId int,  
 @PaisId int,  
 @Segmento int,
 @ConfiguracionZona varchar(max),
 @SegmentoInternoID varchar(max),
 @TipoAcceso int,
 @CodigosConsultora varchar(max)
AS
 SET NOCOUNT ON;

 DECLARE @Val INT

 select
    @Val = count(CampaniaId)
 from
    dbo.BannerPaisSegmentoZona
 where
    CampaniaId = @CampaniaId
    and BannerId = @BannerId
    and PaisId = @PaisId
   
 IF @Val = 0   
 BEGIN  
  INSERT INTO dbo.BannerPaisSegmentoZona
  (
   CampaniaID,
   BannerID,
   PaisID,
   Segmento,
   ConfiguracionZona,
   SegmentoInterno,
   CodigosConsultora,
   TipoAcceso
  )
  VALUES
  (
     @CampaniaId,
     @BannerId,
     @PaisId,
     @Segmento,
     @ConfiguracionZona,
     @SegmentoInternoID,
     @CodigosConsultora,
     @TipoAcceso
  )
 END  
 ELSE  
 BEGIN

  UPDATE dbo.BannerPaisSegmentoZona
  SET
   Segmento = @Segmento,
   ConfiguracionZona = @ConfiguracionZona,
   SegmentoInterno = @SegmentoInternoID,
   CodigosConsultora = IsNULL(@CodigosConsultora, CodigosConsultora),
   TipoAcceso = @TipoAcceso
  WHERE CampaniaId = @CampaniaId and
    BannerId = @BannerId and  
    PaisId = @PaisId     
 END

GO

