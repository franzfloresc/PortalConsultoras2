using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;


namespace Portal.Consultoras.Entities
{
    /// <summary>
    /// /*R2613-LR*/
    /// </summary>
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
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);

            if (DataRecord.HasColumn(row, "Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);

            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "Email") && row["Email"] != DBNull.Value)
                Email = Convert.ToString(row["Email"]);

            if (DataRecord.HasColumn(row, "CodigoISO") && row["CodigoISO"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["CodigoISO"]);

            if (DataRecord.HasColumn(row, "MarcaNombre") && row["MarcaNombre"] != DBNull.Value)
                MarcaNombre = Convert.ToString(row["MarcaNombre"]);
        }
    }
}
