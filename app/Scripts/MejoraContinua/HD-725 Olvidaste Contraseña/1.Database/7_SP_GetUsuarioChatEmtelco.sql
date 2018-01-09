USE BelcorpPeru
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpMexico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpColombia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpPanama
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpChile
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioChatEmtelco' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioChatEmtelco
END
GO
CREATE PROCEDURE dbo.GetUsuarioChatEmtelco
	@CodigoUsuario varchar(12)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.Email,
		isnull(C.PrimerNombre,'') as PrimerNombre,
		isnull(SI.Abreviatura,'Sin Seg.') as SegmentoAbreviatura
	from Usuario U with(nolock)
	inner join UsuarioRol UR with(nolock) ON U.CodigoUsuario = UR.CodigoUsuario
	inner join Rol R with(nolock) ON UR.RolID = R.RolID
	inner join ods.Consultora C with(nolock) on U.CodigoConsultora = C.Codigo
	left join ods.SegmentoInterno SI with(nolock) on C.SegmentoInternoId = SI.SegmentoInternoId
	where R.Sistema = 1 and U.CodigoUsuario = @CodigoUsuario;
END
GO

