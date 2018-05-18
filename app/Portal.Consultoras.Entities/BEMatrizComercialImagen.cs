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
        public string DescripcionComercial { get; set; }

        [DataMember]
        public int TotalRegistros { get; set; }

        public BEMatrizComercialImagen(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdMatrizComercialImagen"))
                IdMatrizComercialImagen = Convert.ToInt32(row["IdMatrizComercialImagen"]);
            if (DataRecord.HasColumn(row, "IdMatrizComercial"))
                IdMatrizComercial = Convert.ToInt32(row["IdMatrizComercial"]);
            if (DataRecord.HasColumn(row, "Foto"))
                Foto = Convert.ToString(row["Foto"]);
            if (DataRecord.HasColumn(row, "NemoTecnico"))
                NemoTecnico = Convert.ToString(row["NemoTecnico"]);
            if (DataRecord.HasColumn(row, "DescripcionComercial"))
                DescripcionComercial = Convert.ToString(row["DescripcionComercial"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "TotalRegistros"))
                TotalRegistros = Convert.ToInt32(row["TotalRegistros"]);
        }
    }
}
