USE [BelcorpPeru]  
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
CREATE PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate				
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
GO
