GO
USE BelcorpPeru
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpMexico
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpColombia
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpSalvador
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpPanama
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpGuatemala
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpEcuador
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpDominicana
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpCostaRica
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpChile
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
USE BelcorpBolivia
GO

GO
IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'usp_SBMicroservicios_TipoEstrategia'
		)
BEGIN
	DROP PROCEDURE usp_SBMicroservicios_TipoEstrategia
END
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
    Codigo AS CodigoTipoEstrategia,
    TipoEstrategiaID,
    (CASE Codigo WHEN '001' THEN 'OPT'
        WHEN '009' THEN 'ODD'
        WHEN '005' THEN 'LAN'
        WHEN '007' THEN 'OPM'
        WHEN '008' THEN 'PAD'
        WHEN '010' THEN 'GND'
        WHEN '011' THEN 'HV'
        WHEN '030' THEN 'SR'
	END) as TipoPersonalizacion,
    DescripcionEstrategia AS DescripcionTipoEstrategia ,
    ImagenEstrategia,
    Orden,
    FlagActivo,
    FlagNueva,
    FlagRecoProduc ,
    FlagRecoPerfil,
    CodigoPrograma,
    FlagMostrarImg,
    MostrarImgOfertaIndependiente,
    ImagenOfertaIndependiente,
    Codigo,
    FlagValidarImagen,
    PesoMaximoImagen,
    UsuarioRegistro AS UsuarioCreacion,
    UsuarioModificacion ,
    FechaRegistro AS FechaCreacion,
    FechaModificacion
    FROM TipoEstrategia WITH (NOLOCK)
END
GO



GO
