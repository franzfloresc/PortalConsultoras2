USE [BelcorpBolivia];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpChile];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpColombia];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpCostaRica];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36947'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', '765432dc');

GO
USE [BelcorpDominicana];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpEcuador];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpGuatemala];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpMexico];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36947'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', '765432dc');

GO
USE [BelcorpPanama];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36947'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', '765432dc');

GO
USE [BelcorpPeru];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
USE [BelcorpPuertoRico];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36947'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', '765432dc');

GO
USE [BelcorpSalvador];
GO
DECLARE @TablaLogicaID int = 172;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'Tu Voz Online')
INSERT INTO TablaLogicaDatos
values
(cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, 'PANEL_ID', 'Panel ID', '36882'),
(cast(@TablaLogicaID as varchar(3)) + '02', @TablaLogicaID, 'PANEL_KEY', 'Panel Key', 'A12bZ091');

GO
