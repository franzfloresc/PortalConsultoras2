if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos
