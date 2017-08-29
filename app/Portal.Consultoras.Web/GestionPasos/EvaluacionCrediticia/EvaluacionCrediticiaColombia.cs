using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaColombia : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            var evaluacionCrediticaBe = default(EvaluacionCrediticiaBE);

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                string codigoRegion = string.Empty;

                if (entidad.CodigoZona != null)
                {
                    codigoRegion = entidad.CodigoZona.Substring(0, 2);
                }

                evaluacionCrediticaBe = sv.ConsultarServicioCrediticioCO(codigoIso, "1",
    entidad.NumeroDocumento, entidad.ApellidoPaterno, codigoRegion,
    entidad.CodigoZona, "UNETE");

            }

            return evaluacionCrediticaBe;
        }
    }
}