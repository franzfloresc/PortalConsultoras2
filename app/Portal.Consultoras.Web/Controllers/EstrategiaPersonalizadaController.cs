using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaPersonalizadaController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                var listaSeccion = ObtenerConfiguracion();
                var modelo = new EstrategiaPersonalizadaModel { ListaSeccion = listaSeccion };

                //return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }
        
        private List<ConfiguracionSeccionHomeModel> ObtenerConfiguracion()
        {
            var modelo = new List<ConfiguracionSeccionHomeModel>();

            //var entidad = new ConfiguracionSeccionHomeModel();
            //using (PedidoServiceClient sv = new PedidoServiceClient())
            //{
            //    var lista = sv.GetEstrategiasPedido(entidad).ToList();
            //    modelo = AutoMapper.Mapper.Map<>(lista);
            //}

            if (!modelo.Any())
            {
                modelo.Add(new ConfiguracionSeccionHomeModel { CampaniaID = userData.CampaniaID, TipoPresentacion = "carrusel-previsuales", CantidadMostrar = 0, TipoEstrategia = "LAN", Titulo = "LANZAMIENTO", SubTitulo = ""});
                modelo.Add(new ConfiguracionSeccionHomeModel { CampaniaID = userData.CampaniaID, TipoPresentacion = "seccion-simple-centrado", CantidadMostrar = 0, TipoEstrategia = "OPM", Titulo = "RECOMENDADAS PARA TI", SubTitulo = "OFERTAS PERSONALIZADAS PARA TU NEGOCIO" });
            }

            return modelo;

        }

    }
}