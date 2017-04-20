using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMatrizComercialImagen
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int IdMatrizComercialImagen { get; set; }

        [DataMember]
        public string CodigoSAP { get; set; }

        [DataMember]
        public string Foto { get; set; }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public DateTime? FechaRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BEMatrizComercialImagen(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizComercialImagen") && row["IdMatrizComercialImagen"] != DBNull.Value)
                IdMatrizComercialImagen = Convert.ToInt32(row["IdMatrizComercialImagen"]);
            if (DataRecord.HasColumn(row, "CodigoSAP") && row["CodigoSAP"] != DBNull.Value)
                CodigoSAP = Convert.ToString(row["CodigoSAP"]);
            if (DataRecord.HasColumn(row, "Foto") && row["Foto"] != DBNull.Value)
                Foto = Convert.ToString(row["Foto"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
        }
    }
}
