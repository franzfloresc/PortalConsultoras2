-- AGANA-159

GO

USE BelcorpPeru_BPT

GO

print db_name()
 
	delete [ConfiguracionPais] where [Codigo] = 'ATP'

go