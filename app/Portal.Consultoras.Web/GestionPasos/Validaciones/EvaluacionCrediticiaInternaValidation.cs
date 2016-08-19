using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.HojaInscripcionODS;
using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.Web.ValidacionCrediticia;
using Portal.Consultoras.Web.Models;
using CORP.BEL.Unete.UI.UB.Validaciones;
using Portal.Consultoras.Common;
using CORP.BEL.Unete.UI.UB.GestionPasos;

namespace Portal.Consultoras.Web.GestionPasos.Validaciones
{
    public class EvaluacionCrediticiaInternaValidation : IValidation<Paso1CoreVm>
    {
        public ValidationResponse Validar(Paso1CoreVm model)
        {
            var numeroDocumento = BaseUtilities.AplicarFormatoNumeroDocumentoPorPais(model.CodigoISO, model.NumeroDocumento);

            var response = new ValidationResponse {Valid = true};

            ValidacionCrediticiaClient proxy = new ValidacionCrediticiaClient();
            InValidacionCrediticiaDTO input = new InValidacionCrediticiaDTO();
            OutValidacionCrediticiaLista output = new OutValidacionCrediticiaLista();

            input.Pais = model.CodigoISO;
            input.tipoIdentificacion ="1" ;
            input.numDocumento = numeroDocumento;

            output = proxy.GetValidacionCrediticia(input);

            var ListOutValidacionCrediticiaBloqueo = new List<OutValidacionCrediticiaBloqueo>();
            ListOutValidacionCrediticiaBloqueo = output.AnotherHits.ToList();

            var sv = new BelcorpPaisServiceClient();

            var ListaBloqueos = new List<TipoBloqueoBE>();

            ListaBloqueos = sv.ObtenerTiposBloqueo(model.CodigoISO);

            sv.Close();

            var lst = ListOutValidacionCrediticiaBloqueo.Where(x => ListaBloqueos.Any(p => p.TipoBloqueo == x.TipoBloqueo)).ToList();

            if (lst.Count > 0)
            {
                response.Valid = false;
                response.Data = model.PrimerNombre;
            }
            else {
                response.Valid = true;
            }

            return response;
        }
    }
}