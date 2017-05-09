USE BelcorpPeru
GO
DELETE FROM  dbo.UsuarioExternoPais;
GO
INSERT INTO dbo.UsuarioExternoPais(
	PaisID,
	CodigoISO,
	Proveedor,
	IdAplicacion	
)
SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpBolivia.dbo.UsuarioExterno UE
INNER JOIN BelcorpBolivia.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpChile.dbo.UsuarioExterno UE
INNER JOIN BelcorpChile.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpColombia.dbo.UsuarioExterno UE
INNER JOIN BelcorpColombia.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpCostaRica.dbo.UsuarioExterno UE
INNER JOIN BelcorpCostaRica.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpDominicana.dbo.UsuarioExterno UE
INNER JOIN BelcorpDominicana.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpEcuador.dbo.UsuarioExterno UE
INNER JOIN BelcorpEcuador.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpGuatemala.dbo.UsuarioExterno UE
INNER JOIN BelcorpGuatemala.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpMexico.dbo.UsuarioExterno UE
INNER JOIN BelcorpMexico.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpPanama.dbo.UsuarioExterno UE
INNER JOIN BelcorpPanama.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpPeru.dbo.UsuarioExterno UE
INNER JOIN BelcorpPeru.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpPuertoRico.dbo.UsuarioExterno UE
INNER JOIN BelcorpPuertoRico.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpSalvador.dbo.UsuarioExterno UE
INNER JOIN BelcorpSalvador.dbo.Pais P ON P.EstadoActivo = 1

UNION ALL

SELECT 
	P.PaisID,
	P.CodigoISO,
	UE.Proveedor,
	UE.IdAplicacion
FROM BelcorpVenezuela.dbo.UsuarioExterno UE
INNER JOIN BelcorpVenezuela.dbo.Pais P ON P.EstadoActivo = 1;