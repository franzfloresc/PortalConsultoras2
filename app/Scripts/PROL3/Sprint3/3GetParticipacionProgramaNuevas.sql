USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpMexico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpColombia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpPanama
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpChile
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

USE BelcorpBolivia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetParticipacionProgramaNuevas')
BEGIN
	DROP PROC GetParticipacionProgramaNuevas 
END
GO
CREATE PROC GetParticipacionProgramaNuevas
(
@CodigoPrograma VARCHAR(3),
@CodigoConsultora VARCHAR(20),
@CampaniaID int
)
AS
BEGIN
	DECLARE @Participa bit = 0
	IF EXISTS (SELECT 1 FROM ods.ConfiguracionProgramaNuevas with(nolock) WHERE CodigoPrograma = @CodigoPrograma and CampaniaInicio <= @CampaniaID 
			and CampaniaFin >= @CampaniaID and IndExigVent = 1)
			BEGIN
				IF EXISTS (SELECT 1 FROM ods.ConsultorasProgramaNuevas with(nolock)
								Where Campania = cast(@CampaniaID as varchar(6))
								and CodigoConsultora = @CodigoConsultora
								and CodigoPrograma = @CodigoPrograma
								and Participa = 1)
								BEGIN
									set @Participa = 1
								END
			END

		SELECT @Participa AS Participa
END
GO

