GO
Delete TablaLogicaDatos where TablaLogicaID = 6
Delete TablaLogica where TablaLogicaID = 6
GO
insert into TablaLogica values (6, 'Rango de cuv')
insert into TablaLogicaDatos values (601, 6, 'cuvInicio', '99900', ''),
							    	(602, 6, 'cuvFinal', '99999', '')
GO