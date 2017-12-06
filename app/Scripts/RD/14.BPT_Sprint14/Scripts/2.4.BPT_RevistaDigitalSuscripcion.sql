GO
USE BelcorpPeru
GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 2)
where CampaniaEfectiva is null or CampaniaEfectiva = 0

GO

GO
USE BelcorpChile
GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 2)
where CampaniaEfectiva is null or CampaniaEfectiva = 0

GO

GO
USE BelcorpCostaRica
GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 2)
where CampaniaEfectiva is null or CampaniaEfectiva = 0

GO