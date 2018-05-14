using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "CodigoConsultoraFicticia"))
                CodigoConsultoraFicticia = Convert.ToString(row["CodigoConsultoraFicticia"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "SegundoNombre"))
                SegundoNombre = Convert.ToString(row["SegundoNombre"]);
            if (DataRecord.HasColumn(row, "PrimerApellido"))
                PrimerApellido = Convert.ToString(row["PrimerApellido"]);
            if (DataRecord.HasColumn(row, "SegundoApellido"))
                SegundoApellido = Convert.ToString(row["SegundoApellido"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "PaisNombre"))
                PaisNombre = Convert.ToString(row["PaisNombre"]);
            if (DataRecord.HasColumn(row, "ZonaNombre"))
                ZonaNombre = Convert.ToString(row["ZonaNombre"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
        }
    }
}
