GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta S/. 30.00','pre-0-30', '0', '30.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','S/. 30.01 - S/. 50.00','pre-30-50', '30.01', '50.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','S/. 50.01 - S/. 70.00','pre-50-70', '50.01', '70.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','S/. 70.01 a más','pre-70-0', '70.01', '0')
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 200.00','pre-0-200', '0', '200.10')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 200.10 - $ 400.00','pre-200-400', '200.10', '400.10')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 400.10 - $ 600.00','pre-400-600', '400.10', '600.10')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 600.10 a más','pre-600-0', '600.10', '0')
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 25.000','pre-0-25', '0', '25001.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 25.001 - $ 50.000','pre-25-50', '25001.00', '50001.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 50.001 - $ 100.000','pre-50-100', '50001.00', '100001.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 100.001 a más','pre-100-0', '100001.00', '0')
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','pre-0-15', '0', '15.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - 30.00','pre-15-30', '15.01', '30.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 60.00','pre-30-60', '30.01', '60.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 60.01 a más','pre-60-0', '60.01', '0')
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 10.00','pre-0-10', '0', '10.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 10.01 - $ 20.00','pre-10-20', '10.01', '20.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 20.01 - $ 30.00','pre-20-30', '20.01', '30.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 30.01 a más','pre-30-0', '30.01', '0')
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','pre-0-15', '0', '15.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - $ 30.00','pre-15-30', '15.01', '30.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 45.00','pre-30-45', '30.01', '45.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 45.01 a más','pre-45-0', '45.01', '0')
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta Q. 80.00','pre-0-80', '0', '80.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','Q. 80.01  - Q. 160.00','pre-80-160', '80.01', '160.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','Q. 160.01 - Q. 320.00','pre-160-320', '160.01', '320.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','Q. 320.01 a más','pre-320-0', '320.01', '0')
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','pre-0-15', '0', '15.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - $ 30.00','pre-15-30', '15.01', '30.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 45.00','pre-30-45', '30.01', '45.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 45.01 a más','pre-45-0', '45.01', '0')
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta RD$ 325.00','pre-0-325', '0', '326.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','RD$ 326.00 - RD$ 525.00','pre-326-525', '326.00', '526.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','RD$ 526.00 - RD$ 725.00','pre-526-725', '526.00', '726.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','RD$ 726.00 a más','pre-726-0', '726.00', '0')
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta ¢ 7.990','pre-0-7990', '0', '7991.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','¢ 7.991 - ¢ 12.990','pre-7991-12990', '7991.00', '12991.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','¢ 12.991 - ¢ 17.990','pre-12991-17990', '12991.00', '17991.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','¢ 17.991 a más','pre-17991-0', '17991.00', '0')
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 8.000','pre-0-8000', '0', '8001.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 8.001 - $ 16.000','pre-8001-16000', '8001.00', '16001.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 16.001 - $ 32.000','pre-16001-32000', '16001.00', '32001.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 32.001 a más','pre-32001-0', '32001.00', '0')
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta Bs 60.00','pre-0-60', '0', '60.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','Bs 60.01 - Bs 100.00','pre-60-100', '60.01', '100.01')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','Bs 100.01 - Bs 150.00','pre-100-150', '100.01', '150.01')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','Bs 150.01 a más','pre-150-0', '150.01', '0')
END

GO
