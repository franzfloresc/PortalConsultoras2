﻿USE  [BelcorpMexico]
GO

IF EXISTS( SELECT * FROM MenuMobile WHERE MenuMobileID = 1044)
BEGIN
	UPDATE MenuMobile SET EsSB2 = 1 WHERE MenuMobileID =1044;
END
GO

IF EXISTS( SELECT * FROM MenuMobile WHERE MenuMobileID = 1045)
BEGIN
	UPDATE MenuMobile SET EsSB2 = 1 WHERE MenuMobileID =1045;
END
GO

IF EXISTS( SELECT * FROM MenuMobile WHERE MenuMobileID = 1046)
BEGIN
	UPDATE MenuMobile SET EsSB2 = 1 WHERE MenuMobileID =1046;
END
GO

IF EXISTS( SELECT * FROM MenuMobile WHERE MenuMobileID = 1047)
BEGIN
	UPDATE MenuMobile SET EsSB2 = 1 WHERE MenuMobileID =1047;
END
GO

DECLARE @ID INT = 0;
IF  EXISTS (SELECT * FROM MenuMobile WHERE  descripcion = 'PRIVACIDAD DE DATOS')
BEGIN
	SET @ID = (SELECT MenuMobileID FROM MenuMobile WHERE  descripcion = 'PRIVACIDAD DE DATOS')	;
	UPDATE MenuMobile SET EsSB2 = 0 WHERE MenuMobileID =@ID;
END





