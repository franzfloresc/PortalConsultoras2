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
            if (DataRecord.HasColumn(row, "CrossSellingProductoID") && row["CrossSellingProductoID"] != DBNull.Value)
                CrossSellingProductoID = Convert.ToInt32(row["CrossSellingProductoID"]);
            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoCampania") && row["CodigoCampania"] != DBNull.Value)
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "ImagenProducto") && row["ImagenProducto"] != DBNull.Value)
                ImagenProducto = Convert.ToString(row["ImagenProducto"]);
            if (DataRecord.HasColumn(row, "FlagHabilitarProducto") && row["FlagHabilitarProducto"] != DBNull.Value)
                FlagHabilitarProducto = Convert.ToInt32(row["FlagHabilitarProducto"]);
            if (DataRecord.HasColumn(row, "ConfiguracionOfertaID") && row["ConfiguracionOfertaID"] != DBNull.Value)
                ConfiguracionOfertaID = Convert.ToInt32(row["ConfiguracionOfertaID"]);
            if (DataRecord.HasColumn(row, "TipoOfertaSisID") && row["TipoOfertaSisID"] != DBNull.Value)
                TipoOfertaSisID = Convert.ToInt32(row["TipoOfertaSisID"]);
            if (DataRecord.HasColumn(row, "MensajeProducto") && row["MensajeProducto"] != DBNull.Value)
                MensajeProducto = Convert.ToString(row["MensajeProducto"]);
            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            if (DataRecord.HasColumn(row, "MarcaID") && row["MarcaID"] != DBNull.Value)
                MarcaID = Convert.ToString(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "SubTipoOfertaSisID") && row["SubTipoOfertaSisID"] != DBNull.Value)
                SubTipoOfertaSisID = Convert.ToInt32(row["SubTipoOfertaSisID"]);

            if (DataRecord.HasColumn(row, "EtiquetaPrecio") && row["EtiquetaPrecio"] != DBNull.Value)
                EtiquetaPrecio = Convert.ToString(row["EtiquetaPrecio"]);
            else
                EtiquetaPrecio = string.Empty;
        }
    }
}
