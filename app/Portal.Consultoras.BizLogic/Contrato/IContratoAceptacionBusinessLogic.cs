﻿using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IContratoAceptacionBusinessLogic
    {
        int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile, string imei, string deviceID);
        List<BEContrato> GetContratoAceptacion(int paisID, long consultoraid);
        List<BeReporteContrato> ReporteContratoAceptacion(int paisID, string codigoconsultora, string cedula, DateTime? fechaInicio, DateTime? FechaFin);
    }
}