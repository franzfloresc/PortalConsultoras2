USE BelcorpPeru
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpMexico
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpColombia
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpSalvador
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpPuertoRico
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpPanama
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpGuatemala
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpEcuador
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpDominicana
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpCostaRica
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpChile
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

USE BelcorpBolivia
GO

DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'ATP'

DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeActivo'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgExtension'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAncho'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeImgAlto'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjMedida'
DELETE FROM dbo.ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @ConfiguracionPaisID AND Codigo = 'AppOfertasHomeMsjFormato'

INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeActivo', 0, '1', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgExtension', 0, 'jpg', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAncho', 0, '840', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeImgAlto', 0, '560', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjMedida', 0, 'Las medidas no son correctas. Vuelve a intentar, por favor.', 1)
INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Estado) VALUES (@ConfiguracionPaisID, 'AppOfertasHomeMsjFormato', 0, 'El formato no es correcto. Vuelve a intentar, por favor.', 1)
GO

