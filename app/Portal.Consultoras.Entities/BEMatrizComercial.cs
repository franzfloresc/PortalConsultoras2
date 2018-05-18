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
        [DataMember]
        [ViewProperty]
        public string FotoProducto { get; set; }

        [DataMember]
        public string FotoProducto01 { get; set; }
        [DataMember]
        public string FotoProducto02 { get; set; }
        [DataMember]
        public string FotoProducto03 { get; set; }

        public BEMatrizComercial(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizComercial"))
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);
            if (DataRecord.HasColumn(row, "CodigoSAP"))
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);
            if (DataRecord.HasColumn(row, "DescripcionOriginal"))
                DescripcionOriginal = Convert.ToString(row["DescripcionOriginal"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "DescripcionProductoComercial"))
                DescripcionProductoComercial = Convert.ToString(row["DescripcionProductoComercial"]);
            if (DataRecord.HasColumn(row, "DescripcionProductoComercial"))
                DescripcionProductoComercial = Convert.ToString(row["DescripcionProductoComercial"]);
            if (DataRecord.HasColumn(row, "FotoProducto"))
                FotoProducto = Convert.ToString(row["FotoProducto"]);
        }
    }
}
