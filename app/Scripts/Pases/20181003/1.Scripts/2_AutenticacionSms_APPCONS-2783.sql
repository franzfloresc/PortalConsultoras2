
USE BelcorpPeru
GO

/* Habilitar en el Flujo de Autenticacion la Opción de Constraseña */
UPDATE OpcionesVerificacion 
	SET OpcionContrasena = 1, 
		IntentosSms = 2 
WHERE origenID = 2;
GO

USE BelcorpBolivia
GO

/* Habilitar en el Flujo de Autenticacion la Opción de Constraseña */
UPDATE OpcionesVerificacion 
	SET OpcionContrasena = 1, 
	IntentosSms = 2 
WHERE origenID = 2;
GO
