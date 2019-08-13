USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO

USE BelcorpChile
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID
--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpColombia
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO

	
USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpMexico
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpPanama
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpPeru
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado =1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO


USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.UpdCdrWebDetalleCantidadObservado 
@CDRWebDetalleID int = 0,
@Cantidad int = 0,
@DetalleXML XML = NULL
as
begin

update CDRWebDetalle
set
	Cantidad2 = CASE WHEN @DetalleXML IS NOT NULL THEN Cantidad2 ELSE CASE @Cantidad WHEN 0 THEN Cantidad2 ELSE @Cantidad END END,
	DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
where 
	CDRWebDetalleID = @CDRWebDetalleID

--Actualizar la cabecera para que lo vuelva a tomar
update CDRWeb
set
	Estado = 1 --pendiente
where 
	CDRWebID IN (SELECT DISTINCT CDRWebId FROM dbo.CDRWebDetalle WHERE CDRWebDetalleID = @CDRWebDetalleID);

end
GO





