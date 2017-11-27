
DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 2)
where CampaniaEfectiva is null

