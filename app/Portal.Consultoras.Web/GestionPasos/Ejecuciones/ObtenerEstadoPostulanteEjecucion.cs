using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerEstadoPostulanteEjecucion : IEjecucion<Paso3CoreVm, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, Portal.Consultoras.Web.ServiceUnete.SolicitudPostulante entidad)
        {
            #region EstadoPostulante

            bool correoRequerido;
            bool telefonoRequerido;

            using (var sv = new BelcorpPaisServiceClient())
            {
                var parametrosValidaciones = sv.ObtenerParametrosUnete(model.CodigoISO,
                    Enumeradores.TipoParametro.Validaciones.ToInt(), 0);

                correoRequerido = parametrosValidaciones.Find(p =>
                    p.Nombre == Constantes.ParametrosNames.CorreoRequerido).Valor == 1;

                telefonoRequerido = parametrosValidaciones.Find(p =>
                    p.Nombre == Constantes.ParametrosNames.TelefonoRequerido).Valor == 1;
            }

            if (entidad.EstadoBurocrediticio == Enumeradores.EstadoBurocrediticio.NoPuedeSerConsultora.ToInt())
            {
                entidad.EstadoPostulante = Enumeradores.EstadoPostulante.Rechazada.ToInt();
            }
            else if ((entidad.EstadoBurocrediticio == Enumeradores.EstadoBurocrediticio.PuedeSerConsultora.ToInt() ||
                      entidad.EstadoBurocrediticio ==
                      Enumeradores.EstadoBurocrediticio.PodriaSerConsultoraCuandoTengaAval.ToInt()) &&
                     entidad.EstadoGEO == Enumeradores.EstadoGEO.OK.ToInt() &&
                     !correoRequerido &&
                     !telefonoRequerido)
            {
                entidad.EstadoPostulante = Enumeradores.EstadoPostulante.EnAprobacionFFVV.ToInt();
            }
            else
            {
                entidad.EstadoPostulante = Enumeradores.EstadoPostulante.EnGestionServicioAlCliente.ToInt();
            }

            #endregion

            return new ValidationResponse { Valid = true, Data = entidad };
        }

    }
}