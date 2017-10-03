USE BelcorpPeru
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpMexico
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpColombia
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpVenezuela
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpSalvador
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpPuertoRico
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpPanama
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpGuatemala
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpEcuador
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpDominicana
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpCostaRica
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpChile
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

USE BelcorpBolivia
GO

IF not exists(SELECT MenuMobileID FROM MenuMobile WHERE UrlItem='Mobile/MisReclamos')
BEGIN

	DECLARE @MenuMobilIDUltimo INT = (SELECT max(MenuMobileID) FROM MenuMobile);	
	DECLARE @OrdenMenu INT = (SELECT max(OrdenItem) FROM MenuMobile WHERE menuPadreID = 1001)

	INSERT INTO MenuMobile(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,[Version],EsSB2,Codigo)
	VALUES((@MenuMobilIDUltimo+1),'Cambios y devoluciones',1001,(@OrdenMenu + 1),'Mobile/MisReclamos','',0,'Menu','Mobile',1,null);
END

GO

