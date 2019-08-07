﻿GO
USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpMexico
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpColombia
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpSalvador
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpPuertoRico
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpPanama
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpGuatemala
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpEcuador
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpDominicana
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpCostaRica
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpChile
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
USE BelcorpBolivia
GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]

GO
