USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetConsultoraPorCodigoYRowCount]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetConsultoraPorCodigoYRowCount]
GO

CREATE procedure [dbo].[GetConsultoraPorCodigoYRowCount]
@codigo varchar(25),
@rowCount int
as
begin
	select top (@rowCount) ConsultoraID, 

	   Codigo, 

	   0 RegionID, 

	   0 ZonaID, 

	   0 TerritorioID

	from ods.Consultora where Codigo like @Codigo + '%'
end

go

