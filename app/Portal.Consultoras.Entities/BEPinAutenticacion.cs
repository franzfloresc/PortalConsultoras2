using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPinAutenticacion
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Celular { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public string OpcionCorreoActiva { get; set; }
        [DataMember]
        public string OpcionSmsActiva { get; set; }
        [DataMember]
        public int HoraRestanteCorreo { get; set; }
        [DataMember]
        public int HoraRestanteSms { get; set; }


        public BEPinAutenticacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
        }
    }
}
