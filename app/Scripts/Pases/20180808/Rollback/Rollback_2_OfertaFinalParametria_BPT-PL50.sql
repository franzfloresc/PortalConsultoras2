
USE BelcorpChile
GO

UPDATE OfertaFinalParametria SET GapMinimo = 40000, GapMaximo = 80000, PrecioMinimo = 20000 WHERE Algoritmo = 'OFR' AND Tipo = 'RG1'
UPDATE OfertaFinalParametria SET GapMinimo = 80000.01, GapMaximo = 100000, PrecioMinimo = 30000 WHERE Algoritmo = 'OFR' AND Tipo = 'RG2'
UPDATE OfertaFinalParametria SET GapMinimo = 100000.01, GapMaximo = 10000000000000000, PrecioMinimo = 40000 WHERE Algoritmo = 'OFR' AND Tipo = 'RG3'