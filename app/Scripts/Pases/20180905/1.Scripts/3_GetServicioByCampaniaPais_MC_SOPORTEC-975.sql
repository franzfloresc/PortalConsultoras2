USE BelcorpPeru
GO
/* Autor : Carlos Soria 
Fecha: 13/05/2015
Nombre del store procedure modificado: [GetServicioByCampaniaPais]
Descripcion: Sirve para obtener los nuevos SegmentosInternosID y también los antiguos. 
*/
ALTER PROCEDURE [dbo].[GetServicioByCampaniaPais] --3,201508 
  
@PaisId int,  
@CampaniaId int  
  
AS  
  
BEGIN  

declare @temporal TABLE (id int identity(1,1),ServicioId int,segmento varchar(max))
declare @ServicioId int
--declare @segmentostring varchar(max)
declare @segmentofinal table (ServicioId int, segmentoInterno int)

insert into @temporal
SELECT  dbo.ServicioCampaniaSegmentoZona.ServicioId,SegmentoInternoID 
FROM ServicioCampaniaSegmentoZona
where CampaniaId = @CampaniaId

declare @i int, @total int, @segmentostring varchar(max)

set @total = (select max(id) from @temporal)
set @i = 1

while @i <= @total
begin
	set @ServicioId = (select ServicioId from @temporal where id = @i)
	set @segmentostring = (select segmento from @temporal where id = @i)

	insert into @segmentofinal
	select @ServicioId, item from dbo.fnSplit(@segmentostring,',')
	
	set @i = @i + 1
	
END

SELECT S.ServicioId, S.Descripcion, S.Url, ISNULL(sgf.SegmentoInterno,-1) as Segmento, ISNULL(SCC.ConfiguracionZona,'') as ConfiguracionZona  
from dbo.Servicio S with(nolock)
inner join dbo.ServicioCampania SC with(nolock) ON S.ServicioId = SC.ServicioId  
left join dbo.ServicioCampaniaSegmentoZona SCC with(nolock) ON SC.ServicioId = SCC.ServicioId AND  
                SC.CampaniaId = SCC.CampaniaId AND  
                SC.PaisId = SCC.PaisId  
left join   @segmentofinal sgf on sgf.ServicioId = s.ServicioId
WHERE
	SC.CampaniaID = @CampaniaId AND
	SC.PaisId = @PaisId AND
	SCC.SegmentoInternoID IS NOT NULL AND
	S.Descripcion <> 'Flexipago'

UNION  all

SELECT S.ServicioId, S.Descripcion, S.Url, ISNULL(SCC.Segmento,-1) as Segmento, ISNULL(SCC.ConfiguracionZona,'') as ConfiguracionZona  
 FROM dbo.Servicio S with(nolock)  
 inner join dbo.ServicioCampania SC with(nolock) ON S.ServicioId = SC.ServicioId  
 left join dbo.ServicioCampaniaSegmentoZona SCC with(nolock) ON SC.ServicioId = SCC.ServicioId AND  
                SC.CampaniaId = SCC.CampaniaId AND  
                SC.PaisId = SCC.PaisId  
 WHERE  
  SC.CampaniaId = @CampaniaId and  
  SC.PaisId = @PaisId  AND
  SCC.SegmentoInternoID IS null AND
  S.Descripcion <> 'Flexipago'
END 
GO