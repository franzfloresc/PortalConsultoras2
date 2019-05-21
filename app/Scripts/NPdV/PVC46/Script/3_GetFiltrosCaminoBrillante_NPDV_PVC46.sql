USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetFiltrosCaminoBrillante'))
Begin
	Drop PROC GetFiltrosCaminoBrillante
End
GO
CREATE PROC GetFiltrosCaminoBrillante
AS
begin
select 
	Valor as Codigo,
	Descripcion as Descripcion,
	Codigo as Tipo
from  TablaLogicaDatos with(Nolock)
where TablaLogicaID in (174,175)
order by TablaLogicaID asc
END
GO

