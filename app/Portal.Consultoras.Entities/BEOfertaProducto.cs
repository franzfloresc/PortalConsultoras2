using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaProducto
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
        public string PrecioString { get; set; }
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
        public int ID { get; set; }
        [DataMember]
        [ViewProperty]
        public int IDAux { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionCUV { get; set; }
        [DataMember]
        [ViewProperty]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        [ViewProperty]
        public string Tipo { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionTipo { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionTallaColor { get; set; }
        [DataMember]
        [ViewProperty]
        public string CUVPadre { get; set; }
        [DataMember]
        [ViewProperty]
        public string TallaColor { get; set; }
        [DataMember]
        [ViewProperty]
        public int ConsultoraID { get; set; }

        [DataMember]
        [ViewProperty]
        public string DescripcionMarca { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionEstrategia { get; set; }

        [DataMember]
        [ViewProperty]
        public string ImagenProductoSmall { get; set; }

        [DataMember]
        [ViewProperty]
        public string ImagenProductoMedium { get; set; }

        public BEOfertaProducto(IDataRecord row)
        {
            OfertaProductoID = row.ToInt32("OfertaProductoID");
            NroOrden = row.ToInt32("NroOrden");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoCampania = row.ToString("CodigoCampania");
            CUV = row.ToString("CUV");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            TipoOferta = row.ToString("TipoOferta");
            Descripcion = row.ToString("Descripcion");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            Stock = row.ToInt32("Stock");
            ImagenProducto = row.ToString("ImagenProducto");
            UnidadesPermitidas = row.ToInt32("UnidadesPermitidas");
            FlagHabilitarProducto = row.ToInt32("FlagHabilitarProducto");
            Orden = row.ToInt32("Orden");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            CodigoProducto = row.ToString("CodigoProducto");
            DescripcionLegal = row.ToString("DescripcionLegal");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            MarcaID = row.ToInt32("MarcaID");
            StockInicial = row.ToInt32("StockInicial");
            ID = row.ToInt32("ID");
            CUV = row.ToString("CUV");
            DescripcionCUV = row.ToString("DescripcionCUV");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            Tipo = row.ToString("Tipo");
            DescripcionTipo = row.ToString("DescripcionTipo");
            DescripcionTallaColor = row.ToString("DescripcionTallaColor");
            TallaColor = row.ToString("TallaColor");
            DescripcionMarca = row.ToString("DescripcionMarca");
            DescripcionCategoria = row.ToString("DescripcionCategoria");
            DescripcionEstrategia = row.ToString("DescripcionEstrategia");
        }
        public BEOfertaProducto()
        { }
    }
}
