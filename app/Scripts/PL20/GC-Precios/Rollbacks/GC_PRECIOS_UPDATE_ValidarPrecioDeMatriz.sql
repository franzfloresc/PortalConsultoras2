USE BelcorpBolivia
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpChile
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpColombia
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpDominicana
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpEcuador
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpMexico
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpPanama
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;
USE BelcorpPeru
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpSalvador
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'ValidarPreciosDeMatriz')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE ValidarPreciosDeMatriz;






