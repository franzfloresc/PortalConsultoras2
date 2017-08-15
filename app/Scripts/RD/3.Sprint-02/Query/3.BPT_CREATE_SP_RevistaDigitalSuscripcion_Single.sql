USE BelcorpPeru
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpMexico
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpColombia
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpVenezuela
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpSalvador
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpPuertoRico
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpPanama
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpGuatemala
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpEcuador
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpDominicana
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpCostaRica
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpChile
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
/*end*/

USE BelcorpBolivia
GO

------------------------------------------------------------------
-- OBTENER UN REGISTRO DE LA TABLA RevistaDigitalSuscripcion
------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RevistaDigitalSuscripcion_Single]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
GO

CREATE PROCEDURE RevistaDigitalSuscripcion_Single
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN

	declare @CampaniaIDAnt int = 0

	if	@CampaniaID > 0
		select 
			@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
		from Pais where EstadoActivo = 1

	select top 1
		 RevistaDigitalSuscripcionID
		,CodigoConsultora
		,CampaniaID
		,FechaSuscripcion
		,FechaDesuscripcion
		,EstadoRegistro
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	 (CampaniaID <= @CampaniaIDAnt or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
	
END
GO
