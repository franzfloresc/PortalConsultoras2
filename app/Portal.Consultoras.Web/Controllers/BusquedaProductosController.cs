using Portal.Consultoras.Web.Models.Buscador;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceSAC;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {

        public ActionResult Index(string q = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = q,
                ListaOrdenamiento = (Session["OrdenamientoFiltrosBuscador"] == null) ? GetOrdenamientoFiltrosBuscador() : (Dictionary<string, string>)Session["OrdenamientoFiltrosBuscador"],
                TotalProductosPagina = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalProductosPaginaResultado),
                TotalCaracteresDescripcion = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalCaracteresDescPaginaResultado),
                MostrarOpcionesOrdenamiento = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.MostrarOpcionesOrdenamiento).ToBool()                
            };
            return View(model);
        }

        private Dictionary<string, string> GetOrdenamientoFiltrosBuscador()
        {
            var result = getListaOrdenamientoFiltrosBuscador(userData.PaisID);

            Session["OrdenamientoFiltrosBuscador"] = result;

            return result;
        }

        private Dictionary<string, string> getListaOrdenamientoFiltrosBuscador(int paisId)
        {
            var result = new Dictionary<string, string>();
            List<BETablaLogicaDatos> listaDescripciones;

            using (var tablaLogica = new SACServiceClient())
            {
                listaDescripciones = tablaLogica.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.ListaOrdenamientoFiltros).ToList();
            }

            foreach (var item in listaDescripciones)
            {
                result.Add(item.Descripcion.ToString(), string.IsNullOrEmpty(item.Valor) ? "" : item.Valor.ToString());
            }

            return result;
        }

    }

}