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
        }
    }
}
