USE BelcorpChile
GO

IF EXISTS(SELECT * FROM PopupPais WHERE Descripcion LIKE 'AsesoraOnline')
BEGIN
	DELETE FROM PopupPais WHERE Descripcion LIKE 'AsesoraOnline'; 
END
GO