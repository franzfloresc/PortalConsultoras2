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
            if (revistaDigital.TieneRDI)
                return View("template-informativa-rdi");

            if (revistaDigital.TieneRDR)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

            int limiteMinimoTelef, limiteMaximoTelef;
            GetLimitNumberPhone(out limiteMinimoTelef, out limiteMaximoTelef);

            var modelo = new RevistaDigitalInformativoModel();
            modelo.EsSuscrita = revistaDigital.EsSuscrita;
            modelo.EstadoSuscripcion = revistaDigital.EstadoSuscripcion;
            modelo.Video = GetVideoInformativo();
            modelo.UrlTerminosCondiciones = GetValorDato(Constantes.ConfiguracionManager.RDUrlTerminosCondiciones);
            modelo.UrlPreguntasFrecuentes = GetValorDato(Constantes.ConfiguracionManager.RDUrlPreguntasFrecuentes);
            modelo.Origen = revistaDigital.SuscripcionEfectiva.Origen;
            modelo.NombreConsultora = userData.Sobrenombre.ToUpper();
            modelo.Email = userData.EMail;
            modelo.Celular = userData.Celular;
            modelo.LimiteMax = limiteMaximoTelef;
            modelo.LimiteMin = limiteMinimoTelef;
            modelo.UrlTerminosCondicionesDatosUsuario = GetUrlTerminosCondicionesDatosUsuario();
            modelo.CampaniaX1 = AddCampaniaAndNumero(userData.CampaniaID, 1).ToString().Substring(4);
            modelo.MostrarCancelarSuscripcion = !(userData.esConsultoraLider && revistaDigital.SociaEmpresariaExperienciaGanaMas && 
                ((!revistaDigital.EsSuscrita && (!revistaDigital.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion|| !revistaDigital.SociaEmpresariaSuscritaActivaCancelarSuscripcion)) ||
                (revistaDigital.EsSuscrita && !revistaDigital.EsActiva && !revistaDigital.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion) ||
                (revistaDigital.EsSuscrita && revistaDigital.EsActiva && !revistaDigital.SociaEmpresariaSuscritaActivaCancelarSuscripcion)));

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
            }

            return video;
        }

        public string GetValorDato(string codigo, int valor = 1)
        {
            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            var valorDato = "";
            switch (valor)
            {
                case 1: valorDato = dato.Valor1; break;
                case 2: valorDato = dato.Valor2; break;
                case 3: valorDato = dato.Valor3; break;
                default: valorDato = dato.Valor1; break;
            }
            return Util.Trim(valorDato);
        }

    }
}