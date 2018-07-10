using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLContratoAceptacion
    {
        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile)
        {
            var daContratoAceptacion = new DAContratoAceptacion(paisID);
            if (paisID == 4)
                return daContratoAceptacion.AceptarContratoAceptacionColombia(consultoraid, codigoConsultora, origen, direccionIP, InformacionSOMobile);
            else
                return daContratoAceptacion.AceptarContratoAceptacion(consultoraid, codigoConsultora, origen);
        }
    }
}