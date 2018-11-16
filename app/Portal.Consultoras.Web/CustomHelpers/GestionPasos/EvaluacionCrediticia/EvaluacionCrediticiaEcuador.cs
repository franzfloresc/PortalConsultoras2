using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaEcuador : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            return new EvaluacionCrediticiaBE
            {
                EnumEstadoCrediticio = EnumsEstadoBurocrediticio.PuedeSerConsultora,
                Mensaje = "SI PUEDE SER CONSULTORA"
            };
        }
    }
}