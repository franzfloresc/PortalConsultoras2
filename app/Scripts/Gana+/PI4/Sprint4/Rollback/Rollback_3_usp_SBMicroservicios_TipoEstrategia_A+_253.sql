USE BelcorpColombia_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO

USE BelcorpPeru_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO

USE BelcorpChile_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO

USE BelcorpCostaRica_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO

USE BelcorpEcuador_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO

USE BelcorpMexico_GANAMAS;
GO

IF(OBJECT_ID('dbo.usp_SBMicroservicios_TipoEstrategia','P') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.usp_SBMicroservicios_TipoEstrategia;
END;
GO

CREATE PROCEDURE [dbo].[usp_SBMicroservicios_TipoEstrategia] 
AS
BEGIN
	SET NOCOUNT ON;
    SELECT 
        Codigo AS CodigoTipoEstrategia, 
        TipoEstrategiaID, 
        (
            CASE Codigo 
                WHEN '001' THEN 'OPT'
                WHEN '009' THEN 'ODD'
                WHEN '005' THEN 'LAN'
                WHEN '007' THEN 'OPM' 
                WHEN '008' THEN 'PAD' 
                WHEN '010' THEN 'GND' 
                WHEN '011' THEN 'HV' 
                WHEN '030' THEN 'SR'
                WHEN '004' THEN 'ATP' END
        ) as TipoPersonalizacion,
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
    FROM TipoEstrategia WITH (NOLOCK);
END
GO
