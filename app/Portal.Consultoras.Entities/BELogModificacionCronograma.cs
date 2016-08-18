using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogModificacionCronograma
    {
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigosRegionZona { get; set; }
        [DataMember]
        public Int16 DiasDuracionCronogramaAnterior { get; set; }
        [DataMember]
        public Int16 DiasDuracionCronogramaActual { get; set; }

        public BELogModificacionCronograma(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Fecha") && row["Fecha"] != DBNull.Value)
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigosRegionZona") && row["CodigosRegionZona"] != DBNull.Value)
                CodigosRegionZona = Convert.ToString(row["CodigosRegionZona"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronogramaAnterior") && row["DiasDuracionCronogramaAnterior"] != DBNull.Value)
                DiasDuracionCronogramaAnterior = Convert.ToInt16(row["DiasDuracionCronogramaAnterior"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronogramaActual") && row["DiasDuracionCronogramaActual"] != DBNull.Value)
                DiasDuracionCronogramaActual = Convert.ToInt16(row["DiasDuracionCronogramaActual"]);
        }
    }
}
