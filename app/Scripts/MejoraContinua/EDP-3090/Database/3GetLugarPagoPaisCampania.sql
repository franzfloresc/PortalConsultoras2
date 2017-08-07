Alter procedure [dbo].[GetLugarPagoPaisCampania]  
  @PaisID int = 0--,
  --@CampaniaID int = 0
as
select lp.LugarPagoID, 
lp.PaisID, 
p.Nombre As PaisNombre,
--lp.CampaniaID, 
--c.NombreCorto,
lp.Nombre, 
lp.UrlSitio, 
lp.ArchivoLogo, 
lp.ArchivoInstructivo,
isnull(lp.TextoPago,'') as TextoPago,
isnull(lp.Posicion,0) as Posicion
from LugarPago lp
inner join pais p 
on lp.paisid = p.paisid
--inner join ods.campania c
--on lp.CampaniaID = c.Codigo
where (@PaisID = 0 or (lp.PaisID = @PaisID))
--and (@CampaniaID = 0 or (lp.CampaniaID = @CampaniaID))
--and lp.ConsultoraID = @ConsultoraID
order by 2, 3, 4