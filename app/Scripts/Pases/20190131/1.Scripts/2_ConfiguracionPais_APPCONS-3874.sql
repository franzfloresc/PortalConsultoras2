USE BelcorpPeru
GO
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID
FROM dbo.ConfiguracionPais
WHERE Codigo = 'DATAMI'

DELETE FROM dbo.ConfiguracionPaisDetalle
WHERE ConfiguracionPaisID = @ConfiguracionPaisID

DELETE FROM dbo.ConfiguracionPais
WHERE Codigo = 'DATAMI'
GO
INSERT INTO dbo.ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT) 
VALUES ('DATAMI',0,'Datos Patrocinados con Datami',1,0,0,0,0,0,0)
GO
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID
FROM dbo.ConfiguracionPais
WHERE Codigo = 'DATAMI'
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'30','3033',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'30','3042',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'30','3036',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'50','5034',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'50','5044',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'50','5051',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'50','5053',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'30','3017',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'50','5054',1)
INSERT INTO dbo.ConfiguracionPaisDetalle (ConfiguracionPaisID,CodigoRegion,CodigoZona,Estado) VALUES (@ConfiguracionPaisID,'30','3018',1)
GO