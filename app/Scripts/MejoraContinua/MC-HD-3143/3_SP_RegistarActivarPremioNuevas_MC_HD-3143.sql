USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_RegistarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO

CREATE PROCEDURE SP_RegistarActivarPremioNuevas
@CodigoPrograma	varchar(4),
@AnoCampana	int,
@Nivel	varchar(3),
@ActiveTooltip	bit,
@ActiveTooltipMonto	bit,
@Active	bit,
@IND_CUPO_ELEC	bit,
@AnoCampaniaFin	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	 declare @IdActivarPremioNuevas int =0;
    IF   NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampana >=AnoCampanaIni  and @AnoCampana <=AnoCampanaFin)) AND 
			NOT EXISTS(Select 1  from dbo.ActivarPremioNuevas where  (CodigoPrograma =@CodigoPrograma and Nivel =@Nivel  and IND_CUPO_ELEC=@IND_CUPO_ELEC) and
			             (@AnoCampaniaFin >=AnoCampanaIni  and @AnoCampaniaFin <=AnoCampanaFin)
	)
	BEGIN
	  	Insert dbo.ActivarPremioNuevas (CodigoPrograma,AnoCampanaIni,Nivel,ActiveTooltip,ActiveTooltipMonto,Active,FechaCreate,IND_CUPO_ELEC,AnoCampanaFin)
	    values(@CodigoPrograma,@AnoCampana,@Nivel,@ActiveTooltip,@ActiveTooltipMonto,@Active,GetDate(),@IND_CUPO_ELEC,@AnoCampaniaFin)
		set @IdActivarPremioNuevas =@@IDENTITY;
		   Select 
		    @IdActivarPremioNuevas IdActivarPremioNuevas,
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			0 OperacionResultado
	END
	ELSE
	BEGIN
	   Select 
	       @CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveTooltipMonto	ActiveTooltipMonto,
			@Active	Active,
			@IND_CUPO_ELEC	IND_CUPO_ELEC,
			@AnoCampaniaFin AnoCampanaFin,
			1 OperacionResultado
	END
END
GO

