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
    public class BEClienteNotificacion
    {
        private int clienteNotificacionId;
        private int clienteId;
        private string descripcion;
        private DateTime fecha;
        private long consultoraId;

        [DataMember]
        public int ClienteNotificacionId
        {
            get { return clienteNotificacionId; }
            set { clienteNotificacionId = value; }
        }
                
        [DataMember]
        public int ClienteId
        {
            get { return clienteId; }
            set { clienteId = value; }
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

        public BEClienteNotificacion(IDataRecord datarec)
        {
            if (datarec.HasColumn("ClienteNotificacionId"))
                clienteNotificacionId = datarec.GetValue<int>("ClienteNotificacionId");

            if (datarec.HasColumn("ClienteId"))
                clienteId = datarec.GetValue<int>("ClienteId");

            if (datarec.HasColumn("Descripcion"))
                descripcion = datarec.GetValue<string>("Descripcion");

            if (datarec.HasColumn("Fecha"))
                fecha = datarec.GetValue<DateTime>("Fecha");

            if (datarec.HasColumn("ConsultoraId"))
                consultoraId = datarec.GetValue<long>("ConsultoraId");
        }
    }
}
