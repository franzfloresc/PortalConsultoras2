//------------------------------------------------------------------------------
// <Definición>
//     Fecha              : 04/06/2018
//     Archivo Creado por : Zoluxiones (JN)
//     Propósito          : Clase Vista-Modelo que agrupa estrategias de diferentes palancas del sitio.
// </Definición>
//------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaViewModel
    {
        public int EstrategiaID { get; set; }
        public string CodigoEstrategia { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }
        public string ClaseEstrategia { get; set; }
        public int TipoEstrategiaID { get; set; }
        public EstrategiaDetalleModelo TipoEstrategiaDetalle { get; set; }
        public int CampaniaID { get; set; }
        public string TipoEstrategiaDescripcion { get; set; }
        public string CodigoIso { get; set; }

        public List<string> ArrayContenidoSet { get; set; }
        public List<string> ListaDescripcionDetalle { get; set; }
        public List<ProductoModel> Hermanos { get; set; }
        public List<OfertaDelDiaModel> ListaOfertas { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }
        public short Posicion { get; set; }    //NOTA: Se usa short y no int.
        public bool TienePaginaProducto { get; set; }
        public bool TienePaginaProductoMob { get; set; }
        public string FotoProducto01 { get; set; }
        public string ImagenURL { get; set; }
        public string ClaseBloqueada { get; set; }
        public int FlagNueva { get; set; }
        public int FlagRevista { get; set; }
        public bool IsAgregado { get; set; }
        public string CodigoVariante { get; set; }
        public string TextoLibre { get; set; }
        public int MarcaID { get; set; }

        public string CUV { get; set; }
        public string CUV2 { get; set; }

        public string DescripcionMarca { get; set; } 
        public string DescripcionResumen { get; set; }
        public string DescripcionCortada { get; set; }
        public string DescripcionDetalle { get; set; }
        public string DescripcionCompleta { get; set; }
        public string DescripcionOferta { get; set; }
        public string DescripcionCategoria { get; set; }

        public decimal Precio { get; set; }
        public decimal Precio2 { get; set; }
        public decimal PrecioOferta { get; set; }
        public string  PrecioTachado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string  PrecioVenta { get; set; }
        public decimal PrecioValorizado { get; set; }


        public IList<ShowRoomOfertaModel> ListaOfertaShowRoom { get; set; }

        public EstrategiaViewModel()
        {
            TipoEstrategiaDetalle = new EstrategiaDetalleModelo();
            ArrayContenidoSet = new List<string>();
            ListaDescripcionDetalle = new List<string>();
            Hermanos = new List<ProductoModel>();
            ListaOfertas = new List<OfertaDelDiaModel>();
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            ConfiguracionContenedor = new ConfiguracionSeccionHomeModel();
        }
        #region POSIBILIDA DE FACTORIZAR ESTA SECCION
        public string PrecioOfertaFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoIso);
            }
        }
        public string PrecioCatalogoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoIso);
            }
        }
        public string FormatoPrecioValorizado
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioValorizado, CodigoIso);
            }
        }
        public string FormatoPrecioOferta
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoIso);
            }
        }
        #endregion
        /// <summary>
        /// 1: AGRÉGALO - No alterar cantidad, caso pack nuevas
        /// 2: AGRÉGALO - Si puede alterar cantidad
        /// 3: ELIGE TU OPCIÓN
        /// 4: ¿LO QUIERES?
        /// </summary>
        public int TipoAccionAgregar { get; set; } // es para los diferentes botones que sale en la seccion de agrega, elegir tono, .
    }
}