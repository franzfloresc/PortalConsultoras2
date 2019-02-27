GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM   filtroseccion WHERE  campoes = 'seccion.keyword')
BEGIN
	DECLARE @Id int = (SELECT TablaLogicaDatosID from  filtroseccion where campoes = 'seccion.keyword')
	delete from filtrobuscador where tablalogicadatosid = @Id
	delete from filtroseccion where tablalogicadatosid = @Id
	delete from TablaLogicaDatos where TablaLogicaDatosID = @Id
END

GO
