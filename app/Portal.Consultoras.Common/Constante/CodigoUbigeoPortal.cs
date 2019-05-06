
namespace Portal.Consultoras.Common
{
    /// <summary>
    /// Valores de Codigo Ubigeo Portal
    /// </summary>
    public static class CodigoUbigeoPortal
    {

        public const string Guion = "--";

        public static class Dispositivo
        {
            public const string Desktop = "01";
            public const string Mobile = "02";
        }

        public static class Pagina
        {
            public const string LandingHerramientasVenta = "00";
            public const string Home = "01";
            public const string Pedido = "02";
            public const string LandingLiquidacion = "03";
            public const string Buscador = "04";
            public const string LandingShowroom = "05";
            public const string LandingGnd = "06";
            public const string LandingOfertasParaTi = "07";
            public const string Contenedor = "08";
            public const string Otras = "09";
            public const string LandingBuscador = "10";
            public const string LandingGanadoras = "11";
            public const string ArmaTuPack = "12"; //Manda cuando estemos dentro de armatupack
            public const string MisCatalogosRevista = "13"; //Catalogo
            public const string LandingDuoPerfecto = "14";
            public const string LandingPackNuevas = "15";
        }

        public static class SeccionFuncional
        {
            public const string OfertasParaTi = "00";   //Revista digital
            public const string Showroom = "01";
            public const string Lanzamientos = "02";
            public const string OfertaDelDia = "03";
            public const string OfertaFinal = "04";
            public const string GND = "05";
            public const string Liquidacion = "06";
            public const string ProductoSugerido = "07";
            public const string HerramientasVenta = "08";
            public const string Banners = "09";
            public const string Digitado = "10";
            public const string CatalogoLbel = "11";
            public const string CatalogoEsika = "12";
            public const string CatalogoCyzone = "13";
            public const string Ganadoras = "14";
            public const string Grilla = "15";
            public const string ArmaTuPack = "16";
            public const string ResumenBelcorp = "17";
        }

        public static class Seccion
        {
            public const string Carrusel = "01";
            public const string Ficha = "02";
            public const string Banner = "03";
            public const string DesplegableBuscador = "04";
            public const string CarruselVerMas = "05";
            public const string BannerSuperior = "06";
            public const string SubCampania = "07";
            public const string Recomendados = "08";
            public const string FichaResumida = "09";

        }

        public static string GuionPedidoGuionFichaResumida
        {
            get { return Guion + Pagina.Pedido + Guion + Seccion.FichaResumida; }
        }
        /// <summary>
        /// Ubigeo Arma tu Pack para Banner 
        /// </summary>
        public static string GuionContenedorArmaTuPackGuion
        {
            get { return Guion + Pagina.Contenedor + SeccionFuncional.ArmaTuPack + Guion; }
        }
        /// <summary>
        /// Ubigeo Arma tu Pack para Landing
        /// </summary>
        public static string GuionContenedorArmaTuPack
        {
            get { return Guion + Pagina.ArmaTuPack + Guion + Guion; }
        }

        #region RevistaDigitalMobileCatalogoSeccion
        //Antes: RevistaDigitalMobileCatalogoSeccion = 2401 RedireccionarContenedorComprar, RedireccionarContenedorInformativa

        public static string MobileRevistaDigitalMobileCatalogoSeccion
        {
            get { return Dispositivo.Mobile + Pagina.MisCatalogosRevista + SeccionFuncional.OfertasParaTi + Guion; }
        }

        public static string DesktopRevistaDigitalMobileCatalogoSeccion
        {
            get { return Dispositivo.Desktop + Pagina.MisCatalogosRevista + SeccionFuncional.OfertasParaTi + Guion; }
        }
        #endregion

        #region RevistaDigitalMobileHomeSeccion
        public static string MobileRevistaDigitalHomeSeccion
        {
            get { return Dispositivo.Mobile + Pagina.Home + SeccionFuncional.OfertasParaTi + Guion; }
        }

        public static string DesktopRevistaDigitalHomeSeccion
        {
            get { return Dispositivo.Desktop + Pagina.Home + SeccionFuncional.OfertasParaTi + Guion; }
        }
        #endregion

        #region RevistaDigitalMobileHomeSeccion
        public static string MobileRevistaDigitalResumenBelcorp
        {
            get { return Dispositivo.Mobile + Pagina.Home + SeccionFuncional.ResumenBelcorp + Guion; }
        }

        public static string DesktopRevistaDigitalResumenBelcorp
        {
            get { return Dispositivo.Desktop + Pagina.Home + SeccionFuncional.ResumenBelcorp + Guion; }
        }
        #endregion

        #region RevistaDigitalDesktopPedidoSeccion
        public static string MobilePedidoRevistaDigital
        {
            get { return Dispositivo.Mobile + Pagina.Pedido + SeccionFuncional.OfertasParaTi + Guion; }
        }

        public static string DesktopPedidoRevistaDigital
        {
            get { return Dispositivo.Desktop + Pagina.Pedido + SeccionFuncional.OfertasParaTi + Guion; }
        }
        #endregion
    }
}