
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorProvider
    {
        public string urlClient(UsuarioModel userData, BuscadorModel buscadorModel)
        {
            var urlClient = string.Format(
                "Buscador/" +
                "{0}/", "{1}/", "{2}/", "{3}/", "{4}/", "{5}/", "{6}/", "{7}/", "{8}/", "{9}/", "{10}/", "{11}/", "{12}",
                userData.CodigoISO,
                userData.CampaniaID,
                userData.CodigoConsultora,
                userData.CodigoZona,
                buscadorModel.TextoBusqueda,
                buscadorModel.CantidadProductos,
                buscadorModel.SociaEmpresaria,
                buscadorModel.SuscripcionActiva,
                buscadorModel.MDO,
                buscadorModel.RD,
                buscadorModel.RDI,
                buscadorModel.RDR,
                buscadorModel.DiaFacturacion
                );
                                   
            return urlClient;
        }
    }
}