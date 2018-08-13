using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorYFiltrosProvider : BuscadorBaseProvider
    {
        public List<BuscadorYFiltrosModel> GetBuscador(UsuarioModel userData, BuscadorModel buscadorModel)
        {
            List<BuscadorYFiltrosModel> resultados = null;
            try
            {
                string pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
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
            }
            catch (Exception ex)
            {
                throw;
            }
            return resultados;
        }
    }
}