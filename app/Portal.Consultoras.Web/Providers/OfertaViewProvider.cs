using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaViewProvider : OfertaPersonalizadaProvider
    {
        public List<BETablaLogicaDatos> GetFiltersBySorting(bool esMObile)
        {
            // se debe cambiar a ComunModel            
            var filtersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = "ORDENAR POR"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MenorAMayor,
                    Descripcion = esMObile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MayorAMenor,
                    Descripcion = esMObile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO"
                }
            };
            return filtersBySorting;
        }

        public List<BETablaLogicaDatos> GetFiltersByBrand()
        {
            var filterByBrand = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Predefinido,
                    Descripcion = "FILTRAR POR"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Cyzone,
                    Descripcion = "CYZONE"
                },
                new BETablaLogicaDatos {Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Esika, Descripcion = "ÉSIKA"},
                new BETablaLogicaDatos {Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.LBel, Descripcion = "LBEL"}
            };
            return filterByBrand;
        }

        public virtual MensajeProductoBloqueadoModel MensajeProductoBloqueado(bool esMObile)
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = esMObile;

            string codigo = String.Empty;
            ConfiguracionPaisDatosModel dato;
            if (revistaDigital.EsActiva)
            {
                model.MensajeIconoSuperior = true;
                model.BtnInscribirse = false;

                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                model.MensajeTitulo = Util.Trim(dato.Valor1);
                return model;
            }
            else
            {
                model.MensajeIconoSuperior = false;
                model.BtnInscribirse = !revistaDigital.EsSuscrita;

                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                model.MensajeTitulo = Util.Trim(dato.Valor1);
            }

            if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            {
                model.MensajeBtnPopup = "DE ACUERDO";
                model.IdPopup = !model.IsMobile ? "divSNAPopupBloqueadoDesk" : "divSNAPopupBloqueadoMob";
                model.UrlBtnPopup = "javascript: void(0)";

                codigo = Constantes.ConfiguracionPaisDatos.RD.PopupBloqueadoSNA;
            }
            else if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
            {
                model.MensajeBtnPopup = "SUSCRIBETE GRATIS";
                model.IdPopup = !model.IsMobile ? "divNSPopupBloqueadoDesk" : "divNSPopupBloqueadoMob";
                model.UrlBtnPopup = (model.IsMobile ? "/Mobile" : "") + "/RevistaDigital/Informacion/";

                codigo = Constantes.ConfiguracionPaisDatos.RD.PopupBloqueadoNS;
            }

            dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            model.MensajePopupPrimero = Util.RemplazaTag(dato.Valor1, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));
            model.MensajePopupSegundo = Util.RemplazaTag(dato.Valor2, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));

            return model;
        }
        
        public virtual MensajeProductoBloqueadoModel RDMensajeProductoBloqueado(bool esMobile)
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = esMobile;
            string codigo;

            if (revistaDigital.EsSuscrita)
            {
                model.MensajeIconoSuperior = true;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
                model.BtnInscribirse = false;
            }
            else
            {
                model.MensajeIconoSuperior = false;
                codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
                model.BtnInscribirse = true;
            }

            var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            model.MensajeTitulo = dato == null ? "" : Util.Trim(dato.Valor1);

            return model;
        }

        public ConfiguracionPaisDatosModel ObtenerPerdioTitulo(int campaniaId, bool esMObile)
        {
            var dato = new ConfiguracionPaisDatosModel();
            if (TieneProductosPerdio(campaniaId))
            {
                var codigo = "";
                bool upper = false;
                if (!revistaDigital.EsSuscrita)
                {
                    codigo = Constantes.ConfiguracionPaisDatos.RD.NSPerdiste;
                    upper = true;
                }
                else if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva)
                {
                    codigo = Constantes.ConfiguracionPaisDatos.RD.SNAPerdiste;
                    upper = true;
                }
                else
                {
                    codigo = esMObile ? Constantes.ConfiguracionPaisDatos.RD.MPerdiste : Constantes.ConfiguracionPaisDatos.RD.DPerdiste;
                }

                dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();

                dato.Valor1 = Util.RemplazaTag(dato.Valor1, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));
                dato.Valor2 = Util.RemplazaTag(dato.Valor2, Constantes.TagCadenaRd.Campania, string.Concat("C", revistaDigital.CampaniaFuturoActiva));

                if (upper)
                {
                    dato.Valor1 = dato.Valor1.ToUpper();
                    dato.Valor2 = dato.Valor2.ToUpper();
                }

                dato.Estado = true;
            }

            dato.Valor1 = Util.Trim(dato.Valor1);
            dato.Valor2 = Util.Trim(dato.Valor2);

            return dato;
        }
    }
}