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
    public class BEConsultoraFicticia
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoConsultoraFicticia { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string SegundoNombre { get; set; }
        [DataMember]
        public string PrimerApellido { get; set; }
        [DataMember]
        public string SegundoApellido { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string ActualizarClave { get; set; }
        [DataMember]
        public string ConfirmarClave { get; set; }
        [DataMember]
        public string PaisNombre { get; set; }
        [DataMember]
        public string ZonaNombre { get; set; }
        [DataMember]
        public Int64 ConsultoraID { get; set; }

        public BEConsultoraFicticia()
        {
        }

        public BEConsultoraFicticia(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "CodigoConsultoraFicticia") && row["CodigoConsultoraFicticia"] != DBNull.Value)
                CodigoConsultoraFicticia = Convert.ToString(row["CodigoConsultoraFicticia"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "SegundoNombre") && row["SegundoNombre"] != DBNull.Value)
                SegundoNombre = Convert.ToString(row["SegundoNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido") && row["PrimerApellido"] != DBNull.Value)
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "SegundoApellido") && row["SegundoApellido"] != DBNull.Value)
                SegundoApellido = Convert.ToString(row["SegundoApellido"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "PaisNombre") && row["PaisNombre"] != DBNull.Value)
                PaisNombre = Convert.ToString(row["PaisNombre"]);
            if (DataRecord.HasColumn(row, "ZonaNombre") && row["ZonaNombre"] != DBNull.Value)
                ZonaNombre = Convert.ToString(row["ZonaNombre"]);
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
        }
    }
}
