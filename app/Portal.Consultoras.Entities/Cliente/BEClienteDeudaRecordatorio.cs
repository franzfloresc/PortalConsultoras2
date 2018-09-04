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
                ClienteID = row.GetColumn<short>("ClienteID");

                TotalDeuda = row.GetColumn<decimal>("TotalDeuda");

                ClienteRecordatorioId = row.GetColumn<int>("ClienteRecordatorioId");

                Fecha = row.GetColumn<DateTime>("Fecha");
        }
    }
}
