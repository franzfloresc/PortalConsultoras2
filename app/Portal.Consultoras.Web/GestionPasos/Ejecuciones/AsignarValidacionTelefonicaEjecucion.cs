using System.Linq;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class AsignarValidacionTelefonicaEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            entidad.EstadoTelefonico = Enumeradores.TipoEstadoTelefonico.Aprobado.ToInt();

            return new ValidationResponse { Valid = true, Data = entidad };
        }
    }
}
