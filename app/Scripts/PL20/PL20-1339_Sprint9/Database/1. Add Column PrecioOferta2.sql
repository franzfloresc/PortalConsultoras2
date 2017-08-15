

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'PrecioOferta2' AND OBJECT_ID = OBJECT_ID(N'ShowRoom.OfertaShowRoom'))
BEGIN
	ALTER TABLE ShowRoom.OfertaShowRoom
	DROP COLUMN PrecioOferta2
END  
GO

ALTER TABLE ShowRoom.OfertaShowRoom
ADD PrecioOferta2 DECIMAL(12,2);
GO

