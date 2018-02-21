using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaBolivia : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            EvaluacionCrediticiaBE evaluacionCrediticaBe;

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                evaluacionCrediticaBe = sv.ConsultarServicioCrediticio(codigoIso, "SomosBelcorp",
                    entidad.CodigoZona, entidad.NumeroDocumento);
            }
            return evaluacionCrediticaBe;
        }
    }
}