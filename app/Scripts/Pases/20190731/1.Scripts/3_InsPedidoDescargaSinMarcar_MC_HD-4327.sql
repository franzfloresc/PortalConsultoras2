use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go

use  [BelcorpChile]
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go






use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[InsPedidoDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsPedidoDescargaSinMarcar]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 24/06/2019      
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR  
*/ 
CREATE PROC [dbo].[InsPedidoDescargaSinMarcar] @ESTADO         TINYINT, 
                                               @TIPOCRONOGRAMA INT, 
                                               @CAMPANAID      INT, 
                                               @USUARIO        VARCHAR(20), 
                                               @NROLOTE        INT OUTPUT 
AS 
    DECLARE @FECHAGENERAL DATETIME 

    SET @FECHAGENERAL = DBO.FNOBTENERFECHAHORAPAIS() 
    SET @NROLOTE = NEXT VALUE FOR DBO.SECUENCIALOTESINMARCAR 

    INSERT INTO DBO.PEDIDODESCARGASINMARCAR 
                (NROLOTE, 
                 CAMPANAID, 
                 TIPOCRONOGRAMA, 
                 ESTADO, 
                 FECHAINICIO, 
                 USUARIO) 
    VALUES      (@NROLOTE, 
                 @CAMPANAID, 
                 @TIPOCRONOGRAMA, 
                 @ESTADO, 
                 @FECHAGENERAL, 
                 @USUARIO); 


/*VERIFICAMOS SI ESTA LIBRE PARA */
IF((SELECT COUNT(1) FROM pedidodescargavalidador ) <= 0)BEGIN
insert into pedidodescargavalidador
select @NROLOTE,@CAMPANAID,1,getdate(),@USUARIO
END
BEGIN
UPDATE pedidodescargavalidador SET NroLote=@NROLOTE,CampanaId= @CAMPANAID,Estado=1  , FechaProceso=GETDATE(), Usuario=@USUARIO
END

go








