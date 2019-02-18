USE BelcorpPeru
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpMexico
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpColombia
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpSalvador
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpPuertoRico
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpPanama
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpGuatemala
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpEcuador
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpDominicana
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpCostaRica
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpChile
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

USE BelcorpBolivia
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';

	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END

