using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMatrizComercial
    {
        [DataMember]
        [ViewProperty]
        public int PaisID { get; set; }
        [DataMember]
        [ViewProperty]
        public int IdMatrizComercial { get; set; }
        [DataMember]
        public string CodigoSAP { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionOriginal { get; set; }
        [DataMember]
        [ViewProperty]
        public string DescripcionProductoComercial { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto01 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto02 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto03 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto04 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto05 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto06 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto07 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto08 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto09 { get; set; }
        [DataMember]
        [ViewProperty]
        public string FotoProducto10 { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }

        public BEMatrizComercial(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizComercial") && row["IdMatrizComercial"] != DBNull.Value)
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);
            if (DataRecord.HasColumn(row, "CodigoSAP") && row["CodigoSAP"] != DBNull.Value)
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);
            if (DataRecord.HasColumn(row, "DescripcionOriginal") && row["DescripcionOriginal"] != DBNull.Value)
                DescripcionOriginal = Convert.ToString(row["DescripcionOriginal"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "DescripcionProductoComercial") && row["DescripcionProductoComercial"] != DBNull.Value)
                DescripcionProductoComercial = Convert.ToString(row["DescripcionProductoComercial"]);
            if (DataRecord.HasColumn(row, "FotoProducto01") && row["FotoProducto01"] != DBNull.Value)
                FotoProducto01 = Convert.ToString(row["FotoProducto01"]);
            if (DataRecord.HasColumn(row, "FotoProducto02") && row["FotoProducto02"] != DBNull.Value)
                FotoProducto02 = Convert.ToString(row["FotoProducto02"]);
            if (DataRecord.HasColumn(row, "FotoProducto03") && row["FotoProducto03"] != DBNull.Value)
                FotoProducto03 = Convert.ToString(row["FotoProducto03"]);
            if (DataRecord.HasColumn(row, "FotoProducto04") && row["FotoProducto04"] != DBNull.Value)
                FotoProducto04 = Convert.ToString(row["FotoProducto04"]);
            if (DataRecord.HasColumn(row, "FotoProducto05") && row["FotoProducto05"] != DBNull.Value)
                FotoProducto05 = Convert.ToString(row["FotoProducto05"]);
            if (DataRecord.HasColumn(row, "FotoProducto06") && row["FotoProducto06"] != DBNull.Value)
                FotoProducto06 = Convert.ToString(row["FotoProducto06"]);
            if (DataRecord.HasColumn(row, "FotoProducto07") && row["FotoProducto07"] != DBNull.Value)
                FotoProducto07 = Convert.ToString(row["FotoProducto07"]);
            if (DataRecord.HasColumn(row, "FotoProducto08") && row["FotoProducto08"] != DBNull.Value)
                FotoProducto08 = Convert.ToString(row["FotoProducto08"]);
            if (DataRecord.HasColumn(row, "FotoProducto09") && row["FotoProducto09"] != DBNull.Value)
                FotoProducto09 = Convert.ToString(row["FotoProducto09"]);
            if (DataRecord.HasColumn(row, "FotoProducto10") && row["FotoProducto10"] != DBNull.Value)
                FotoProducto10 = Convert.ToString(row["FotoProducto10"]);
        }
    }
}
