USE BelcorpPeru
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpMexico
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpColombia
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpVenezuela
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpSalvador
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpPuertoRico
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpPanama
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpGuatemala
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpEcuador
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpDominicana
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpCostaRica
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpChile
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

USE BelcorpBolivia
GO

GO

DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update RevistaDigitalSuscripcion
set CampaniaEfectiva = dbo.fnAddCampaniaAndNumero(@PaisIso, CampaniaID, 1)

GO

