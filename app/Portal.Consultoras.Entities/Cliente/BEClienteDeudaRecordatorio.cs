using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    [DataContract]
    public class BEClienteDeudaRecordatorio
    {
        [DataMember]
        public short ClienteID { get; set; }

        [DataMember]
        public decimal TotalDeuda { get; set; }

        [DataMember]
        public int ClienteRecordatorioId { get; set; }

        [DataMember]
        public DateTime Fecha { get; set; }

        public BEClienteDeudaRecordatorio()
        { }

        public BEClienteDeudaRecordatorio(IDataRecord row)
        {
            if (row.HasColumn("ClienteID"))
                ClienteID = row.GetValue<short>("ClienteID");

            if (row.HasColumn("TotalDeuda"))
                TotalDeuda = row.GetValue<decimal>("TotalDeuda");

            if (row.HasColumn("ClienteRecordatorioId"))
                ClienteRecordatorioId = row.GetValue<int>("ClienteRecordatorioId");

            if (row.HasColumn("Fecha"))
                Fecha = row.GetValue<DateTime>("Fecha");
        }
    }
}
