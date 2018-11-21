IF COL_LENGTH('dbo.ActivarPremioNuevas', 'IND_CUPO_ELEC') IS NULL
	ALTER TABLE dbo.ActivarPremioNuevas ADD IND_CUPO_ELEC BIT NULL;
