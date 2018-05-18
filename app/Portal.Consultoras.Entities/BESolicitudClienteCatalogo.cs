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
            if (DataRecord.HasColumn(row, "Pais"))
                Pais = Convert.ToString(row["Pais"]);

            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "AsuntoNotificacion"))
                AsuntoNotificacion = Convert.ToString(row["AsuntoNotificacion"]);

            if (DataRecord.HasColumn(row, "DetalleNotificacion"))
                DetalleNotificacion = Convert.ToString(row["DetalleNotificacion"]);

            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);

            if (DataRecord.HasColumn(row, "CorreoCliente"))
                CorreoCliente = Convert.ToString(row["CorreoCliente"]);

            if (DataRecord.HasColumn(row, "FechaIngreso"))
                FechaIngreso = Convert.ToDateTime((row["FechaIngreso"]).ToString());
        }
    }
}
