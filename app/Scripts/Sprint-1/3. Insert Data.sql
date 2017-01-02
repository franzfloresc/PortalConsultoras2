
USE BelcorpPeru
GO

INSERT INTO TipoEstrategia (
DescripcionEstrategia,ImagenEstrategia,
Orden,FlagActivo,UsuarioRegistro,
FechaRegistro,UsuarioModificacion,FechaModificacion,
FlagNueva,FlagRecoProduc,FlagRecoPerfil,
CodigoPrograma,FlagMostrarImg)
VALUES 
('Oferta del Día', '',
6,1,'ADMCONTENIDO',
GETDATE(),'ADMCONTENIDO',GETDATE(),
0,0,1,
'',0)

GO

INSERT INTO TablaLogicaDatos (
TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
VALUES 
(9301, 93,'black','Color fondo banner'),
(9302, 93,'black','Color fondo display')

GO

INSERT INTO Etiqueta (
Descripcion,UsuarioCreacion,UsuarioModificacion,
FechaCreacion,FechaModificacion,Estado)
VALUES(
'Oferta del Día', 'ADMCONTENIDO', NULL, 
GETDATE(), NULL, 1)

GO
