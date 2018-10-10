USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
(
	 @CodigoConsultora varchar(20)
	,@CampaniaID int
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
		,Origen
		,EstadoEnvio
		,IsoPais
		,CodigoZona
		,EMail
	from RevistaDigitalSuscripcion
	where CodigoConsultora = @CodigoConsultora  
		and	CampaniaEfectiva <= @CampaniaID
	order by CampaniaID desc, RevistaDigitalSuscripcionID desc
END

GO

