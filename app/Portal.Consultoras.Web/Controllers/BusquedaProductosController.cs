﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.ServiceSAC;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        private readonly SACServiceClient tablaLogica;

        public BusquedaProductosController()
        {
            tablaLogica = new SACServiceClient();
        }

        public ActionResult Index(string q = "", string c = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = q,
                CategoriaBusqueda = c,
                ListaOrdenamiento = tablaLogica.GetOrdenamientoFiltrosBuscador(userData.PaisID),
                TotalProductosPagina = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalProductosPaginaResultado),
                TotalCaracteresDescripcion = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalCaracteresDescPaginaResultado),
                MostrarOpcionesOrdenamiento = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.MostrarOpcionesOrdenamiento).ToBool()
            };
            return View(model);
        }

     

    }

}