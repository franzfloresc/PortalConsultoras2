using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;
using System;

namespace Portal.Consultoras.Web.GestionPasos.EvaluacionCrediticia
{
    public class EvaluacionCrediticiaDominicana : IEvaluacionCrediticia
    {
        public EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad)
        {
            EvaluacionCrediticiaBE evaluacionCrediticaBe;
            int tipoDocumentoId = String.IsNullOrEmpty(entidad.TipoDocumento) ? 1 : int.Parse(entidad.TipoDocumento);
            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                evaluacionCrediticaBe = sv.ConsultarServicioCrediticioCaribe(codigoIso, int.Parse(entidad.TipoDocumento), entidad.NumeroDocumento);
            }
            return evaluacionCrediticaBe;
        }
    }
}