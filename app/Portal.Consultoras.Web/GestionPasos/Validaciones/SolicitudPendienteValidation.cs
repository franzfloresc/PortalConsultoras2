using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUnete;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.GestionPasos.Validaciones
{
    public class SolicitudPendienteValidation : IValidation<Paso1CoreVm>
    {
        public ValidationResponse Validar(Paso1CoreVm model)
        {
            var numeroDocumento = BaseUtilities.AplicarFormatoNumeroDocumentoPorPais(model.CodigoISO, model.NumeroDocumento);

            using (var sv = new PortalServiceClient())
            {
                var solicitudPostulante = sv.ObtenerSolicitudPostulanteByNumeroDocumento(model.CodigoISO, numeroDocumento, model.CorreoElectronico);

                if (solicitudPostulante != null &&
                    (solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.EnAprobacionFFVV.ToInt()
                    || solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.EnGestionServicioAlCliente.ToInt()
                    || solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.Rechazada.ToInt()
                    || solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.Registrada.ToInt()))
                {
                    var nombreCompleto = string.Format("{0} {1}", solicitudPostulante.PrimerNombre, solicitudPostulante.ApellidoPaterno);

                    return new ValidationResponse {Valid = false, Data = nombreCompleto};
                }
            }

            return new ValidationResponse { Valid = true };
        }
    }
}