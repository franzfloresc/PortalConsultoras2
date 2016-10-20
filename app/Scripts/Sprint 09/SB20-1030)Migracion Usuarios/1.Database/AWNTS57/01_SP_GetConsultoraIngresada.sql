USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] --1000
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(C.Email, '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.TipoDocumento = 'CI'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL
		AND (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] --1000
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(C.Email, '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM  ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.TipoDocumento = 'RUT'
	LEFT JOIN ConsultoraIngreso U on C.Codigo = U.Codigo
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE U.Codigo IS NULL;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada]
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(C.Email, '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 3
		AND (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\',''),'>',' ') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\',''),'>',' ') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\',''),'>',' ') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\',''),'>',' ') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\',''),'>',' ') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IIF(I.TipoDocumento = 'CV', IsNull(I.Numero, ''), '') Numero,
		C.IdEstadoActividad,
		i.TipoDocumento,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND RTRIM(LTRIM(I.DocumentoPrincipal)) = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 6
		AND (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and
		((LEN(I.Numero) = 10 AND I.TipoDocumento = 'CCI') OR  (I.TipoDocumento = 'PSSPT'))
		AND (I.Numero <> '' or I.Numero <> null)
	ORDER BY
		IdEstadoActividad, PrimerNombre, SegundoNombre;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada]
	@Cantidad int
AS
BEGIN
	SELECT TOP  (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 3
		AND (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada]
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C 
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 3
		AND (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IIF(I.TipoDocumento = 'NSS', IsNull(I.Numero, ''), '') Numero,
		C.IdEstadoActividad,
		i.TipoDocumento,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND RTRIM(LTRIM(I.DocumentoPrincipal)) = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 6
		and (I.Numero <> '' or I.Numero <> null);
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada]
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 3
		and (I.Numero <> '' or I.Numero <> null);
end
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada]
	@Cantidad int
AS
BEGIN
	SELECT TOP (@Cantidad)
		C.Codigo,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
		Isnull(REPLACE(C.Email,'}',''), '') Email,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TT'),'') TelefonoTrabajo,
		Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
		IsNull(I.Numero, '') Numero,
		C.IdEstadoActividad,
		i.TipoDocumento,
		Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
		Isnull(Z.GerenteZona,'') GerenteZona,
		Isnull(Z.Codigo,'') CodigoZona,
		Isnull(C.FechaCarga,'') FechaCarga,--R20151116
		Z.ZonaID -- R20151116
	FROM ods.consultora C
	LEFT JOIN ods.Identificacion I on C.ConsultoraID = I.ConsultoraID AND I.TipoDocumento = 'CCI' --AND I.DocumentoPrincipal = '1'
	LEFT JOIN Usuario U on C.Codigo = U.CodigoConsultora
	LEFT JOIN ods.Zona Z on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 4
		and (I.Numero <> '' or I.Numero <> null);
END
GO