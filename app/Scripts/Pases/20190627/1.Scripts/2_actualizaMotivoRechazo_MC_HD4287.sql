USE [BelcorpBolivia];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpChile];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpColombia];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpCostaRica];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpDominicana];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpEcuador];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpGuatemala];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpMexico];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpPanama];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpPeru];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpPuertoRico];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
USE [BelcorpSalvador];
GO




--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Tengo productos en stock'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO


    update MotivoSolicitud 
	SET Motivo = 'Productos agotados'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('Pruebo la herramienta',3,1)	
END 
GO

IF (NOT EXISTS(SELECT MotivoSolicitudID FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente')) 
BEGIN 
    INSERT  MotivoSolicitud  VALUES('No conozco el cliente',3,1)	
END 
GO

GO
