using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogConfiguracionCronograma
    {
        [DataMember]
        public string FechaRegistro { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public int CodigoZona { get; set; }
        [DataMember]
        public int CodigoRegion { get; set; }
        [DataMember]
        public Int16 DiasDuracionAnterior { get; set; }
        [DataMember]
        public Int16 DiasDuracionActual { get; set; }

        public BELogConfiguracionCronograma(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToString(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoRegion") && row["CodigoRegion"] != DBNull.Value)
                CodigoRegion = Convert.ToInt16(row["CodigoRegion"]);
            if (DataRecord.HasColumn(row, "CodigoZona") && row["CodigoZona"] != DBNull.Value)
                CodigoZona = Convert.ToInt16(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "DiasDuracionAnterior") && row["DiasDuracionAnterior"] != DBNull.Value)
                DiasDuracionAnterior = Convert.ToInt16(row["DiasDuracionAnterior"]);
            if (DataRecord.HasColumn(row, "DiasDuracionActual") && row["DiasDuracionActual"] != DBNull.Value)
                DiasDuracionActual = Convert.ToInt16(row["DiasDuracionActual"]);
        }
    }

}
