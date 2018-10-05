using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalModel
    {
        public RevistaDigitalModel()
        {
            SuscripcionModel = new RevistaDigitalSuscripcionModel();
            SuscripcionEfectiva = new RevistaDigitalSuscripcionModel();
            ListaTabs = new List<ComunModel>();
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            EstadoRdcAnalytics = "(not available)";

            BloquearRevistaImpresaGeneral = null;
            NoVolverMostrar = true;
        }

        public int ConfiguracionPaisID { get; set; }
        public int CampaniaID { get; set; }
        public int BloquearDiasAntesFacturar { get; set; }
        public int CantidadCampaniaEfectiva { get; set; }
        public string NombreComercialActiva { get; set; }
        public string NombreComercialNoActiva { get; set; }

        public string DLogoMenuInicioActiva { get; set; }
        public string DLogoMenuInicioNoActiva { get; set; }
        public string DLogoMenuInicioNoSuscrita { get; set; }
        public string DLogoMenuInicioNoActivaNoSuscrita { get; set; }

        public string MLogoMenuInicioActiva { get; set; }
        public string MLogoMenuInicioNoActiva { get; set; }

        public string DLogoComercialActiva { get; set; }
        public string DLogoComercialNoActiva { get; set; }
        public string MLogoComercialActiva { get; set; }
        public string MLogoComercialNoActiva { get; set; }

        public string DLogoComercialFondoActiva { get; set; }
        public string DLogoComercialFondoNoActiva { get; set; }
        public string MLogoComercialFondoActiva { get; set; }
        public string MLogoComercialFondoNoActiva { get; set; }

        public string LogoMenuOfertasActiva { get; set; }
        public string LogoMenuOfertasNoActiva { get; set; }

        public string EstadoRdcAnalytics { get; set; }

        public bool TieneRDI { get; set; }
        public bool TieneRDCR { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneRDS { get; set; }
        public bool EsActiva { get; set; }
        public bool EsSuscrita { get; set; }

        public bool ActivoMdo { get; set; }

        public string NombreConsultora { get; set; }
        public string CampaniaActual { get; set; }
        /// <summary>
        /// campaña que realizo la suscripcion o desuscripcion
        /// </summary>
        public string CampaniaSuscripcion { get; set; }
        /// <summary>
        /// campaña que se tomara efecto la suscripción
        /// </summary>
        public string CampaniaActiva { get; set; }
        /// <summary>
        /// CampaniaActual + CantidadCampaniaEfectiva
        /// </summary>
        public string CampaniaFuturoActiva { get; set; }

        public bool NoVolverMostrar { get; set; }
        public int EstadoSuscripcion { get; set; }
        public string NumeroContacto { get; set; }

        public RevistaDigitalSuscripcionModel SuscripcionModel { get; set; }
        public RevistaDigitalSuscripcionModel SuscripcionEfectiva { get; set; }

        public string Titulo { get; set; }
        public string SubTitulo { get; set; }
        public string SubTitulo2 { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }

        public int EstadoAccion { get; set; }
        public List<ComunModel> ListaTabs { get; set; }
        public string TituloDescripcion { get; set; }
        public int Campania { get; set; }
        public int CampaniaMasUno { get; set; }
        public bool BloqueoRevistaImpresa { get; set; }
        public int? BloquearRevistaImpresaGeneral { get; set; }
        public int BloquearProductosSugeridos { get; set; }
        public bool SubscripcionAutomaticaAVirtualCoach { get; set; }

        public bool BloqueoProductoDigital { get; set; }
        public string BannerOfertasNoActivaNoSuscrita { get; set; }
        public string BannerOfertasNoActivaSuscrita { get; set; }
        public string BannerOfertasActivaNoSuscrita { get; set; }
        public string BannerOfertasActivaSuscrita { get; set; }
        public bool SociaEmpresariaExperienciaGanaMas { get; set; }
        public bool SociaEmpresariaSuscritaNoActivaCancelarSuscripcion { get; set; }
        public bool SociaEmpresariaSuscritaActivaCancelarSuscripcion { get; set; }

        public bool EsSuscritaInactiva()
        {
            return TieneRDC && EsSuscrita && !EsActiva;
        }

        public bool EsSuscritaActiva()
        {
            return TieneRDC && EsSuscrita && EsActiva;
        }

        public bool EsNoSuscritaInactiva()
        {
            return TieneRDC && !EsSuscrita && !EsActiva;
        }

        public bool EsNoSuscritaActiva()
        {
            return TieneRDC && !EsSuscrita && EsActiva;
        }

        public string GetLogo(bool mobile)
        {
            if (mobile)
            {
                return EsActiva ? MLogoComercialActiva : EsSuscrita ? MLogoComercialActiva : MLogoComercialNoActiva;
            }
            return EsActiva ? DLogoComercialActiva : EsSuscrita ? DLogoComercialActiva : DLogoComercialNoActiva;
        }

        public string GetLogoFondo(bool mobile)
        {
            if (mobile)
            {
                return EsActiva ? MLogoComercialFondoActiva : EsSuscrita ? MLogoComercialFondoActiva : MLogoComercialFondoNoActiva;
            }
            return EsActiva ? DLogoComercialFondoActiva : EsSuscrita ? DLogoComercialFondoActiva : DLogoComercialFondoNoActiva;
        }

        public bool TieneRevistaDigital()
        {
            return TieneRDC;
        }
    }


}