using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEFechaNoHabilFacturacion
    {
        [DataMember]
        public string CodigoZona { set; get; }
        [DataMember]
        public DateTime Fecha { set; get; }

        public BEFechaNoHabilFacturacion()
        { }

        public BEFechaNoHabilFacturacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToDateTime(row["Fecha"]);
        }
    }
}
