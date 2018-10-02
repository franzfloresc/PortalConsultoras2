USE BelcorpPeru
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpMexico
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpColombia
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '0', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '0', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpSalvador
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpPuertoRico
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpPanama
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpGuatemala
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpEcuador
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpDominicana
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpCostaRica
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '0', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '0', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpChile
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

USE BelcorpBolivia
GO

BEGIN
	DECLARE @configPaisSR as int
	DECLARE @configPaisRD as int

	SELECT @configPaisSR = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'SR';

	SELECT @configPaisRD = ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'RD';
	
	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisSR and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisSR, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)

	DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID = @configPaisRD and Codigo = 'BloqueoProductoDigital';
	 
	INSERT ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente) VALUES (@configPaisRD, 'BloqueoProductoDigital', 0, '1', NULL, NULL, 'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva', 1, NULL)
END
GO

