using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLContratoAceptacion : IContratoAceptacionBusinessLogic
    {
        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile, string imei, string deviceID)
        {
            var daContratoAceptacion = new DAContratoAceptacion(paisID);
            return daContratoAceptacion.AceptarContratoAceptacion(consultoraid, codigoConsultora, origen, direccionIP, InformacionSOMobile, imei, deviceID);
        }

        public List<BEContrato> GetContratoAceptacion(int paisID, long consultoraid)
        {
            var daContratoAceptacion = new DAContratoAceptacion(paisID);
            using (IDataReader reader = daContratoAceptacion.GetContratoAceptacion(consultoraid))
                return reader.MapToCollection<BEContrato>();
        }
    }
}