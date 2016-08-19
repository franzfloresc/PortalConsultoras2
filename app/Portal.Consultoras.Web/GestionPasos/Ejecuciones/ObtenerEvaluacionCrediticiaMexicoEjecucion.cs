using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerEvaluacionCrediticiaMexicoEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            entidad.EstadoBurocrediticio = Enumeradores.EstadoBurocrediticio.PuedeSerConsultora.ToInt();

            return new ValidationResponse {Valid = true, Data = entidad};
        }
    }
}