using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEClienteRecordatorio
    {
        private int clienteRecordatorioId;
        private long codigoCliente;
        private string descripcion;
        private DateTime fecha;
        private long consultoraId;

        [DataMember]
        public int ClienteRecordatorioId
        {
            get { return clienteRecordatorioId; }
            set { clienteRecordatorioId = value; }
        }

        [DataMember]
        public long CodigoCliente
        {
            get { return codigoCliente; }
            set { codigoCliente = value; }
        }

        [DataMember]
        public string Descripcion
        {
            get { return descripcion; }
            set { descripcion = value; }
        }

        [DataMember]
        public DateTime Fecha
        {
            get { return fecha; }
            set { fecha = value; }
        }

        [DataMember]
        public long ConsultoraId
        {
            get { return consultoraId; }
            set { consultoraId = value; }
        }

        public BEClienteRecordatorio()
        { }

        /// <summary>
        /// Inicializa el objeto a partir del DataRecord
        /// </summary>
        /// <param name="datarec"></param>
        public BEClienteRecordatorio(IDataRecord datarec)
        {
            if (datarec.HasColumn("ClienteRecordatorioId"))
                clienteRecordatorioId = datarec.GetValue<int>("ClienteRecordatorioId");

            if (datarec.HasColumn("CodigoCliente"))
                codigoCliente = datarec.GetValue<long>("CodigoCliente");

            if (datarec.HasColumn("Descripcion"))
                descripcion = datarec.GetValue<string>("Descripcion");

            if (datarec.HasColumn("Fecha"))
                fecha = datarec.GetValue<DateTime>("Fecha");

            if (datarec.HasColumn("ConsultoraId"))
                consultoraId = datarec.GetValue<long>("ConsultoraId");
        }
    }
}
