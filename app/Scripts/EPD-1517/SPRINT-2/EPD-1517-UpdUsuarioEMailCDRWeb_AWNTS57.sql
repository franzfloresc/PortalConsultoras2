
USE [BelcorpBolivia]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpChile]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpCostaRica]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpDominicana]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpEcuador]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpGuatemala]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO


/*end*/

USE [BelcorpPanama]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/

USE [BelcorpPuertoRico]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/


USE [BelcorpSalvador]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO

/*end*/


USE [BelcorpVenezuela]
GO
IF EXISTS(
SELECT 1
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE SPECIFIC_NAME = 'UpdUsuarioEMailCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdProcesoSiccOnline
END
GO

CREATE PROCEDURE [dbo].[UpdUsuarioEMailCDRWeb]
@ConsultoraID bigint,
@EMail varchar(50),
@Telefono varchar(20),
@RetornoSiNoCorreoNuevo int output
AS
BEGIN

	declare @SiNoNuevo int
	declare @Codigo varchar(25)
	select @Codigo = Codigo from ods.Consultora where ConsultoraID = @ConsultoraID


	declare @Existe int
	set @Existe = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(EMail)) = ltrim(rtrim(@EMail)))
	
	declare @ExisteTelefono int
	set @ExisteTelefono = (select Count(CodigoConsultora) from Usuario 
					where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo)) and ltrim(rtrim(Celular)) = ltrim(rtrim(@Telefono)))

	if @Existe = 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		EMail = @EMail
		,Celular = @Telefono
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	if @Existe > 0 and @ExisteTelefono = 0
	begin
		update Usuario set
		Celular = @Telefono
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 0
	end

	if @Existe = 0 and @ExisteTelefono > 0
	begin
		update Usuario set
		EMail = @EMail
		,EMailActivo = 0
		,FechaModificacion = GETDATE()
		,Modificado = 1
		where ltrim(rtrim(CodigoConsultora)) = ltrim(rtrim(@Codigo))

		set @SiNoNuevo = 1
	end

	set @RetornoSiNoCorreoNuevo = @SiNoNuevo
END

GO
