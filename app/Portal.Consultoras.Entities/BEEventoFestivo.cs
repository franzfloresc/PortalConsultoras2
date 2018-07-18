using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEventoFestivo
    {
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Alcance { get; set; }
        [DataMember]
        public string Periodo { get; set; }
        [DataMember]
        public string Inicio { get; set; }
        [DataMember]
        public string Fin { get; set; }
        [DataMember]
        public string Personalizacion { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEEventoFestivo()
        {
        }

        public BEEventoFestivo(IDataRecord row)
        {
            Nombre = row.ToString("Nombre");
            Alcance = row.ToString("Alcance");
            Periodo = row.ToString("Periodo");
            Inicio = row.ToString("Inicio");
            Fin = row.ToString("Fin");
            Personalizacion = row.ToString("Personalizacion");
            Estado = row.ToBoolean("Estado");
        }

    }
}
