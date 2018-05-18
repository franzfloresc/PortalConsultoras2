using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToString(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoRegion"))
                CodigoRegion = Convert.ToInt16(row["CodigoRegion"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToInt16(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "DiasDuracionAnterior"))
                DiasDuracionAnterior = Convert.ToInt16(row["DiasDuracionAnterior"]);
            if (DataRecord.HasColumn(row, "DiasDuracionActual"))
                DiasDuracionActual = Convert.ToInt16(row["DiasDuracionActual"]);
        }
    }

}
