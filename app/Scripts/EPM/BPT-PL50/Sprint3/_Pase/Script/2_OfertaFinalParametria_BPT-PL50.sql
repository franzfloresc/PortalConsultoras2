
USE BelcorpChile
GO

UPDATE OfertaFinalParametria SET GapMinimo = 0, GapMaximo = 55800, PrecioMinimo = 18600 WHERE Algoritmo = 'OFR' AND Tipo = 'RG1'
UPDATE OfertaFinalParametria SET GapMinimo = 55801, GapMaximo = 68200, PrecioMinimo = 27900 WHERE Algoritmo = 'OFR' AND Tipo = 'RG2'
UPDATE OfertaFinalParametria SET GapMinimo = 68201, GapMaximo = 6200000, PrecioMinimo = 36270 WHERE Algoritmo = 'OFR' AND Tipo = 'RG3'
