using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicio
    {
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Url { get; set; }
        [DataMember]
        public bool PaginaNueva { get; set; }
        [DataMember]
        public string PaginaNuevaDescripcion { get; set; }

        public BEServicio()
        {
        }

        public BEServicio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ServicioId"))
                ServicioId = Convert.ToInt32(row["ServicioId"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Url"))
                Url = Convert.ToString(row["Url"]);
            if (DataRecord.HasColumn(row, "PaginaNueva"))
                PaginaNueva = Convert.ToBoolean(row["PaginaNueva"]);
            if (DataRecord.HasColumn(row, "PaginaNuevaDescripcion"))
                PaginaNuevaDescripcion = Convert.ToString(row["PaginaNuevaDescripcion"]);
        }
    }
}
