GO
USE BelcorpPeru
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN

	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'

END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN

	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT 1 FROM OrigenPedidoWeb WHERE CodOrigenPedidoWeb 
					IN(
					'1100001','1100002','1100101','1100102','1100201','1100202','1100301','1100302','1100501','1100502',
					'1100601','1100801','1100802','1101101','1101201','1101301','2100001','2100002','2100101','2100102',
					'2100201','2100202','2100301','2100302','2100501','2100502','2100601','2100801','2100802','2101101',
					'2101201','2101301'					
					)
			  )
BEGIN
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '1101301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100001'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100002'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100102'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100202'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100301'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100302'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100501'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100502'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100601'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100801'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2100802'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101101'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101201'
	DELETE FROM [dbo].[OrigenPedidoWeb] WHERE CodOrigenPedidoWeb = '2101301'
END

GO
