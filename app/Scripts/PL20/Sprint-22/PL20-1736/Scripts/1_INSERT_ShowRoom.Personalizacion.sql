

USE BelcorpBolivia
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpChile
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpColombia
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpDominicana
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpEcuador
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpMexico
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpPanama
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpPeru
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpSalvador
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS
(
    SELECT 1
    FROM ShowRoom.Personalizacion
    WHERE TipoAplicacion = 'Desktop'
          AND Atributo = 'ImagenFondoOfertaFinalRegalo'
          AND TipoPersonalizacion = 'EVENTO'
)
BEGIN

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Desktop', 'Titulo1OfertaFinalRegalo', 'Titulo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ImagenFondoOfertaFinalRegalo', 'Imagen de Fondo OfertaFinal Regalo', 'IMAGEN', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'Titulo1OfertaFinalRegalo', 'Titutlo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

    INSERT INTO ShowRoom.Personalizacion
    (
        TipoAplicacion,
        Atributo,
        TextoAyuda,
        TipoAtributo,
        TipoPersonalizacion,
        Orden,
        Estado
    )
    VALUES
    (   'Mobile', 'ColorFondo1OfertaFinalRegalo', 'Color Fondo 1 OfertaFinal Regalo', 'TEXTO', 'EVENTO',
        (
            SELECT MAX(Orden) + 1 FROM ShowRoom.Personalizacion
        ), 1);

END;
GO





