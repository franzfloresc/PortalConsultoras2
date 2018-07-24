using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaFlexipago
    {
        [DataMember]
        [ViewProperty]
        public int PaisID { get; set; }

        [DataMember]
        [ViewProperty]
        public int OfertaProductoID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Stock { get; set; }
        [DataMember]
        public string CategoriaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [ViewProperty]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        [ViewProperty]
        public string Descripcion { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioNormal { get; set; }
        [DataMember]
        [ViewProperty]
        public string ImagenProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public int Orden { get; set; }
        [DataMember]
        [ViewProperty]
        public int UnidadesPermitidas { get; set; }
        [DataMember]
        [ViewProperty]
        public int FlagHabilitarProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoCampania { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoTipoOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public string TipoOferta { get; set; }
        [DataMember]
        [ViewProperty]
        public int NroOrden { get; set; }
        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }
        [DataMember]
        [ViewProperty]
        public string CodigoProducto { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionLegal { get; set; }
        [DataMember]
        [ViewProperty]
        public int MarcaID { get; set; }
        [DataMember]
        [ViewProperty]
        public int Flag { get; set; }
        [DataMember]
        [ViewProperty]
        public int StockInicial { get; set; }

        [DataMember]
        [ViewProperty]
        public string LinksFlexipago { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoTotal { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoPagado { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoPorCuota { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal InteresePorCuota { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal CuotaPendCampaniaActual { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal CuotaPendCampaniaSiguiente { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PedidoBase { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal LineaCredito { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal MontoMinimoFlexipago { get; set; }

        public BEOfertaFlexipago() { }
        public BEOfertaFlexipago(IDataRecord row)
        {
            OfertaProductoID = row.ToInt32("OfertaProductoID");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            NroOrden = row.ToInt32("NroOrden");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoCampania = row.ToString("CodigoCampania");
            CUV = row.ToString("CUV");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            TipoOferta = row.ToString("TipoOferta");
            Descripcion = row.ToString("Descripcion");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            PrecioNormal = row.ToDecimal("PrecioNormal");
            Stock = row.ToInt32("Stock");
            StockInicial = row.ToInt32("StockInicial");
            ImagenProducto = row.ToString("ImagenProducto");
            UnidadesPermitidas = row.ToInt32("UnidadesPermitidas");
            FlagHabilitarProducto = row.ToInt32("FlagHabilitarProducto");
            Orden = row.ToInt32("Orden");
            CodigoProducto = row.ToString("CodigoProducto");
            DescripcionLegal = row.ToString("DescripcionLegal");
            CategoriaID = row.ToString("CategoriaID");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            MarcaID = row.ToInt32("MarcaID");
            LinksFlexipago = row.ToString("LinksFlexipago");
            MontoTotal = row.ToDecimal("MontoTotal");
            MontoPagado = row.ToDecimal("MontoPagado");
            MontoPorCuota = row.ToDecimal("MontoPorCuota");
            InteresePorCuota = row.ToDecimal("InteresePorCuota");
            CuotaPendCampaniaActual = row.ToDecimal("CuotaPendCampaniaActual");
            CuotaPendCampaniaSiguiente = row.ToDecimal("CuotaPendCampaniaSiguiente");
            PedidoBase = row.ToDecimal("PedidoBase");
            LineaCredito = row.ToDecimal("LineaCredito");
            MontoMinimoFlexipago = row.ToDecimal("MontoMinimoFlexipago");
        }
    }
}
