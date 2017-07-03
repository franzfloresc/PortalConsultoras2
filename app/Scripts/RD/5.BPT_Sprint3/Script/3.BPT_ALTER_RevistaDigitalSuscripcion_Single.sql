USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
	-- declare @CampaniaIDAnt int = 0
	-- if	@CampaniaID > 0
	--	select 
	--		@CampaniaIDAnt = dbo.fnAddCampaniaAndNumero(CodigoISO, @CampaniaID, -2) 
	--	from Pais where EstadoActivo = 1
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
		and	 (CampaniaID <= @CampaniaID or @CampaniaID = 0)
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END
GO
/*end*/

