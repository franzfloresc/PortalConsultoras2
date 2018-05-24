USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RevistaDigitalSuscripcion_SingleActiva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
GO

CREATE PROCEDURE [dbo].[RevistaDigitalSuscripcion_SingleActiva]
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

