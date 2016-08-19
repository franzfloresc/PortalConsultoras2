using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceEvaluacionCrediticia;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerEvaluacionCrediticiaColombiaEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            entidad.EstadoBurocrediticio = Enumeradores.EstadoBurocrediticio.SinConsultar.ToInt();

            using (var sv = new EvaluacionCrediticiaServiceClient())
            {
                if (entidad.CodigoZona != null)
                {
                    var codigoRegion = entidad.CodigoZona.Substring(0, 2).ToString();

                    var evaluacionCrediticiaBe = sv.ConsultarServicioCrediticioCO(model.CodigoISO, "1",
                        entidad.NumeroDocumento, entidad.ApellidoPaterno, codigoRegion, entidad.CodigoZona, "UNETE");

                    entidad.EstadoBurocrediticio = evaluacionCrediticiaBe.EnumEstadoCrediticio.ToInt();
                }
            }

            return new ValidationResponse {Valid = true, Data = entidad};
        }
    }
}