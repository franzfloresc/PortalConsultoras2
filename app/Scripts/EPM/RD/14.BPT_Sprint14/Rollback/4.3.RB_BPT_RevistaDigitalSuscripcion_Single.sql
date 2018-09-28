USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_Single]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int = 0
)
AS
BEGIN
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

