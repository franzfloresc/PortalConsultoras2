USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
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