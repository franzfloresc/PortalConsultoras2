USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetActivarPremioNuevas
	@CodigoPrograma varchar(10),
	@CampaniaID int, 
	@CodigoNivel varchar (10)
AS
BEGIN
	select top 1
		CodigoPrograma,
		AnoCampanaIni,
		AnoCampanaFin,
		Nivel,
		ActivePremioAuto,
		ActivePremioElectivo,
		ActiveTooltip,
		ActiveMonto,
		FechaCreate
	from dbo.ActivarPremioNuevas
	where
		Codigoprograma= @CodigoPrograma and Nivel = @CodigoNivel and
		@CampaniaID between AnoCampanaIni and AnoCampanaFin;
END
GO