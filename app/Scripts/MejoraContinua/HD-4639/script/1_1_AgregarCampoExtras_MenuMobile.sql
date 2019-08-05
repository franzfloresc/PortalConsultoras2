

GO
USE BelcorpPeru
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpMexico
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpColombia
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpSalvador
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpPuertoRico
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpPanama
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpGuatemala
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpEcuador
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpDominicana
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpCostaRica
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpChile
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
USE BelcorpBolivia
GO
IF COL_LENGTH('dbo.MenuMobile', 'Extras') IS NULL
begin
	ALTER TABLE MenuMobile
	ADD Extras VARCHAR(800)
END

GO
