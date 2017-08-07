using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult IndexModel(int nuevo = 0)
        {
            var model = new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.IsMobile = ViewBag.EsMobile == 2;

            if (!userData.RevistaDigital.TieneRDC && !userData.RevistaDigital.TieneRDR)
            {
                if (!userData.RevistaDigital.TieneRDS)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });
                }

                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });
                }
            }
            
            model = ListarTabs(model);

            if (model.EstadoAccion < 0)
                return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });

            model.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
            model.CampaniaMasUno = AddCampaniaAndNumero(userData.CampaniaID, 1) % 100;
            model.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;
            
            model.NumeroContacto = Util.Trim(ConfigurationManager.AppSettings["BelcorpRespondeTEL_" + userData.CodigoISO]);
            model.CantidadFilas = 10;

            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            ViewBag.TieneProductosPerdio = TieneProductosPerdio(model.CampaniaID);
            if (nuevo == 1)
            {
                return View("Revista2017", model);
            }

            return View("Index", model);
        }

        public ActionResult ViewLanding(int id)
        {
            var model = new RevistaDigitalLandingModel();
            if (EsCampaniaFalsa(id)) return PartialView("template-Landing", model);

            model.CampaniaID = id;
            model.IsMobile = ViewBag.EsMobile == 2;

            model.FiltersBySorting = new List<BETablaLogicaDatos>();
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido, Descripcion = model.IsMobile ? "LO MÁS VENDIDO" : "ORDENAR POR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor, Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor, Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO" });
            
            model.FiltersByBrand = new List<BETablaLogicaDatos>();
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "CYZONE", Descripcion = "CYZONE" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "ÉSIKA", Descripcion = "ÉSIKA" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "LBEL", Descripcion = "LBEL" });
            
            model.Success = true;
            ViewBag.TieneProductosPerdio = TieneProductosPerdio(model.CampaniaID);
            ViewBag.NombreConsultora = userData.Sobrenombre;
            ViewBag.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;
            ViewBag.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
            return PartialView("template-Landing", model);
        }

        public ActionResult DetalleModel(string cuv,int campaniaId)
        {
            //modelo = modelo ?? new EstrategiaPersonalizadaProductoModel();
            var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.SessionNames.ProductoTemporal];
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv  || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
            }

            if (!userData.RevistaDigital.TieneRDC && !userData.RevistaDigital.TieneRDR)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
            }

            if (modelo.EstrategiaID > 0)
            {
                modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
                modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();
                ViewBag.TieneRDC = userData.RevistaDigital.TieneRDC;
                ViewBag.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                ViewBag.NombreConsultora = userData.Sobrenombre;
                ViewBag.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;

                return View(modelo);
            }
            return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        private RevistaDigitalModel ListarTabs(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            model.Titulo = userData.UsuarioNombre.ToUpper();
            model.TituloDescripcion = "";
            string cadenaActiva = model.IsMobile ? "COMPRAR</br>C " : "COMPRAR CAMPAÑA ";
            model.NombreRevista = string.Format(model.NombreRevista, model.IsMobile ? "</br>" : "");
            if (userData.RevistaDigital.TieneRDC)
            {
                model = ListarTabsRD(model);
                return model;
            }

            var addTagInfo = false;

            if (userData.RevistaDigital.TieneRDS)
            {
                if (!userData.RevistaDigital.TieneRDR)
                {
                   if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                    {
                        model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                        model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    }
                    else
                    {
                        model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                        model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    }

                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                    model.EstadoAccion = 0;
                    return model;
                }

                addTagInfo = true;
            }
            else if (!userData.RevistaDigital.TieneRDR)
            {
                model.EstadoAccion = -1;
                return model;
            }

            model.EstadoAccion = 1;
            model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA<br />";
            model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
            model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
            if (addTagInfo) model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
            
            return model;
        }

        private RevistaDigitalModel ListarTabsRD(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            if (!userData.RevistaDigital.TieneRDC) return model;

            if (userData.RevistaDigital.SuscripcionModel.CampaniaID > userData.CampaniaID)
                return model;

            model.Titulo = userData.UsuarioNombre.ToUpper();

            string cadenaActiva = model.IsMobile ? "COMPRAR</br>C " : "COMPRAR CAMPAÑA ", cadenaBloqueado = model.IsMobile ? "VER</br>C " : "VER CAMPAÑA ";
            model.NombreRevista = string.Format(model.NombreRevista, model.IsMobile ? "</br>" : ""); ;

            if (userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
                model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                return model;
            }

            if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                {
                    model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                }
                else if (userData.RevistaDigital.SuscripcionModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
                {
                    model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS. RECUERDA QUE PODRÁS AGREGARLOS A PARTIR DE LA PRÓXIMA CAMPAÑA";
                }
                else
                {
                    return model;
                }
            }
            else 
            {
                model.Titulo += ", BIENVENIDA A ÉSIKA PARA MÍ TU NUEVA REVISTA ONLINE PRESONALIZADA <br />";
                model.TituloDescripcion = "ENCUENTRA LAS MEJORES OFERTAS Y BONIFICACIONES EXTRAS. <br />INSCRÍBETE PARA DISFRUTAR DE TODAS ELLAS";
            }
            //else
            //{
            //    model.Titulo += ", INSCRÍBETE A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
            //    model.TituloDescripcion = "INCREMENTA EN 20% TU GANANCIA REEMPLAZANDO TU REVISTA IMPRESA POR TU REVISTA ONLINE.";
            //}
            
            model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
            model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2), ValorOpcional = Constantes.TipoEstrategiaCodigo.OfertaParaTi });
            model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
            model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });

            return model;
        }

        public MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();
            model.IsMobile = ViewBag.EsMobile == 2;
            if (userData.RevistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile 
                        ? "PODRÁS AGREGARLA EN LA PRÓXIMA CAMPAÑA" 
                        : "PODRÁS AGREGAR ESTA OFERTA A PARTIR DE LA PRÓXIMA CAMPAÑA";
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile 
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }
            else
            {
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2)
                        : "PODRÁS AGREGAR OFERTAS COMO ESTA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2);
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }

            return model;
        }

        public bool TieneProductosPerdio(int campaniaID)
        {
            if (userData.RevistaDigital.TieneRDC &&
                userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo &&
                campaniaID == userData.CampaniaID)
                return  true;
            return false;
        }

    }
}