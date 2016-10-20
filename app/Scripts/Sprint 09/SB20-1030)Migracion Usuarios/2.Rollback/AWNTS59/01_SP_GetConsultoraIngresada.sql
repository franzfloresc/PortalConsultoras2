USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
@Cantidad int
as

begin

	SELECT distinct TOP  (@Cantidad)
	C.Codigo, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
	Isnull(REPLACE(C.Email,'}',''), '') Email,
	Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
	Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
	IIF(I.TipoDocumento = 'CCI', IsNull(I.Numero, ''), '') Numero,
	C.IdEstadoActividad,
	C.CampanaInvitada,
	i.TipoDocumento,
	Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	Isnull(Z.GerenteZona,'') GerenteZona,
	Isnull(Z.Codigo,'') CodigoZona,
	Isnull(C.FechaCarga,'') FechaCarga,--R20151116
	Z.ZonaID -- R20151116
	FROM 
		ods.consultora C LEFT JOIN ods.Identificacion I
								on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
								LEFT JOIN Usuario U
								on C.Codigo = U.CodigoConsultora
								LEFT JOIN ods.Zona Z
								on C.ZonaID = Z.ZonaID
								
								
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 6
		and I.TipoDocumento = 'CCI'
		and (I.Numero <> '' or I.Numero <> null)
	
end
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
@Cantidad int
as

begin

       SELECT TOP  (@Cantidad)
       C.Codigo, 
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre, 
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre, 
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido, 
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
       Isnull(REPLACE(C.Email,'}',''), '') Email,
       Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
       Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
       IIF(I.TipoDocumento = 'RFC B', IsNull(I.Numero, ''), '') Numero,
       C.IdEstadoActividad,
       i.TipoDocumento,
       Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
       Isnull(Z.GerenteZona,'') GerenteZona,
       Isnull(Z.Codigo,'') CodigoZona,
       Isnull(C.FechaCarga,'') FechaCarga,--R20151116
       Z.ZonaID -- R20151116
       FROM 
             ods.consultora C LEFT JOIN ods.Identificacion I
                                                      on C.ConsultoraID = I.ConsultoraID AND RTRIM(LTRIM(I.DocumentoPrincipal)) = '1'
                                                      LEFT JOIN Usuario U
                                                      on C.Codigo = U.CodigoConsultora
                                                      LEFT JOIN ods.Zona Z
                                                      on C.ZonaID = Z.ZonaID
       WHERE
             U.CodigoConsultora IS NULL and LEN(I.Numero) > 6
             and (I.Numero <> '' or I.Numero <> null)
end
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[GetConsultoraIngresada] ---10000000
@Cantidad int
as

begin

	SELECT TOP  (@Cantidad)
	C.Codigo, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerNombre,''),',',''),'+',''),'"',''),';',''),'\','') PrimerNombre, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoNombre,''),',',''),'+',''),'"',''),';',''),'\','') SegundoNombre, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.PrimerApellido,''),',',''),'+',''),'"',''),';',''),'\','') PrimerApellido, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.SegundoApellido,''),',',''),'+',''),'"',''),';',''),'\','') SegundoApellido,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Isnull(C.NombreCompleto,''),',',''),'+',''),'"',''),';',''),'\','') NombreCompleto,
	Isnull(REPLACE(C.Email,'}',''), '') Email,
	Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TF'),'') Telefono,
	Isnull((SELECT TOP(1) Numero FROM ods.Telefono T WHERE C.ConsultoraID = T.ConsultoraID AND TipoTelefono = 'TM'),'') Celular,
	IIF(I.TipoDocumento = 'DNI', IsNull(I.Numero, ''), '') Numero,
	C.IdEstadoActividad,
	C.CampanaInvitada,
	i.TipoDocumento,
	Isnull(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	Isnull(Z.GerenteZona,'') GerenteZona,
	Isnull(Z.Codigo,'') CodigoZona,
	Isnull(C.FechaCarga,'') FechaCarga,--R20151116
	Z.ZonaID -- R20151116
	FROM 
		ods.consultora C LEFT JOIN ods.Identificacion I
								on C.ConsultoraID = I.ConsultoraID AND I.DocumentoPrincipal = '1'
								LEFT JOIN Usuario U
								on C.Codigo = U.CodigoConsultora
								LEFT JOIN ods.Zona Z
								on C.ZonaID = Z.ZonaID
	WHERE
		U.CodigoConsultora IS NULL and LEN(I.Numero) > 6
		and (I.Numero <> '' or I.Numero <> null)
end
GO