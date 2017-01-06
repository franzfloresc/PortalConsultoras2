

USE BelcorpColombia
GO

DELETE FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día'
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 93
DELETE FROM Etiqueta WHERE Descripcion = 'Oferta del Día'

GO
/*end*/


USE BelcorpMexico
GO

DELETE FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día'
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 93
DELETE FROM Etiqueta WHERE Descripcion = 'Oferta del Día'

GO
/*end*/

USE BelcorpPeru
GO

DELETE FROM TipoEstrategia WHERE DescripcionEstrategia = 'Oferta del Día'
DELETE FROM TablaLogicaDatos WHERE TablaLogicaID = 93
DELETE FROM Etiqueta WHERE Descripcion = 'Oferta del Día'

GO
