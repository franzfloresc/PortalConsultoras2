USE BelcorpPeru
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpMexico
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpColombia
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpVenezuela
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpSalvador
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpPuertoRico
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpPanama
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpGuatemala
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpEcuador
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpDominicana
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpCostaRica
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpChile
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

USE BelcorpBolivia
GO

go
IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

