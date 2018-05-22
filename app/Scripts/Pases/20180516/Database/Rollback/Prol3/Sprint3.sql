USE BelcorpBolivia
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpChile
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpColombia
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpCostaRica
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpDominicana
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpEcuador
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpGuatemala
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpMexico
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpPanama
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpPeru
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpPuertoRico
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO
/*end*/

USE BelcorpSalvador
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConsultoraProductoExclusivo')
BEGIN
	DROP PROC GetConsultoraProductoExclusivo
END
GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivoConsultora'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivoConsultora
END
GO
IF ((SELECT OBJECTPROPERTYEX(OBJECT_ID('ods.ProductoExclusivo'), 'BaseType')) IS NOT NULL)
BEGIN
	DROP SYNONYM ods.ProductoExclusivo
END
GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
Delete TablaLogicaDatos where TablaLogicaID = 7
Delete TablaLogica where TablaLogicaID = 7
GO