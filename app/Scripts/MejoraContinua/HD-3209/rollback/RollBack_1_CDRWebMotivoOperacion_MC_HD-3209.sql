USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='CDRWebMotivoOperacion' and column_name='Orden')
BEGIN
	ALTER TABLE CDRWebMotivoOperacion drop Column Orden
END
GO

