GO
IF NOT EXISTS(SELECT 1 FROM PopupPais WHERE Descripcion = 'AsesoraOnline')
BEGIN
	INSERT INTO PopupPais(
		CodigoPopup,
		Descripcion,
		CodigoISO,
		Orden,
		Activo
	)
	SELECT
		12,
		'AsesoraOnline', 
		CodigoISO,
		11,
		0
	FROM Pais
	WHERE EstadoActivo = 1;
END
GO