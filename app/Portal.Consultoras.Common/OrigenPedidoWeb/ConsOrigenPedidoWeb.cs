
using System;

namespace Portal.Consultoras.Common.OrigenPedidoWeb
{
    /// <summary>
    /// Valores de OrigenPedidoWeb
    /// <para> Estructura : Dispositivo + Pagina + Palanca + Seccion </para>
    /// </summary>
    public static class ConsOrigenPedidoWeb
    {
        public static class Dispositivo
        {
            public const string Desktop = "1";
            public const string Mobile = "2";
            public const string ChatBot = "3";
            public const string AppConsultora = "4";
            public const string AppMaquillador = "5";
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
            public const string Maquillador = "12";
            public const string ArmaTuPackDetalle = "13";
            public const string LandingDuoPerfecto = "14";
            public const string LandingPackNuevas = "15";
            public const string LandingOfertaDelDia = "16";
            public const string LandingCategoria = "17";
            public const string CaminoBrillante = "18";
            public const string Ficha = "19";
        }

        public static class Palanca
        {
            public const string OfertasParaTi = "00";
            public const string Showroom = "01";
            public const string Lanzamientos = "02";
            public const string OfertaDelDia = "03";
            public const string OfertaFinal = "04";
            public const string Gnd = "05";
            public const string Liquidacion = "06";
            public const string ProductoSugerido = "07";
            public const string HerramientasVenta = "08";
            public const string Banners = "09";
            public const string Digitado = "10";
            public const string CatalogoLbel = "11";
            public const string CatalogoEsika = "12";
            public const string CatalogoCyzone = "13";
            public const string Ganadoras = "14";
            public const string ArmaTuPack = "15";
            public const string DuoPerfecto = "16";
            public const string PackNuevas = "17";
            public const string EscogeTuRegalo = "18";
            public const string OfertasEspeciales = "19";
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
            public const string Recomendado = "08";
            public const string RecomendadoFicha = "09";
            public const string AppCatalogoPendienteDeAprobar = "10";
            public const string CatalogoDigitalPendienteDeAprobarCliente = "11";
            public const string AppMaquilladorPendienteDeAprobarCliente = "12";
            public const string CatalogoDigitalPendienteDeAprobarProducto = "13";
            public const string AppMaquilladorPendienteDeAprobarProducto = "14";
            public const string CarruselUpselling = "15";
            public const string FichaUpselling = "16";
        }

        public const string IncorrectoDispositivo = "0";
        public const string Incorrecto = "99";

        /// <summary>
        /// 0: Dispositivo
        /// 1: Pagina
        /// 2: Palanca
        /// 3: Seccion
        /// </summary>
        public const string StrFormat = "{0}{1}{2}{3}";

        /// <summary>
        /// Nro Final Concatenado
        /// </summary>
        public static int DispositivoPaginaPalancaSeccion
        {
            get
            {
                return Convert.ToInt32(Dispositivo.AppConsultora + Pagina.ArmaTuPackDetalle + Palanca.ArmaTuPack + Seccion.AppCatalogoPendienteDeAprobar);
            }
        }

    }
}