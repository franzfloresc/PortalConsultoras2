using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEventoFestivo
    {
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string Alcanse { get; set; }
        [DataMember]
        public string Periodo { get; set; }
        [DataMember]
        public string Inicio { get; set; }
        [DataMember]
        public string Fin { get; set; }
        [DataMember]
        public string Perzonalizacion { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEEventoFestivo()
        {
        }

        public BEEventoFestivo(IDataRecord row)
        {
            if (row.HasColumn("Nombre") && row["Nombre"] != DBNull.Value)
                Nombre = Convert.ToString(row["Nombre"]);
            if (row.HasColumn("Alcanse") && row["Alcanse"] != DBNull.Value)
                Alcanse = Convert.ToString(row["Alcanse"]);
            if (row.HasColumn("Periodo") && row["Periodo"] != DBNull.Value)
                Periodo = Convert.ToString(row["Periodo"]);
            if (row.HasColumn("Inicio") && row["Inicio"] != DBNull.Value)
                Inicio = Convert.ToString(row["Inicio"]);
            if (row.HasColumn("Fin") && row["Fin"] != DBNull.Value)
                Fin = Convert.ToString(row["Fin"]);
            if (row.HasColumn("Perzonalizacion") && row["Perzonalizacion"] != DBNull.Value)
                Perzonalizacion = Convert.ToString(row["Perzonalizacion"]);
            if (row.HasColumn("Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToBoolean(row["Estado"]);
        }

    }
}
