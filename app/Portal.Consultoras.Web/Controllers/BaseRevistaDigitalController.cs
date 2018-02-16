using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult IndexModel()
        {
            if(revistaDigital.TieneRDI)
                return View("template-informativa-rdi");

            if (revistaDigital.TieneRDR)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

            ViewBag.NombreConsultora = userData.NombreConsultora.ToUpper();
            ViewBag.EMail = userData.EMail;
            ViewBag.Celular = userData.Celular;

            #region limite Min - Max Telef
            switch (userData.PaisID)
            {
                case Constantes.PaisID.Mexico:
                    ViewBag.limiteMinimoTelef = 5;
                    ViewBag.limiteMaximoTelef = 15;
                    break;
                case Constantes.PaisID.Peru:
                    ViewBag.limiteMinimoTelef = 7;
                    ViewBag.limiteMaximoTelef = 9;
                    break;
                case Constantes.PaisID.Colombia:
                    ViewBag.limiteMinimoTelef = 10;
                    ViewBag.limiteMaximoTelef = 10;
                    break;
                case Constantes.PaisID.Guatemala:
                case Constantes.PaisID.ElSalvador:
                case Constantes.PaisID.Panama:
                case Constantes.PaisID.CostaRica:
                    ViewBag.limiteMinimoTelef = 8;
                    ViewBag.limiteMaximoTelef = 8;
                    break;
                case Constantes.PaisID.Ecuador:
                    ViewBag.limiteMinimoTelef = 9;
                    ViewBag.limiteMaximoTelef = 10;
                    break;
                default:
                    ViewBag.limiteMinimoTelef = 0;
                    ViewBag.limiteMaximoTelef = 15;
                    break;
            }
            #endregion

            var modelo = new RevistaDigitalInformativoModel
            {
                EsSuscrita = revistaDigital.EsSuscrita,
                EstadoSuscripcion = revistaDigital.EstadoSuscripcion,
                Video = GetVideoInformativo(),
                UrlTerminosCondiciones = Getvalor1Dato(Constantes.ConfiguracionManager.RDUrlTerminosCondiciones),
                UrlPreguntasFrecuentes = Getvalor1Dato(Constantes.ConfiguracionManager.RDUrlPreguntasFrecuentes),
                Origen = revistaDigital.SuscripcionEfectiva.Origen
            };
                        
            return View("template-informativa", modelo);
        }

        public ActionResult ViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : AddCampaniaAndNumero(userData.CampaniaID, 1);

            var model = new RevistaDigitalLandingModel();
            if (EsCampaniaFalsa(id)) return PartialView("template-landing", model);

            model.CampaniaID = id;
            model.IsMobile = IsMobile();

            model.FiltersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = model.IsMobile ? "ORDENAR POR" : "ORDENAR POR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor,
                    Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor,
                    Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO"
                }
            };

            model.FiltersByBrand = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos {Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA"},
                new BETablaLogicaDatos {Codigo = "CYZONE", Descripcion = "CYZONE"},
                new BETablaLogicaDatos {Codigo = "ÉSIKA", Descripcion = "ÉSIKA"},
                new BETablaLogicaDatos {Codigo = "LBEL", Descripcion = "LBEL"}
            };

            model.Success = true;
            var dato = ObtenerPerdio(model.CampaniaID);
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;
            
            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            model.CantidadFilas = 10;

            return PartialView("template-landing", model);
        }

        public ActionResult DetalleModel(string cuv, int campaniaId)
        {
            var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (!revistaDigital.TieneRevistaDigital())
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;

            var dato = ObtenerPerdio(modelo.CampaniaID);
            ViewBag.TieneProductosPerdio = dato.Estado;
            ViewBag.PerdioTitulo = dato.Valor1;
            ViewBag.PerdioSubTitulo = dato.Valor2;
            
            ViewBag.Campania = campaniaId;
            return View(modelo);

        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        public bool TieneProductosPerdio(int campaniaId)
        {
            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva &&
                campaniaId == userData.CampaniaID)
                return true;

            return false;
        }

        private ConfiguracionPaisDatosModel ObtenerPerdio(int campaniaId)
        {
            var dato = new ConfiguracionPaisDatosModel();
            if (TieneProductosPerdio(campaniaId))
            {
                dato = revistaDigital.ConfiguracionPaisDatos
                    .FirstOrDefault(d => d.Codigo == (IsMobile() ? Constantes.ConfiguracionPaisDatos.RD.MPerdiste : Constantes.ConfiguracionPaisDatos.RD.DPerdiste));
                dato = dato ?? new ConfiguracionPaisDatosModel();
                dato.Estado = true;
            }
            dato.Valor1 = Util.Trim(dato.Valor1);
            dato.Valor2 = Util.Trim(dato.Valor2);
            return dato;
        }

        private string GetVideoInformativo()
        {
            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RD.InformativoVideo) ?? new ConfiguracionPaisDatosModel();
            string video;
            if (IsMobile())
            {
                video = Util.Trim(dato.Valor2);
            }
            else
            {
                video = Util.Trim(dato.Valor1);
               // video = video != "" ? "https://www.youtube.com/embed/" + (video) + "?rel=0&amp;controls=1&amp;modestbranding=0" : "";
            }

            return video;
        }

        private string Getvalor1Dato(string codigo)
        {
            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            return Util.Trim(dato.Valor1);
        }
        
    }
}