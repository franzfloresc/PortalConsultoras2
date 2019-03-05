USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_EditarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_EditarActivarPremioNuevas]
GO
CREATE PROCEDURE SP_EditarActivarPremioNuevas
@CodigoPrograma	varchar(3),
@AnoCampana	int,
@Nivel	varchar(2),
@ActiveTooltip	bit,
@ActiveMonto	bit,
@ActivePremioAuto	bit,
@ActivePremioElectivo	bit,
@AnoCampaniaFin	int,
@IdActivarPremioNuevas int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Validación Traslapar Fechas.
  IF   NOT EXISTS(Select 1 from dbo.ActivarPremioNuevas where  
					(CodigoPrograma =@CodigoPrograma and Nivel =@Nivel and IdActivarPremioNuevas !=@IdActivarPremioNuevas) and
					(@AnoCampaniaFin >= AnoCampanaIni AND  AnoCampanaFin >= @AnoCampana)
	)
	BEGIN
	   Update dbo.ActivarPremioNuevas
		set CodigoPrograma =@CodigoPrograma,
			AnoCampanaIni=@AnoCampana,
			Nivel=@Nivel,
			ActiveTooltip=@ActiveTooltip,
			ActiveMonto =@ActiveMonto,
			ActivePremioAuto =@ActivePremioAuto,
			ActivePremioElectivo =@ActivePremioElectivo,
			AnoCampanaFin=@AnoCampaniaFin
	   where IdActivarPremioNuevas = @IdActivarPremioNuevas;

	   Select 
			@CodigoPrograma	CodigoPrograma,
			@AnoCampana	AnoCampanaIni,
			@Nivel	Nivel,
			@ActiveTooltip	ActiveTooltip,
			@ActiveMonto	ActiveMonto,
			@ActivePremioAuto	ActivePremioAuto,
			@ActivePremioElectivo ActivePremioElectivo,
			@AnoCampaniaFin AnoCampanaFin	,
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			1 OperacionResultado;
	
	END
	ELSE
	BEGIN
	     Select 
			@IdActivarPremioNuevas IdActivarPremioNuevas ,
			0 OperacionResultado;
	END 

	
     
END
GO

