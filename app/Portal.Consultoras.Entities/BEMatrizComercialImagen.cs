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
        public int IdMatrizComercial { get; set; }

        [DataMember]
        public string Foto { get; set; }

        [DataMember]
        public string UsuarioRegistro { get; set; }

        [DataMember]
        public DateTime? FechaRegistro { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string NemoTecnico { get; set; }

        [DataMember]
        public int TotalRegistros { get; set; }

        public BEMatrizComercialImagen(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizComercialImagen") && row["IdMatrizComercialImagen"] != DBNull.Value)
                IdMatrizComercialImagen = Convert.ToInt32(row["IdMatrizComercialImagen"]);
            if (DataRecord.HasColumn(row, "IdMatrizComercial") && row["IdMatrizComercial"] != DBNull.Value)
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);
            if (DataRecord.HasColumn(row, "Foto") && row["Foto"] != DBNull.Value)
                Foto = Convert.ToString(row["Foto"]);
            if (DataRecord.HasColumn(row, "NemoTecnico") && row["NemoTecnico"] != DBNull.Value)
                NemoTecnico = Convert.ToString(row["NemoTecnico"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "TotalRegistros") && row["TotalRegistros"] != DBNull.Value)
                TotalRegistros = Convert.ToInt32(row["TotalRegistros"]);            
        }
    }
}
