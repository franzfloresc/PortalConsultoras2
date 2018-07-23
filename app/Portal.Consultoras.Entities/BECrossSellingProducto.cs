using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECrossSellingProducto
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CrossSellingProductoID { get; set; }
        [DataMember]
        public int TipoOfertaSisID { get; set; }
        [DataMember]
        public int ConfiguracionOfertaID { get; set; }
        [DataMember]
        public int NroOrden { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string MensajeProducto { get; set; }
        [DataMember]
        public string ImagenProducto { get; set; }
        [DataMember]
        public string ISOPais { get; set; }
        [DataMember]
        public int FlagHabilitarProducto { get; set; }
        [DataMember]
        public string CodigoProducto { get; set; }
        [DataMember]
        public string CodigoTipoOferta { get; set; }
        [DataMember]
        public string MarcaID { get; set; }
        [DataMember]
        public int SubTipoOfertaSisID { get; set; }
        [DataMember]
        public string EtiquetaPrecio { get; set; }

        public BECrossSellingProducto(IDataRecord row)
        {
            CrossSellingProductoID = row.ToInt32("CrossSellingProductoID");
            NroOrden = row.ToInt32("NroOrden");
            CampaniaID = row.ToInt32("CampaniaID");
            CodigoCampania = row.ToString("CodigoCampania");
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            PrecioOferta = row.ToDecimal("PrecioOferta");
            ImagenProducto = row.ToString("ImagenProducto");
            FlagHabilitarProducto = row.ToInt32("FlagHabilitarProducto");
            ConfiguracionOfertaID = row.ToInt32("ConfiguracionOfertaID");
            TipoOfertaSisID = row.ToInt32("TipoOfertaSisID");
            MensajeProducto = row.ToString("MensajeProducto");
            CodigoProducto = row.ToString("CodigoProducto");
            CodigoTipoOferta = row.ToString("CodigoTipoOferta");
            MarcaID = row.ToString("MarcaID");
            SubTipoOfertaSisID = row.ToInt32("SubTipoOfertaSisID");
            EtiquetaPrecio = row.ToString("EtiquetaPrecio", string.Empty);
        }
    }
}
