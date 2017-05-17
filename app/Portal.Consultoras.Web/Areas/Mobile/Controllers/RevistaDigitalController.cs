using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class RevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult Index()
        {
            //if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
            //    return RedirectToAction("Index", "Bienvenida");

            var model = new RevistaDigitalModel();
            model.NombreUsuario = userData.UsuarioNombre.ToUpper();
            var listaProducto = ConsultarEstrategiasModel();
            using (SACServiceClient svc = new SACServiceClient())
            {
                model.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
            }

            model.ListaProducto = listaProducto.Where(e => e.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            var listadoNoLanzamiento = listaProducto.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento && e.CodigoEstrategia != "").ToList() ?? new List<EstrategiaPedidoModel>();

            if (listadoNoLanzamiento.Any())
            {
                model.PrecioMin = listadoNoLanzamiento.Min(p => p.Precio2);
                model.PrecioMax = listadoNoLanzamiento.Max(p => p.Precio2);
            }
            if (!model.ListaProducto.Any())
            {
                model.ListaProducto = listaProducto;
                model.ListaProducto.Update(p => p.ImgFondoDesktop = "/Content/Images/RevistaDigital/lan-fondo.png");
            }
            model.ListaProducto.Update(p => {
                p.ImgFondoDesktop = Util.Trim(p.ImgFondoDesktop);
                p.ImgPrevDesktop = Util.Trim(p.ImgPrevDesktop);
                p.ImgFichaDesktop = Util.Trim(p.ImgFichaDesktop);
                p.UrlVideoDesktop = Util.Trim(p.UrlVideoDesktop);
                p.ImgFondoMobile = Util.Trim(p.ImgFondoMobile);
                p.ImgFichaMobile = Util.Trim(p.ImgFichaMobile);
                p.UrlVideoMobile = Util.Trim(p.UrlVideoMobile);
            });

            return View(model);
        }


        public ActionResult Inscripcion()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigitalSuscripcion))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }
        public ActionResult DetalleProducto()
        {
            return View();
        }

    }
}