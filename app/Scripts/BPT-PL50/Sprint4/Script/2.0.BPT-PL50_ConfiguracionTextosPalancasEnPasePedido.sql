
--script para TODOS los paises
--SR
UPDATE TipoEstrategia SET NombreComercial = 'OFERTAS ESPECIALES' WHERE DescripcionEstrategia = 'ShowRoom'
--ODD
UPDATE TipoEstrategia SET NombreComercial = 'OFERTA ¡SOLO HOY!' WHERE DescripcionEstrategia = 'Oferta del Día'
--OPT
UPDATE TipoEstrategia SET NombreComercial = 'OFERTAS PARA TI' WHERE DescripcionEstrategia = 'Oferta para ti'
--Ofertas Simples
UPDATE TipoEstrategia SET NombreComercial = 'OFERTAS PARA TI' WHERE DescripcionEstrategia = 'Mis Ofertas Simples'
--Ofertas Niveles
UPDATE TipoEstrategia SET NombreComercial = 'OFERTAS PARA TI' WHERE DescripcionEstrategia = 'Mis Ofertas Niveles'
--HV
UPDATE TipoEstrategia SET NombreComercial = 'HERRAMIENTAS DE VENTA' WHERE DescripcionEstrategia = 'Herramientas de Venta'
--LAN
UPDATE TipoEstrategia SET NombreComercial = 'LO NUEVO ¡NUEVO!' WHERE DescripcionEstrategia = 'Lanzamiento'
