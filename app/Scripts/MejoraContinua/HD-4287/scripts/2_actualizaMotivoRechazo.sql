



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
