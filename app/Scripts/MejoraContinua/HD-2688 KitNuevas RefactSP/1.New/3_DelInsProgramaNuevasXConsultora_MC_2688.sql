USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpChile
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.DelInsProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.DelInsProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.DelInsProgramaNuevasXConsultora
	@CodigoConsultora varchar(15),
	@CodigoCampania int,
	@CodigoPrograma varchar(15),
	@CodigoNivel char(2),
	@TipoConcurso varchar(3)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
	select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, @TipoConcurso;

	set nocount off;
END
GO