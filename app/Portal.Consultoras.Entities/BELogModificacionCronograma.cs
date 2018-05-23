using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigosRegionZona"))
                CodigosRegionZona = Convert.ToString(row["CodigosRegionZona"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronogramaAnterior"))
                DiasDuracionCronogramaAnterior = Convert.ToInt16(row["DiasDuracionCronogramaAnterior"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronogramaActual"))
                DiasDuracionCronogramaActual = Convert.ToInt16(row["DiasDuracionCronogramaActual"]);
        }
    }
}
