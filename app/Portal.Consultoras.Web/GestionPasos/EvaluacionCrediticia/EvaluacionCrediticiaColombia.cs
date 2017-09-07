using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaColombia : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            string tipoDocumento = entidad.TipoDocumento != null ? entidad.TipoDocumento : string.Empty;
            string codigoRegion = string.Empty;

            var evaluacionCrediticaBe = default(EvaluacionCrediticiaBE);

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {

                if (entidad.CodigoZona != null)
                {
                      codigoRegion = entidad.CodigoZona.Substring(0, 2);
                }

                evaluacionCrediticaBe = sv.ConsultarServicioCrediticioCO(codigoIso, tipoDocumento, entidad.NumeroDocumento, entidad.ApellidoPaterno, codigoRegion,
                                        entidad.CodigoZona, "UNETE");

            }

            return evaluacionCrediticaBe;
        }
    }
}