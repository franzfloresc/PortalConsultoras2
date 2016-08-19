using CORP.BEL.Unete.UI.UB.GestionPasos;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.HojaInscripcionODS;

namespace Portal.Consultoras.Web.GestionPasos.Validaciones
{
    public class YaEsConsultoraValidation : IValidation<Paso1CoreVm>
    {
        public ValidationResponse Validar(Paso1CoreVm model)
        {
            var numeroDocumento = BaseUtilities.AplicarFormatoNumeroDocumentoPorPais(model.CodigoISO, model.NumeroDocumento);

            var response = new ValidationResponse {Valid = true};

            using (var sv = new ODSServiceClient())
            {
                var consultora = sv.ObtenerConsultoraPorNumeroDocumento(model.CodigoISO, numeroDocumento);

                if (consultora != null && consultora.IdEstadoActividad.HasValue)
                {
                    if (consultora.IdEstadoActividad.Value == Enumeradores.IdEstadoActividad.Retirada.ToInt())
                    {
                        response.Data = "AD";
                    }
                    else if (consultora.IdEstadoActividad.Value != Enumeradores.IdEstadoActividad.Retirada.ToInt())
                    {
                        response.Valid = false;
                        response.Data = consultora.NombreCompleto;
                    }
                }
            }

            return response;
        }
    }
}