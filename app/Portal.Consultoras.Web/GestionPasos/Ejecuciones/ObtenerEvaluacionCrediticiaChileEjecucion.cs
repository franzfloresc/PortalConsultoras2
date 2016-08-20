using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerEvaluacionCrediticiaChileEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            entidad.EstadoBurocrediticio = Enumeradores.EstadoBurocrediticio.SinConsultar.ToInt();

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                var evaluacionCrediticiaBe = sv.ConsultarServicioCrediticio(model.CodigoISO, "SiteUnete",
                    entidad.CodigoZona, entidad.NumeroDocumento);

                entidad.EstadoBurocrediticio = evaluacionCrediticiaBe.EnumEstadoCrediticio.ToInt();
            }

            return new ValidationResponse {Valid = true, Data = entidad};
        }
    }
}