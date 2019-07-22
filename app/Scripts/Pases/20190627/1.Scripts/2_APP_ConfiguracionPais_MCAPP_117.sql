USE BelcorpPeru
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpMexico
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpColombia
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpSalvador
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpPuertoRico
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpPanama
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpGuatemala
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpEcuador
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpDominicana
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpCostaRica
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpChile
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpBolivia
GO

IF (NOT EXISTS(SELECT * FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE'))
BEGIN
    INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
    VALUES('BLOQUEO_PENDIENTE',1,'Indica si se ativa el bloqueo de pendiente en pase de pedido',1,0,0,0,0,0,0)
END

INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ACTIVA_BLOQUEO', 0, NULL,NULL,NULL, 'Columna estado=1: muesatra modal, 0: oculta modal', 0
    FROM [ConfiguracionPais] CP where CP.Codigo = 'BLOQUEO_PENDIENTE' AND
        NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ACTIVA_BLOQUEO' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO