USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO

USE [BelcorpVenezuela]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
CREATE PROCEDURE dbo.GetPremiosProgramaNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
	ISNULL(CodigoPrograma		,'') AS CodigoPrograma		,
	ISNULL(AnoCampana			, 0) AS AnoCampana			,
	ISNULL(CodigoNivel			,'') AS CodigoNivel			,
	ISNULL(CUV					,'') AS CUV					,
	ISNULL(DescripcionProducto	,'') AS DescripcionProducto	,
	ISNULL(IndicadorActivo		, 0) AS IndicadorActivo		,
	ISNULL(IndicadorKitNuevas	, 0) AS IndicadorKitNuevas	,
	ISNULL(PrecioUnitario		, 0) AS PrecioUnitario		
	from ods.premiosprogramanuevas  
	where codigoprograma=@CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or codigonivel = @CodigoNivel)

END
GO
