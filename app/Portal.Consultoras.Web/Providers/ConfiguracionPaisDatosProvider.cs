using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionPaisDatosProvider
    {
        protected ISessionManager sessionManager;

        public ConfiguracionPaisDatosProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
        }

        public PartialSectionBpt GetPartialSectionBptModel(int seccion)
        {
            var partial = new PartialSectionBpt();
            var userData = sessionManager.GetUserData();
            var revistaDigital = sessionManager.GetRevistaDigital();

            try
            {
                partial.RevistaDigital = revistaDigital;
                partial.TieneGND = userData.TieneGND;

                if (revistaDigital.TieneRDC)
                {
                    if (revistaDigital.EsActiva)
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos =
                                revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x =>
                                    x.Codigo == ObtenerKeyPorSeccionYEstado(seccion, Constantes.RevistaDigital.Estado.InscritaActiva)) ??
                                new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos =
                                revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x =>
                                    x.Codigo == ObtenerKeyPorSeccionYEstado(seccion, Constantes.RevistaDigital.Estado.NoInscritaActiva)) ??
                                new ConfiguracionPaisDatosModel();
                        }
                    }
                    else
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos =
                                revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x =>
                                    x.Codigo == ObtenerKeyPorSeccionYEstado(seccion, Constantes.RevistaDigital.Estado.InscritaNoActiva)) ??
                                new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos =
                                revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x =>
                                    x.Codigo == ObtenerKeyPorSeccionYEstado(seccion, Constantes.RevistaDigital.Estado.NoInscritaNoActiva)) ??
                                new ConfiguracionPaisDatosModel();
                        }
                    }
                }
                else if (revistaDigital.TieneRDI)
                {
                    partial.ConfiguracionPaisDatos =
                        revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x =>
                            x.Codigo == ObtenerKeyPorSeccionYEstado(seccion, Constantes.RevistaDigital.Estado.Intriga)) ?? 
                        new ConfiguracionPaisDatosModel();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora,
                    (userData ?? new UsuarioModel()).CodigoISO);
            }

            return partial;
        }

        private string ObtenerKeyPorSeccionYEstado(int seccion, string estado)
        {
            switch (seccion)
            {
                case Constantes.OrigenPedidoWeb.DesktopHome:
                    return ObtenerKeyHomePorEstado(estado, false);
                case Constantes.OrigenPedidoWeb.DesktopPedido:
                    return ObtenerKeyPedidoPorEstado(estado, false);
                case Constantes.OrigenPedidoWeb.DesktopCatalogo:
                    return ObtenerKeyCatalogoPorEstado(estado, false);
                case Constantes.OrigenPedidoWeb.MobileHome:
                    return ObtenerKeyHomePorEstado(estado, true);
                case Constantes.OrigenPedidoWeb.MobilePedido:
                    return ObtenerKeyPedidoPorEstado(estado, true);
                case Constantes.OrigenPedidoWeb.MobileCatalogo:
                    return ObtenerKeyCatalogoPorEstado(estado, true);
                default:
                    return ObtenerKeyHomePorEstado(estado, false);
            }
        }

        private string ObtenerKeyPedidoPorEstado(string estado, bool isMobile)
        {
            switch (estado)
            {
                case Constantes.RevistaDigital.Estado.InscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MPedidoInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DPedidoInscritaActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MPedidoNoInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DPedidoNoInscritaActiva;
                case Constantes.RevistaDigital.Estado.InscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MPedidoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DPedidoInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MPedidoNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DPedidoNoInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.Intriga:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RDI.MPedidoIntriga
                        : Constantes.ConfiguracionPaisDatos.RDI.DPedidoIntriga;
                default:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MPedidoNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DPedidoNoInscritaNoActiva;
            }
        }

        private string ObtenerKeyHomePorEstado(string estado, bool isMobile)
        {
            switch (estado)
            {
                case Constantes.RevistaDigital.Estado.InscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MBienvenidaInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MBienvenidaNoInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaActiva;
                case Constantes.RevistaDigital.Estado.InscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MBienvenidaInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MBienvenidaNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.Intriga:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RDI.MBienvenidaIntriga
                        : Constantes.ConfiguracionPaisDatos.RDI.DBienvenidaIntriga;
                default:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MBienvenidaNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaNoActiva;
            }
        }

        private string ObtenerKeyCatalogoPorEstado(string estado, bool isMobile)
        {
            switch (estado)
            {
                case Constantes.RevistaDigital.Estado.InscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DCatalogoInscritaActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DCatalogoNoInscritaActiva;
                case Constantes.RevistaDigital.Estado.InscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DCatalogoInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.NoInscritaNoActiva:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DCatalogoNoInscritaNoActiva;
                case Constantes.RevistaDigital.Estado.Intriga:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RDI.MCatalogoIntriga
                        : Constantes.ConfiguracionPaisDatos.RDI.DCatalogoIntriga;
                default:
                    return isMobile
                        ? Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaNoActiva
                        : Constantes.ConfiguracionPaisDatos.RD.DCatalogoNoInscritaNoActiva;
            }
        }
        
        public string GetValorDato(IList<ConfiguracionPaisDatosModel> configuracionesPaisDatos, string codigo, bool esMobile, int valor = 1)
        {
            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
            var valorDato = "";
            switch (valor)
            {
                case 0: valorDato = esMobile ? dato.Valor2 : dato.Valor1; break;
                case 1: valorDato = dato.Valor1; break;
                case 2: valorDato = dato.Valor2; break;
                case 3: valorDato = dato.Valor3; break;
                default: valorDato = dato.Valor1; break;
            }
            return Util.Trim(valorDato);
        }

        #region Objeto Diferente a las cajas de producto

        public EstrategiaPersonalizadaProductoModel GetBannerCajaProducto(int tipoConsulta, bool esMobile)
        {
            var modelo = new EstrategiaPersonalizadaProductoModel();
            if (tipoConsulta == Constantes.TipoConsultaOfertaPersonalizadas.MGObtenerProductos)
            {
                var sessionPalanca = sessionManager.MasGanadoras.GetModel();
                modelo.DescripcionCompleta = GetValorDato(sessionPalanca.ConfiguracionPaisDatos, Constantes.ConfiguracionPaisDatos.MG.BannerCarruselTitulo, esMobile);
                modelo.DescripcionDetalle = GetValorDato(sessionPalanca.ConfiguracionPaisDatos, Constantes.ConfiguracionPaisDatos.MG.BannerCarruselTextoEnlace, esMobile);
                modelo.DescripcionMarca = esMobile ? "/Mobile/MasGanadoras/Index" : "/MasGanadoras/Index";
                modelo.TipoAccionAgregar = Constantes.TipoAccionAgregar.BannerCarruselMg;
            }
            return modelo;
        }

        #endregion
    }
}