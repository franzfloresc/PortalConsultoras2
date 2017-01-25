
USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF
END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpChile
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON

	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON

	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON

	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO
/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día')
BEGIN

	SET IDENTITY_INSERT TipoEstrategia ON
	
	INSERT INTO TipoEstrategia (
	TipoEstrategiaID,DescripcionEstrategia,ImagenEstrategia,
	Orden,FlagActivo,UsuarioRegistro,
	FechaRegistro,UsuarioModificacion,FechaModificacion,
	FlagNueva,FlagRecoProduc,FlagRecoPerfil,
	CodigoPrograma,FlagMostrarImg)
	VALUES 
	(3014,'Oferta del Día', '',
	6,1,'ADMCONTENIDO',
	GETDATE(),'ADMCONTENIDO',GETDATE(),
	0,0,1,
	'',0)
	
	SET IDENTITY_INSERT TipoEstrategia OFF

END

IF NOT EXISTS (SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 93)
BEGIN
	INSERT INTO TablaLogicaDatos (
	TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	VALUES 
	(9301, 93,'black','Color fondo banner'),
	(9302, 93,'black','Color fondo display')

END

IF NOT EXISTS (SELECT 1 FROM Etiqueta WHERE Descripcion = 'Oferta del Día')
BEGIN
	SET IDENTITY_INSERT Etiqueta ON
	
	INSERT INTO Etiqueta (
	EtiquetaID,Descripcion,UsuarioCreacion,
	UsuarioModificacion,FechaCreacion,FechaModificacion,
	Estado)
	VALUES(
	3004,'Oferta del Día','ADMCONTENIDO', 
	NULL,GETDATE(),NULL,
	1)
	
	SET IDENTITY_INSERT Etiqueta OFF
END

GO



