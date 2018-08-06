use BelcorpPeru
go
UPDATE
	revistadigitalsuscripcion
SET
	Origen = 'NUEVA', SubOrigen = 'RDR'
WHERE
	Origen = 'RD' and CodigoZona in 
	(
	'5011', '5012', '5013', '5014', '5031', '5032', '5033', '5034', '5035', '5036', '5042', '5043', '5044',
	'5045', '5046', '5051', '5052', '5053', '5054',
	'8012', '8015', '8016', '8021', '8022', '8026', '8029', '8030'
	);

go

use BelcorpColombia
go
UPDATE
	revistadigitalsuscripcion
SET
	Origen = 'NUEVA', SubOrigen = 'RDR'
WHERE
	Origen = 'RD' and CodigoZona in 
	(
	'0101', '0102', '0103', '0104', '0108', '0123', '0125'
	);
go