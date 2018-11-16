using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaPeru : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            EvaluacionCrediticiaBE evaluacionCrediticaBe;

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                evaluacionCrediticaBe = sv.ConsultarServicioCrediticioPeru(codigoIso, entidad.TipoDocumento,
                    entidad.NumeroDocumento);
            }

            return evaluacionCrediticaBe;
        }
    }
}