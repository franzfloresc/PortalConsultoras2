GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta S/. 30.00','Hasta S/. 30.00', '0', '30')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','S/. 30.01 - S/. 50.00','S/. 30.01 - S/. 50.00', '30.01', '50')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','S/. 50.01 - S/. 70.00','S/. 50.01 - S/. 70.00', '50.01', '70')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','S/. 70.01 a más','S/. 70.01 a más', '70.01', '0')
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 200.00','Hasta $ 200.00', '0', '200.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 200.10 - $ 400.00','$ 200.10 - $ 400.00', '200.10', ' 400.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 400.10 - $ 600.00','$ 400.10 - $ 600.00', '400.10', '600.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 600.10 a más','$ 600.10 a más', '600.10', '0')
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 25.000','Hasta $ 25.000', '0', '25000.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 25.001 - $ 50.000','$ 25.001 - $ 50.000', '25001.00', '50000.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 50.001 - $ 100.000','$ 50.001 - $ 100.000', '50001.00', '100000.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 100.001 a más','$ 100.001 a más', '100001.00', '0')
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','Hasta $ 15.00', '0', '15.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - 30.00','$ 15.01 - 30.00', '15.01', '30.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 60.00','$ 30.01 - $ 60.00', '30.01', '60.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 60.01 a más','$ 60.01 a más', '60.01', '0')
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 10.00','Hasta $ 10.00', '0', '10.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 10.01 - $ 20.00','$ 10.01 - $ 20.00', '10.01', '20.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 20.01 - $ 30.00','$ 20.01 - $ 30.00', '20.01', '30.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 30.01 a más','$ 30.01 a más', '30.01', '0')
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','Hasta $ 15.00', '0', '15.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - $ 30.00','$ 15.01 - $ 30.00', '15.01', '30.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 45.00','$ 30.01 - $ 45.00', '30.01', '45.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 45.01 a más','$ 45.01 a más', '45.01', '0')
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta Q. 80.00','Hasta Q. 80.00', '0', '80.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','Q. 80.01  - Q. 160.00','Q. 80.01  - Q. 160.00', '80.01', '160.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','Q. 160.01 - Q. 320.00','Q. 160.01 - Q. 320.00', '160.01', '320.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','Q. 320.01 a más','Q. 320.01 a más', '320.01', '0')
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 15.00','Hasta $ 15.00', '0', '15.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 15.01 - $ 30.00','$ 15.01 - $ 30.00', '15.01', '30.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 30.01 - $ 45.00','$ 30.01 - $ 45.00', '30.01', '45.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 45.01 a más','$ 45.01 a más', '45.01', '0')
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta RD$ 325.00','Hasta RD$ 325.00', '0', '325.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','RD$ 326.00 - RD$ 525.00','RD$ 326.00 - RD$ 525.00', '326.00', '525.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','RD$ 526.00 - RD$ 725.00','RD$ 526.00 - RD$ 725.00', '526.00', '725.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','RD$ 726.00 a más','RD$ 726.00 a más', '726.00', '0')
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta ¢ 7.990','Hasta ¢ 7.990', '0', '7990.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','¢ 7.991 - ¢ 12.990','¢ 7.991 - ¢ 12.990', '7991.00', '12990.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','¢ 12.991 - ¢ 17.990','¢ 12.991 - ¢ 17.990', '12991.00', '17990.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','¢ 17.991 a más','¢ 17.991 a más', '17991.00', '0')
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta $ 8.000','Hasta $ 8.000', '0', '8000.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','$ 8.001 - $ 16.000','$ 8.001 - $ 16.000', '8001.00', '16000.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','$ 16.001 - $ 32.000','$ 16.001 - $ 32.000', '16001.00', '32000.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','$ 32.001 a más','$ 32.001 a más', '32001.00', '0')
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '301')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '301','Hasta Bs 60.00','Hasta Bs 60.00', '0', '60.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '302')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '302','Bs 60.01 - Bs 100.00','Bs 60.01 - Bs 100.00', '60.01', '100.00')
END
IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '303')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '303','Bs 100.01 - Bs 150.00','Bs 100.01 - Bs 150.00', '100.01', '150.00')
END

IF NOT EXISTS (SELECT 1 FROM FiltroBuscador WHERE Codigo = '304')
BEGIN
	INSERT INTO FiltroBuscador (TablaLogicaDatosID, Estado, Codigo, Nombre, Descripcion, ValorMinimo, ValorMaximo)
	VALUES (14803, 1, '304','Bs 150.01 a más','Bs 150.01 a más', '150.01', '0')
END

GO
