USE BelcorpPeru
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpMexico
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpColombia
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpSalvador
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpPuertoRico
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpPanama
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpGuatemala
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpEcuador
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpDominicana
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpCostaRica
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpChile
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

USE BelcorpBolivia
GO

Declare @TablaLogicaID int = 231;

if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
BEGIN
	delete from TablaLogicaDatos where TablaLogicaID = ID
	delete from TablaLogica where TablaLogicaID = ID
END

