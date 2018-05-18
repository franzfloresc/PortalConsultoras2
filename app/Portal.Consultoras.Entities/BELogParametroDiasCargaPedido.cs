using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogParametroDiasCargaPedido
    {
        [DataMember]
        public string Fecha { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string CodigosRegionZona { get; set; }
        [DataMember]
        public Int16 DiasParametroCargaAnterior { get; set; }
        [DataMember]
        public Int16 DiasParametroCargaActual { get; set; }

        public BELogParametroDiasCargaPedido(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Fecha"))
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigosRegionZona"))
                CodigosRegionZona = Convert.ToString(row["CodigosRegionZona"]);
            if (DataRecord.HasColumn(row, "DiasParametroCargaAnterior"))
                DiasParametroCargaAnterior = Convert.ToInt16(row["DiasParametroCargaAnterior"]);
            if (DataRecord.HasColumn(row, "DiasParametroCargaActual"))
                DiasParametroCargaActual = Convert.ToInt16(row["DiasParametroCargaActual"]);
        }
    }
}
