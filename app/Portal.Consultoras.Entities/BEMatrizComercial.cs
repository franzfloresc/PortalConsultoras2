using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
            if (DataRecord.HasColumn(row, "FotoProducto01") && row["FotoProducto01"] != DBNull.Value)
                FotoProducto01 = Convert.ToString(row["FotoProducto01"]);
            if (DataRecord.HasColumn(row, "FotoProducto02") && row["FotoProducto02"] != DBNull.Value)
                FotoProducto02 = Convert.ToString(row["FotoProducto02"]);
            if (DataRecord.HasColumn(row, "FotoProducto03") && row["FotoProducto03"] != DBNull.Value)
                FotoProducto03 = Convert.ToString(row["FotoProducto03"]);
        }
    }
}
