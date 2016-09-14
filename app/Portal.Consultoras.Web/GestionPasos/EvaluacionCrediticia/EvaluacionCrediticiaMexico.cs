using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaMexico : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            return new EvaluacionCrediticiaBE
            {
                EnumEstadoCrediticio = EnumsEstadoBurocrediticio.PuedeSerConsultora,
                Mensaje = EnumsEstadoBurocrediticio.PuedeSerConsultora.ToString()
            };
        }
    }
}