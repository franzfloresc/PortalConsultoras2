using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraSolicitudCliente
    {
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public string MarcaNombre { get; set; }

        public BEConsultoraSolicitudCliente()
        {

        }

        public BEConsultoraSolicitudCliente(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);

            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]);

            if (DataRecord.HasColumn(row, "CodigoISO"))
                CodigoISO = Convert.ToString(row["CodigoISO"]);

            if (DataRecord.HasColumn(row, "MarcaNombre"))
                MarcaNombre = Convert.ToString(row["MarcaNombre"]);
        }
    }
}
