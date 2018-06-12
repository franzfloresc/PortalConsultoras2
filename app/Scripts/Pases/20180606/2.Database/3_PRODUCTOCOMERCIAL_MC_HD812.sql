USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ValidarCUVsNoExistentes]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ValidarCUVsNoExistentes]
GO
CREATE procedure ValidarCUVsNoExistentes
(
 @CUVs varchar(max),
 @AnioCampania int
)
as
begin
    IF OBJECT_ID('tempdb..#productoComercialInput') IS NOT NULL
	DROP TABLE #productoComercialInput
	select top 0 CUV into #productoComercialInput from ODS.PRODUCTOCOMERCIAL
	select @CUVs = 'select * from(values('''+ replace(replace(@CUVs, '|', ''','''), '¬', '''),(''') +'''))t(CUV)'
	insert into #productoComercialInput exec(@CUVs)

	Select isnull( STUFF((Select '¬' +  isnull(a.CUV,'') from (
		select CUV from #productoComercialInput
		EXCEPT  
		select b.CUV from  ODS.PRODUCTOCOMERCIAL a  inner join #productoComercialInput b on  a.CUV=b.CUV
		WHERE a.AnoCampania = @AnioCampania 
		) a  FOR XML PATH('')), 1, 1, '') ,'')
end
GO

