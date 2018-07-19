using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstadoSolicitudCliente
    {
        [DataMember]
        private int EstadoSolicitudClienteID { get; set; }
        [DataMember]
        private string Descripcion { get; set; }
        [DataMember]
        private string TipoEstado { get; set; }
        [DataMember]
        private bool Activo { get; set; }

        public BEEstadoSolicitudCliente(IDataRecord row)
        {
            EstadoSolicitudClienteID = row.ToInt32("EstadoId");
            Descripcion = row.ToString("Descripcion");
            TipoEstado = row.ToString("Estado");
            Activo = row.ToBoolean("Activo");
        }

    }
}
