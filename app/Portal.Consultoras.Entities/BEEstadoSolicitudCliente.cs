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
            if (DataRecord.HasColumn(row, "EstadoId"))
                EstadoSolicitudClienteID = Convert.ToInt32(row["EstadoId"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Estado"))
                TipoEstado = Convert.ToString(row["Estado"]);
            if (DataRecord.HasColumn(row, "Activo"))
                Activo = Convert.ToBoolean(row["Activo"]);
        }

    }
}
