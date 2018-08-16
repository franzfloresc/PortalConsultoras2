using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Framework;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    [DataContract]
    public class BEClienteRecordatorio
    {
        [DataMember]
        public int ClienteRecordatorioId { get; set; }

        [DataMember]
        public short ClienteId { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public DateTime Fecha { get; set; }

        [DataMember]
        public long ConsultoraId { get; set; }

        [DataMember]
        public string Code { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public StatusEnum StatusEnum { get; set; }

        public BEClienteRecordatorio()
        { }

        /// <summary>
        /// Inicializa el objeto a partir del DataRecord
        /// </summary>
        /// <param name="row"></param>
        public BEClienteRecordatorio(IDataRecord row)
        {
                ClienteRecordatorioId = row.GetColumn<int>("ClienteRecordatorioId");

                ClienteId = row.GetColumn<short>("ClienteId");

                Descripcion = row.GetColumn<string>("Descripcion");

                Fecha = row.GetColumn<DateTime>("Fecha");

                ConsultoraId = row.GetColumn<long>("ConsultoraId");
        }
    }
}
