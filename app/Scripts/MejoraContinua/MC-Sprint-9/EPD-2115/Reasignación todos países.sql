DECLARE @FechaSolicitud date = DATEADD(DAY,-2,getdate()) 
print @FechaSolicitud


USE [BelcorpEcuador]
--UPDATE TablaLogicaDatos SET Codigo = 24 where TablaLogicaDatosID =  5603  
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go

USE [BelcorpColombia] 
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go

USE [BelcorpChile] 
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go

USE [BelcorpMexico]
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go

USE [BelcorpBolivia]
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go

USE [BelcorpCostaRica]
UPDATE TablaLogicaDatos SET Codigo = 1 where TablaLogicaDatosID =  5604
go
UPDATE SolicitudCliente SET Estado = 'X' 
WHERE ISNULL(FlagConsultora, 0) = 0
AND Estado IS NULL
AND FechaSolicitud < @FechaSolicitud
go