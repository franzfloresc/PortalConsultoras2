GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO