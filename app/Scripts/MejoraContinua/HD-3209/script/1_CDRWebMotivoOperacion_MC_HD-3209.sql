USE BelcorpPeru
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion ADD Orden bit
END
GO

