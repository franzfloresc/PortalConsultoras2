GO
DELETE FROM MenuMobile
WHERE MenuPadreID = 1031;

DELETE FROM MenuMobile
WHERE
	EsSB2 = 1 AND Posicion = 'Menu'
	AND
	Descripcion = 'consultora online';

IF EXISTS(
	SELECT 1
	FROM MenuMobile WHERE
	EsSB2 = 1 AND Posicion = 'Menu'
	AND
	MenuPadreID = 0 AND OrdenItem = 3
)
BEGIN
	UPDATE MenuMobile
	SET OrdenItem = OrdenItem + 1
	WHERE
		EsSB2 = 1 AND Posicion = 'Menu'
		AND
		MenuPadreID = 0 AND OrdenItem >= 3
END

INSERT INTO dbo.MenuMobile (MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,PaginaNueva,Posicion,[Version],EsSB2)
VALUES (1031,'Consultora Online',0,3,'',0,'Menu','Mobile',1);

INSERT INTO dbo.MenuMobile (MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,PaginaNueva,Posicion,[Version],EsSB2)
VALUES
	(1032,'Información',1031,1,'Mobile/ConsultoraOnline',0,'Menu','Mobile',1),
	(1033,'Pedidos pendientes',1031,2,'Mobile/ConsultoraOnline/Pendientes',0,'Menu','Mobile',1),
	(1034,'Historial de pedidos',1031,3,'Mobile/ConsultoraOnline/Historial',0,'Menu','Mobile',1);

INSERT INTO dbo.MenuMobile (MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,PaginaNueva,Posicion,[Version],EsSB2)
VALUES (1035,'Consultora Online',1001,15,'Mobile/ConsultoraOnline/Informacion',0,'Menu','Mobile',1);
GO