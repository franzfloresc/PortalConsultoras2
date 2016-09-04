CREATE PROCEDURE GetEscalaDescuento
AS
BEGIN
SELECT MontoHasta, 
	   PorDescuento
FROM ods.EscalaDescuento
END