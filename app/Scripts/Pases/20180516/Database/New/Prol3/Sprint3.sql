USE BelcorpBolivia
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_BO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_BO.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpChile
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CL.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CL.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpColombia
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CO.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpCostaRica
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_CR.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_CR.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpDominicana
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_DO.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_DO.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpEcuador
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_EC.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_EC.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpGuatemala
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_GT.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_GT.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpMexico
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_MX.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_MX.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpPanama
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PA.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PA.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpPeru
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PE.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PE.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpPuertoRico
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_PR.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_PR.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO
/*end*/

USE BelcorpSalvador
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
insert into TablaLogica values (7, 'ActivarProgramaNueva')
insert into TablaLogicaDatos values (701, 7, 'Activo', '0', '')
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
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
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivoConsultora
	FOR ODS_SV.dbo.ProductoExclusivoConsultora 
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NULL)
BEGIN
	CREATE SYNONYM ods.ProductoExclusivo
	FOR ODS_SV.dbo.ProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
CREATE PROC GetConsultoraProductoExclusivo
(
@CampaniaID int,
@CodigoConsultora varchar(20)
)
AS
BEGIN
	select 
		Cuv as cuv
	from
	ods.ProductoExclusivoConsultora with(nolock)
	where Campania = @CampaniaID
	and CodigoConsultora = @CodigoConsultora
END
GO