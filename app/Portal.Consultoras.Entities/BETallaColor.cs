using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

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
            if (DataRecord.HasColumn(row, "ID") && row["ID"] != DBNull.Value)
                ID = Convert.ToInt32(row["ID"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = row["CUV"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionCUV") && row["DescripcionCUV"] != DBNull.Value)
                DescripcionCUV = row["DescripcionCUV"].ToString();

            if (DataRecord.HasColumn(row, "PrecioUnitario") && row["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = Convert.ToDecimal( row["PrecioUnitario"].ToString());

            if (DataRecord.HasColumn(row, "Tipo") && row["Tipo"] != DBNull.Value)
                Tipo = row["Tipo"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionTipo") && row["DescripcionTipo"] != DBNull.Value)
                DescripcionTipo = row["DescripcionTipo"].ToString();

            if (DataRecord.HasColumn(row, "DescripcionTallaColor") && row["DescripcionTallaColor"] != DBNull.Value)
                DescripcionTallaColor = row["DescripcionTallaColor"].ToString();

        }

    }
}
