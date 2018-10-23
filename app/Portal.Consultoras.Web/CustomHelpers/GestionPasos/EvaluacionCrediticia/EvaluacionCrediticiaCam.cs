using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaCam : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            EvaluacionCrediticiaBE evaluacionCrediticaBe;

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                int tipoDocumento = string.IsNullOrWhiteSpace(entidad.TipoDocumento) ? 0 : int.Parse(entidad.TipoDocumento);
                evaluacionCrediticaBe = sv.ConsultarServicioCrediticioCam(codigoIso, tipoDocumento, entidad.NumeroDocumento);
            }

            return evaluacionCrediticaBe;
        }
    }
}