USE [BelcorpBolivia];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpChile];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpColombia];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpCostaRica];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpDominicana];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpEcuador];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpGuatemala];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpMexico];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpPanama];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpPeru];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpPuertoRico];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
USE [BelcorpSalvador];
GO
use belcorpbolivia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO
use BelcorpChile
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpColombia
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpCostaRica
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpDominicana
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpEcuador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpGuatemala
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpMexico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPanama
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPeru
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpPuertoRico
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

use BelcorpSalvador
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCargaListadoPopupValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCargaListadoPopupValidador]
GO

GO
