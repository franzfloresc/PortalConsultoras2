USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.fnObtenerPromedioVentaCampaniaConsecutivas') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnObtenerPromedioVentaCampaniaConsecutivas
END
GO
