using CORP.BEL.Unete.UI.UB.GestionPasos;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos
{
    public class Ejecucion3Pasos
    {
        public ValidationPaso<Paso1CoreVm> Paso1 { get; set; }
        public ValidationPaso<Paso2CoreVm> Paso2 { get; set; }
        public EjecucionPaso<Paso3CoreVm, SolicitudPostulante> Paso3 { get; set; }
    }
}