using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class ProductoFaltanteProvider
    {
        public List<BEProductoFaltante> GetProductosFaltantes(UsuarioModel userSession)
        {
            return this.GetProductosFaltantes(userSession, "", "", "", "");
        }

        public List<BEProductoFaltante> GetProductosFaltantes(UsuarioModel userSession, string cuv, string descripcion, string codCategoria, string codCatalogoRevista)
        {
            List<BEProductoFaltante> olstProductoFaltante;
            using (var sv = new SACServiceClient())
            {
                olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(userSession.PaisID, userSession.CampaniaID, userSession.ZonaID, cuv, descripcion, codCategoria, codCatalogoRevista).ToList();
            }
            return olstProductoFaltante ?? new List<BEProductoFaltante>();
        }

    }
}
