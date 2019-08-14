USE [BelcorpBolivia];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpChile];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpColombia];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpCostaRica];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpDominicana];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpEcuador];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '0');

GO
USE [BelcorpGuatemala];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpMexico];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpPanama];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpPeru];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpPuertoRico];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
USE [BelcorpSalvador];
GO
DECLARE @TablaLogicaID int = 110;
DELETE FROM TablaLogicaDatos where TablaLogicaID = @TablaLogicaID;
DELETE FROM TablaLogica where TablaLogicaID = @TablaLogicaID;

INSERT INTO TablaLogica values (@TablaLogicaID, 'CDR Flags')
INSERT INTO TablaLogicaDatos values (cast(@TablaLogicaID as varchar(3)) + '01', @TablaLogicaID, '01', 'Sets y Packs', '1');

GO
