USE BelcorpPeru
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

USE BelcorpMexico
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

USE BelcorpColombia
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

USE BelcorpSalvador
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

USE BelcorpPuertoRico
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

USE BelcorpPanama
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

USE BelcorpGuatemala
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

USE BelcorpEcuador
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

USE BelcorpDominicana
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

USE BelcorpCostaRica
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

USE BelcorpChile
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

USE BelcorpBolivia
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

