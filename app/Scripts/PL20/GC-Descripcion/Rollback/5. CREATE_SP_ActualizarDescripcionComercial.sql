USE BelcorpBolivia
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpChile
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO


USE BelcorpColombia
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpDominicana
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpEcuador
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpMexico
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpPanama
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpPeru
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpSalvador
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'UpdMatrizComercialDescripcionComercial')
                    AND type IN ( N'P', N'PC' ) ) 
BEGIN
	DROP PROCEDURE UpdMatrizComercialDescripcionComercial;
END
GO

