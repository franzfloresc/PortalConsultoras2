using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class GuardarActualizarEjecucion : IEjecucion<Paso3CoreVm, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante entidad)
        {
            using (var sv = new PortalServiceClient())
            {
                if (entidad.SolicitudPostulanteID != 0)
                {
                    sv.ActualizarSolicitudPostulante(model.CodigoISO, entidad);
                }
                else 
                {
                    var solicitudId = sv.AgregarSolicitudPostulante(model.CodigoISO, entidad);
                    entidad.SolicitudPostulanteID = solicitudId;
                }
            }

            return new ValidationResponse { Valid = true, Data = entidad };
        }
    }
}