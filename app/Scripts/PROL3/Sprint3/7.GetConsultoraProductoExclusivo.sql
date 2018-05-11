USE BelcorpPeru
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

USE BelcorpMexico
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

USE BelcorpColombia
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

USE BelcorpSalvador
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

USE BelcorpPuertoRico
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

USE BelcorpPanama
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

USE BelcorpGuatemala
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

USE BelcorpEcuador
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

USE BelcorpDominicana
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

USE BelcorpCostaRica
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

USE BelcorpChile
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

USE BelcorpBolivia
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

