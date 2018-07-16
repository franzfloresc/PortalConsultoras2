using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETallaColor
    {
        public BETallaColor()
        {
            this.IDAux = 0;
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public int IDAux { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionCUV { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string DescripcionTipo { get; set; }
        [DataMember]
        public string DescripcionTallaColor { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BETallaColor(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ID"))
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "DescripcionCUV"))
                DescripcionCUV = Convert.ToString(row["DescripcionCUV"]);

            if (DataRecord.HasColumn(row, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(row["PrecioUnitario"]);

            if (DataRecord.HasColumn(row, "Tipo"))
                Tipo = Convert.ToString(row["Tipo"]);

            if (DataRecord.HasColumn(row, "DescripcionTipo"))
                DescripcionTipo = Convert.ToString(row["DescripcionTipo"]);

            if (DataRecord.HasColumn(row, "DescripcionTallaColor"))
                DescripcionTallaColor = Convert.ToString(row["DescripcionTallaColor"]);

        }

    }
}
