using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos
{
    public interface IEvaluacionCrediticia
    {
        EvaluacionCrediticiaBE Evaluar(string codigoIso, SolicitudPostulante entidad);
    }
}