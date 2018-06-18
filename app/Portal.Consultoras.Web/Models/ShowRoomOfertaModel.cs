using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomOfertaModel : CompartirRedesSocialesModel
    {
        public int OfertaShowRoomID { get; set; }

        public int CampaniaID { get; set; }

        public string CUV { get; set; }

        public int TipoOfertaSisID { get; set; }

        public int ConfiguracionOfertaID { get; set; }

        public string Descripcion { get; set; }

        public decimal PrecioOferta { get; set; }

        public decimal PrecioValorizado { get; set; }

        public int Stock { get; set; }

        public int StockInicial { get; set; }

        public string ImagenProducto { get; set; }

        public int Orden { get; set; }

        public int UnidadesPermitidas { get; set; }

        public bool FlagHabilitarProducto { get; set; }

        public string DescripcionLegal { get; set; }

        public string CategoriaID { get; set; }

        public string UsuarioRegistro { get; set; }

        public DateTime FechaRegistro { get; set; }

        public string UsuarioModificacion { get; set; }

        public DateTime FechaModificacion { get; set; }

        public string ImagenMini { get; set; }

        public int NroOrden { get; set; }

        public string CodigoCampania { get; set; }

        public string CodigoTipoOferta { get; set; }

        public string TipoOferta { get; set; }

        public string CodigoProducto { get; set; }

        public string ISOPais { get; set; }

        public int PaisID { get; set; }

        public int MarcaID { get; set; }

        public string DescripcionMarca { get; set; }

        public string ImagenProductoAnterior { get; set; }

        public string ImagenMiniAnterior { get; set; }

        public IList<ShowRoomOfertaModel> ListaOfertaShowRoom { get; set; }

        public IList<ShowRoomOfertaModel> ListaShowRoomCompraPorCompra { get; set; }

        public string Subtitulo { get; set; }
        public int Incrementa { get; set; }
        public int CantidadIncrementa { get; set; }
        public int Agotado { get; set; }
        public string CodigoCategoria { get; set; }
        public string TipNegocio { get; set; }
        public string CodigoISO { get; set; }
        public string Simbolo { get; set; }
        public string Agregado { get; set; }
        public bool TieneCompraXcompra { get; set; }
        public string DescripcionCategoria { get; set; }
        public string TextoCondicionCompraCpc { get; set; }
        public string TextoDescripcionLegalCpc { get; set; }
        public decimal Gana { get { return Math.Abs(PrecioValorizado - PrecioOferta); } }
        public string FormatoPrecioValorizado { get { return Util.DecimalToStringFormat(PrecioValorizado, CodigoISO); } }
        public string FormatoPrecioOferta { get { return Util.DecimalToStringFormat(PrecioOferta, CodigoISO); } }
        public string FormatoGana { get { return Util.DecimalToStringFormat(Gana, CodigoISO); } }
        public bool EMailActivo { get; set; }
        public string EMail { get; set; }
        public string Celular { get; set; }
        public bool Suscripcion { get; set; }
        public string UrlTerminosCondiciones { get; set; }

        public bool EsSubCampania { get; set; }
        public int UnidadesPermitidasRestantes { get; set; }

        public int Posicion { get; set; }
        public string UrlDetalle { get; set; }

        public List<ProductoModel> ProductoTonos { get; set; }

        public string CodigoEstrategia { get; set; }

        public int EstrategiaId { get; set; }

        /// <summary>
        /// 1: AGRÉGALO - No alterar cantidad, caso pack nuevas
        /// 2: AGRÉGALO - Si puede alterar cantidad
        /// 3: ELIGE TU OPCIÓN
        /// 4: ¿LO QUIERES?
        /// </summary>
        public int TipoAccionAgregar { get; set; }
        
        public int TieneVariedad { get; set; }
    }
}