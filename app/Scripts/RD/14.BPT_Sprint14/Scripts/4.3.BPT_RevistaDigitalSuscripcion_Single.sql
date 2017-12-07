USE BelcorpPeru
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpMexico
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpColombia
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpVenezuela
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpSalvador
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpPuertoRico
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpPanama
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpGuatemala
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpEcuador
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpDominicana
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpCostaRica
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpChile
GO

go
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
		,CampaniaEfectiva
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

go

USE BelcorpBolivia
GO

go
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
		,CampaniaEfectiva
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

go

