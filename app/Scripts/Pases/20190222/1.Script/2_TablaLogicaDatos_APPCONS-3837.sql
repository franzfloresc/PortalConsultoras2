USE BelcorpPeru
GO
DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 154
DELETE FROM dbo.TablaLogica WHERE TablaLogicaID = 154
INSERT INTO dbo.TablaLogica (TablaLogicaID, Descripcion) VALUES (154, 'Ubigeo País')
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor) VALUES (15401, 154, '01', 'Departamento', '1')
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor) VALUES (15402, 154, '02', 'Provincia', '2')
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor) VALUES (15403, 154, '03', 'Distrito', '3')
GO
USE BelcorpChile
GO
DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 154
DELETE FROM dbo.TablaLogica WHERE TablaLogicaID = 154
INSERT INTO dbo.TablaLogica (TablaLogicaID, Descripcion) VALUES (154, 'Ubigeo País')
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor) VALUES (15401, 154, '01', 'Región', '1')
INSERT INTO dbo.TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion, Valor) VALUES (15402, 154, '02', 'Comuna', '2')
GO