USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[SP_ListarActivarPremioNuevas]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[SP_ListarActivarPremioNuevas]
GO
create PROCEDURE SP_ListarActivarPremioNuevas
	@PageNumber AS INT, 
	@RowspPage AS INT,
	@SortDirection VARCHAR(4)    = 'DESC',
	@SortColumn    NVARCHAR(128) = N'',
	@CodigoPrograma varchar(3) =null,
	@AnoCampana int =null,
	@Nivel varchar(2)=null,
	@Active bit =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WITH ActivarPremioNuevasCte as (

		SELECT 
		    [IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			AnoCampanaFin,
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			IND_CUPO_ELEC Ind_Cupo_Elec
	FROM  dbo.ActivarPremioNuevas
	),CountCte as 
	(
	   SELECT COUNT(*) AS TotalFilas FROM ActivarPremioNuevasCte
	)
	--
	SELECT 
	        TotalFilas,
			[IdActivarPremioNuevas],
			CodigoPrograma,
			AnoCampanaIni,
			[AnoCampanaFin],
			Nivel,
			ActiveTooltip,
			ActiveTooltipMonto,
			Active,
			FechaCreate,
			FechaCreate,
			Ind_Cup_Elec
	FROM  ActivarPremioNuevasCte
	CROSS JOIN CountCte
	Where (@CodigoPrograma is null or (CodigoPrograma=@CodigoPrograma)) and
		  (@AnoCampana     is null or (AnoCampanaIni =@AnoCampana)) and
		  (@Nivel          is null or (Nivel =@Nivel)) and
		  (@Active         is null or (Active=@Active))
	ORDER BY 
		CASE WHEN @SortDirection = 'ASC' THEN
			 CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
			END	,
	   CASE WHEN @SortDirection = 'DESC' THEN
		    CASE @SortColumn 
				WHEN 'Nivel'   THEN Nivel
				WHEN 'AnoCampanaIni' THEN AnoCampanaIni 
				WHEN 'CodigoPrograma' THEN CodigoPrograma 
				WHEN 'AnoCampanaFin' THEN [AnoCampanaFin] 
				ELSE IdActivarPremioNuevas
			END
		END DESC

	OFFSET ((@PageNumber - 1) * @RowspPage) ROWS
	FETCH NEXT @RowspPage ROWS ONLY

END
GO
