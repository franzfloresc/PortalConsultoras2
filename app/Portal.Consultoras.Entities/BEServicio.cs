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
            ServicioId = row.ToInt32("ServicioId");
            Descripcion = row.ToString("Descripcion");
            Url = row.ToString("Url");
            PaginaNueva = row.ToBoolean("PaginaNueva");
            PaginaNuevaDescripcion = row.ToString("PaginaNuevaDescripcion");
        }
    }
}
