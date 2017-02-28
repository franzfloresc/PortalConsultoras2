using System;
using System.Collections.Generic;

using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ShowRoomOfertaModel
    {
        public int OfertaShowRoomID { get; set; }

        public int CampaniaID { get; set; }

        public string CUV { get; set; }

        public int TipoOfertaSisID { get; set; }
       
        public int ConfiguracionOfertaID { get; set; }

        public string Descripcion { get; set; }

        public decimal PrecioOferta { get; set; }

        public decimal PrecioCatalogo { get; set; }

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

        public IList<ShowRoomOfertaDetalleModel> ListaDetalleOfertaShowRoom { get; set; }

        public string Subtitulo { get; set; }

        public int Incrementa { get; set; }
        public int CantidadIncrementa { get; set; }
        public int Agotado { get; set; }

        public string CodigoCategoria { get; set; }
        public string TipNegocio { get; set; }

        public string CodigoISO { get; set; }
        public string Simbolo { get; set; }
        public decimal Gana {
            set
            {
                this.Gana = value;
            }
            get
            {
                return PrecioCatalogo - PrecioOferta;
            }
        }

        public string FormatoPrecioCatalogo
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoISO);
            }
        }

        public string FormatoPrecioOferta
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoISO);
            }
        }

        public string FormatoGana
        {
            get
            {
                return Util.DecimalToStringFormat(Gana, CodigoISO);
            }
        }
    }
}