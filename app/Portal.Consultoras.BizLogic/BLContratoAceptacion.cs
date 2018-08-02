using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLContratoAceptacion
    {
        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile)
        {
            var daContratoAceptacion = new DAContratoAceptacion(paisID);
            return daContratoAceptacion.AceptarContratoAceptacion(consultoraid, codigoConsultora, origen, direccionIP, InformacionSOMobile);
        }
    }
}