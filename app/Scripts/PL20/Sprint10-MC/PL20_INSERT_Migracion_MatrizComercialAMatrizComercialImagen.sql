USE BelcorpBolivia
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
		DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
		DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;
END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpPeru
GO


BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpPuertoRico
GO

BEGIN
		DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpSalvador
GO


BEGIN
	DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
		DELETE FROM MatrizComercialImagen;
	INSERT INTO MatrizComercialImagen (IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
	SELECT IdMatrizComercial, Foto, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion FROM (
	SELECT IdMatrizComercial, FotoProducto01 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial 
	WHERE FotoProducto01 IS NOT NULL AND DATALENGTH(FotoProducto01) != 0
	UNION 
	SELECT IdMatrizComercial, FotoProducto02 as Foto,
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto02 IS NOT NULL AND DATALENGTH(FotoProducto02) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto03 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto03 IS NOT NULL AND DATALENGTH(FotoProducto03) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto04 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto04 IS NOT NULL AND DATALENGTH(FotoProducto04) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto05 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto05 IS NOT NULL AND DATALENGTH(FotoProducto05) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto06 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto06 IS NOT NULL AND DATALENGTH(FotoProducto06) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto07 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto07 IS NOT NULL AND DATALENGTH(FotoProducto07) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto08 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto08 IS NOT NULL AND DATALENGTH(FotoProducto08) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto09 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto09 IS NOT NULL AND DATALENGTH(FotoProducto09) != 0
	UNION
	SELECT IdMatrizComercial, FotoProducto10 as Foto, 
			UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion 
	FROM MatrizComercial
	WHERE FotoProducto10 IS NOT NULL AND DATALENGTH(FotoProducto10) != 0
	) as t order by FechaRegistro asc;

END
GO

	 