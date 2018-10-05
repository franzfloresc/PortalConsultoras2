
use belcorpBolivia
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpChile
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpColombia
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpCostaRica
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpDominicana
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpEcuador
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpGuatemala
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpMexico
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpPanama
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpPeru
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpPuertoRico
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 

use belcorpSalvador
go

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter  PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)

AS

SET NOCOUNT ON; 



SELECT ofmm.CampaniaId AS Campania



	,c.Codigo AS Codigo



	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre



	,u.CUV AS CuvRegalo



	,u.Nombre AS NombreRegalo



	,ofmm.MontoMeta AS MontoInicial



	,GapMinimo AS RangoInicial



	,GapMaximo AS RangoFinal



	,GapAgregar AS MontoAgregar



	,ofmm.MontoMeta



	,ofmm.MontoPedidoFinal AS MontoGanador



	,ofmm.FechaRegistro AS FechaRegistro



	,ofmm.MontoPedido



FROM OfertaFinalMontoMeta ofmm

INNER JOIN Upselling up on up.CodigoCampana = ofmm.CampaniaId

INNER JOIN UpsellingDetalle u ON u.Upsellingid = up.Upsellingid 

INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId

 where u.Upsellingid = @UpsellingId 



ORDER BY ofmm.FechaRegistro DESC


go
 
