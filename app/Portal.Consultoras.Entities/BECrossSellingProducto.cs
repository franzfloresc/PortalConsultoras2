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
            if (DataRecord.HasColumn(row, "CrossSellingProductoID"))
                CrossSellingProductoID = Convert.ToInt32(row["CrossSellingProductoID"]);
            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "ImagenProducto"))
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto"))
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID"))
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID"))
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MensajeProducto"))
                MensajeProducto = Convert.ToString(row["MensajeProducto"]);
            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToString(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID"))
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);

            if (DataRecord.HasColumn(row, "EtiquetaPrecio"))
                EtiquetaPrecio = Convert.ToString(row["EtiquetaPrecio"]);
            else
                EtiquetaPrecio = string.Empty;
        }
    }
}
