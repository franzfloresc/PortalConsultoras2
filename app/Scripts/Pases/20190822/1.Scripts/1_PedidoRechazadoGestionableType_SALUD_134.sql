USE BelcorpBolivia
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpChile
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpColombia
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpCostaRica
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpDominicana
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpEcuador
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpGuatemala
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpMexico
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpPanama
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpPeru
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpPuertoRico
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO

USE BelcorpSalvador
GO
ALTER PROC GPR.ActualizarIndicadorGPRPedidosFacturados AS
GO
IF TYPE_ID('dbo.PedidoRechazadoGestionableType') IS NOT NULL
	DROP TYPE dbo.PedidoRechazadoGestionableType
GO
CREATE TYPE dbo.PedidoRechazadoGestionableType AS TABLE(
	CampaniaId int not null,
	PedidoId int not null,
	PRIMARY KEY CLUSTERED (CampaniaId asc, PedidoId asc)  
)
GO