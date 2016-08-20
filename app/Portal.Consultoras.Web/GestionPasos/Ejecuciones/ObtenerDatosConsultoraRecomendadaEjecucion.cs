using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Web.HojaInscripcionODS;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;

namespace Portal.Consultoras.Web.GestionPasos.Ejecuciones
{
    public class ObtenerDatosConsultoraRecomendadaEjecucion : IEjecucion<Paso3CoreVm, SolicitudPostulante>
    {
        public ValidationResponse Ejecutar(Paso3CoreVm model, SolicitudPostulante entidad)
        {
            if (model.ConsultoraRecomienda == "SI" && !string.IsNullOrWhiteSpace(model.CodigoConsultoraRecomienda))
            {
                string codigo = model.CodigoConsultoraRecomienda;
                switch (model.CodigoISO)
                {
                    case "CL":
                    case "MX":
                        codigo = codigo.PadLeft(7, '0');
                        break;
                    case "CO":
                        codigo = codigo.PadLeft(10, '0');
                        break;
                }

                using (var sv = new ODSServiceClient())
                {
                    var consultora = sv.ObtenerConsultoraPorCodigoConsultora(model.CodigoISO, codigo);

                    if (consultora != null)
                    {
                        entidad.CodigoConsultoraRecomienda = consultora.Codigo;
                        entidad.NombreConsultoraRecomienda = consultora.NombreCompleto;
                    }
                }
            }

            return new ValidationResponse {Valid = true, Data = entidad};
        }
    }
}