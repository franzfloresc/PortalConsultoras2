ALTER TABLE RevistaDigitalSuscripcion DROP CONSTRAINT COST_RevistaDigiralSuscripcion_Origen
ALTER TABLE RevistaDigitalSuscripcion ADD CONSTRAINT COST_RevistaDigiralSuscripcion_Origen DEFAULT 'RD' FOR Origen;
UPDATE RevistaDigitalSuscripcion SET Origen = 'RD' WHERE Origen is null or Origen = ''
