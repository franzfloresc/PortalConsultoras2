



--- el MotivoSolicitudID está reservado para "otros"

    update MotivoSolicitud 
	SET Motivo = 'Yo no puedo atender su pedido.'
	WHERE Tipo = 3 and MotivoSolicitudID=7

GO

    update MotivoSolicitud 
	SET Motivo = 'El cliente vive muy lejos'
	WHERE Tipo = 3 and MotivoSolicitudID=8

GO


    update MotivoSolicitud 
	SET Motivo = 'El/los productos están agotados en esta campaña.'
	WHERE Tipo = 3 and MotivoSolicitudID=9

GO

    update MotivoSolicitud 
	SET Motivo = 'No pasaré pedido esta campaña.'
	WHERE Tipo = 3 and MotivoSolicitudID=10
 
GO

delete FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='Pruebo la herramienta'
GO

delete FROM MotivoSolicitud WHERE Tipo = 3 and Motivo='No conozco el cliente'
go

