using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESolicitudClienteCatalogo
    {
        [DataMember]
        public string Pais { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public string AsuntoNotificacion { get; set; }

        [DataMember]
        public string DetalleNotificacion { get; set; }

        [DataMember]
        public string Campania { get; set; }

        [DataMember]
        public string CorreoCliente { get; set; }

        [DataMember]
        public DateTime FechaIngreso { get; set; }

        public BESolicitudClienteCatalogo() { }

        public BESolicitudClienteCatalogo(IDataRecord row)
        {
            Pais = row.ToString("Pais");
            CodigoConsultora = row.ToString("CodigoConsultora");
            AsuntoNotificacion = row.ToString("AsuntoNotificacion");
            DetalleNotificacion = row.ToString("DetalleNotificacion");
            Campania = row.ToString("Campania");
            CorreoCliente = row.ToString("CorreoCliente");
            FechaIngreso = row.ToDateTime("FechaIngreso");
        }
    }
}
