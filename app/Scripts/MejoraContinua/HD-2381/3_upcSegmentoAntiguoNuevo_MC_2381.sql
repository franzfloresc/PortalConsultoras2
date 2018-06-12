USE [BelcorpPeru]
GO

ALTER PROCEDURE [dbo].[upcSegmentoAntiguo_Nuevo]  
@CAMPANIAID INT   
AS  
BEGIN 
declare @temporal TABLE (
		id int identity(1,1),
		BannerId int,
		segmento varchar(max),
		paisID int 
)  
declare @BannerID int  
declare @segmentofinal table (BannerID int, paisID int ,segmentoInterno int)  /*Cambio C2544 - Agregar paisID*/
  
insert into @temporal 
SELECT  BannerID,SegmentoInterno,PaisID   
FROM BannerPaisSegmentoZona  
where CampaniaId = @CAMPANIAID  
  
declare @i int, @total int, @servicioID int, @segmentostring varchar(max) ,@paisID int /*Cambio C2544 - Agregar paisID*/
  
set @total = (select max(id) from @temporal)  
set @i = 1  
  
while @i <= @total  
begin  
 set @BannerID = (select BannerID from @temporal where id = @i)  
 set @segmentostring = (select segmento from @temporal where id = @i)  
 Set @PaisId = (Select paisID from @temporal where id = @i)  /*Cambio C2544 - Agregar @paisID*/
  
 insert into @segmentofinal  
 select @BannerID,@PaisId, item from dbo.fnSplit(@segmentostring,',')  
   
 set @i = @i + 1  
   
END  

SELECT
	bp.BannerID,
	bp.PaisID,
	ISNULL(sgf.SegmentoInterno,-1) as Segmento,
	ISNULL(bpsz.ConfiguracionZona,'') as ConfiguracionZona,
	ISNULL(bpsz.CodigosConsultora, '') as CodigosConsultora,
	ISNULL(bpsz.TipoAcceso, -1) as TipoAcceso
from dbo.BannerPais bp with(nolock)  
left join dbo.BannerPaisSegmentoZona bpsz with(nolock) on
	bp.CampaniaId = bpsz.CampaniaId and
	bp.BannerId = bpsz.BannerId and 
	bp.PaisId = bpsz.PaisId  
left join @segmentofinal sgf on
	sgf.BannerID = bp.BannerID and 
	sgf.paisID= bp.PaisID
where bp.CampaniaID = @CAMPANIAID and
	  bpsz.SegmentoInterno IS NOT NULL  
 
UNION ALL
  
select 
	bp.BannerID,
	bp.PaisID,
	ISNULL(bpsz.Segmento,-1) as Segmento,
	ISNULL(bpsz.ConfiguracionZona,'') as ConfiguracionZona,
	ISNULL(bpsz.CodigosConsultora, '') as CodigosConsultora,
	ISNULL(bpsz.TipoAcceso, -1) as TipoAcceso
from dbo.BannerPais bp with(nolock)    
left join dbo.BannerPaisSegmentoZona bpsz with(nolock) on
	bp.CampaniaId = bpsz.CampaniaId and
	bp.BannerId = bpsz.BannerId and   
	bp.PaisId = bpsz.PaisId    
where bp.CampaniaID = @CAMPANIAID AND
	  bpsz.SegmentoInterno IS null   
order by bp.BannerID, bp.PaisID

END



