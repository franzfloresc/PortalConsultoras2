<<<<<<< HEAD
USE BelcorpBolivia
=======
﻿USE BelcorpBolivia;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpChile
=======
USE BelcorpChile;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpColombia
=======
USE BelcorpColombia;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpCostaRica
=======
USE BelcorpCostaRica;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpDominicana
=======
USE BelcorpDominicana;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpEcuador
=======
USE BelcorpEcuador;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpGuatemala
=======
USE BelcorpGuatemala;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpMexico
=======
USE BelcorpMexico;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpPanama
=======
USE BelcorpPanama;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpPeru
=======
USE BelcorpPeru;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpPuertoRico
=======
USE BelcorpPuertoRico;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO
<<<<<<< HEAD

USE BelcorpSalvador
=======
USE BelcorpSalvador;
>>>>>>> origin/HD-2849
GO
ALTER PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
<<<<<<< HEAD
GO
=======
GO
>>>>>>> origin/HD-2849
