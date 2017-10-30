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
            if (row.HasColumn("Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);
            if (row.HasColumn("Alcance") && row["Alcance"] != DBNull.Value)
                Alcance = Convert.ToString(row["Alcance"]);
            if (row.HasColumn("Periodo") && row["Periodo"] != DBNull.Value)
                Periodo = Convert.ToString(row["Periodo"]);
            if (row.HasColumn("Inicio") && row["Inicio"] != DBNull.Value)
                Inicio = Convert.ToString(row["Inicio"]);
            if (row.HasColumn("Fin") && row["Fin"] != DBNull.Value)
                Fin = Convert.ToString(row["Fin"]);
            if (row.HasColumn("Personalizacion") && row["Personalizacion"] != DBNull.Value)
                Personalizacion = Convert.ToString(row["Personalizacion"]);
            if (row.HasColumn("Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToBoolean(row["Estado"]);
        }

    }
}
