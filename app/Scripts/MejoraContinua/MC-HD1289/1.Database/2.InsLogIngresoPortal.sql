USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsLogIngresoPortal]
	@CodigoConsultora varchar(25),
	@IPOrigen varchar(25),
	@Tipo tinyint,
	@DetalleError varchar(100), 
	@Canal CHAR(1) = ''
as
	IF @Tipo = 1
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortal]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,cast(@DetalleError as int), @Canal)
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[LogIngresoPortalError]
		VALUES(@CodigoConsultora,dbo.fnObtenerFechaHoraPais(),@IPOrigen,@DetalleError, @Canal)
	END

GO

