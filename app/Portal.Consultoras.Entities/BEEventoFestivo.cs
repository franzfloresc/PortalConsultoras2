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
            if (row.HasColumn("Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (row.HasColumn("Alcance"))
                Alcance = Convert.ToString(row["Alcance"]);
            if (row.HasColumn("Periodo"))
                Periodo = Convert.ToString(row["Periodo"]);
            if (row.HasColumn("Inicio"))
                Inicio = Convert.ToString(row["Inicio"]);
            if (row.HasColumn("Fin"))
                Fin = Convert.ToString(row["Fin"]);
            if (row.HasColumn("Personalizacion"))
                Personalizacion = Convert.ToString(row["Personalizacion"]);
            if (row.HasColumn("Estado"))
                Estado = Convert.ToBoolean(row["Estado"]);
        }

    }
}
