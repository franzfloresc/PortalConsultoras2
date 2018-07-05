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
        /// <param name="datarec"></param>
        public BEClienteRecordatorio(IDataRecord datarec)
        {
            if (datarec.HasColumn("ClienteRecordatorioId"))
                ClienteRecordatorioId = datarec.GetValue<int>("ClienteRecordatorioId");

            if (datarec.HasColumn("ClienteId"))
                ClienteId = datarec.GetValue<short>("ClienteId");

            if (datarec.HasColumn("Descripcion"))
                Descripcion = datarec.GetValue<string>("Descripcion");

            if (datarec.HasColumn("Fecha"))
                Fecha = datarec.GetValue<DateTime>("Fecha");

            if (datarec.HasColumn("ConsultoraId"))
                ConsultoraId = datarec.GetValue<long>("ConsultoraId");
        }
    }
}
