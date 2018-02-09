IF COL_LENGTH('Estrategia', 'OfertaShowRoomID') IS NULL
BEGIN	
	ALTER TABLE Estrategia ADD OfertaShowRoomID INT NULL
END

IF COL_LENGTH('EstrategiaProducto', 'OfertaShowRoomDetalleID') IS NULL
BEGIN
	ALTER TABLE EstrategiaProducto ADD OfertaShowRoomDetalleID INT NULL
END
