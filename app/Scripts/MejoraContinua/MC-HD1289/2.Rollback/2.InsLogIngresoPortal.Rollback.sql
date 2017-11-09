USE BelcorpPeru
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpMexico
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpColombia
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpVenezuela
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpSalvador
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpPuertoRico
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpPanama
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpGuatemala
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpEcuador
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpDominicana
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpCostaRica
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpChile
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

USE BelcorpBolivia
GO

ALTER procedure [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100)
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int))
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError)
	END

GO

