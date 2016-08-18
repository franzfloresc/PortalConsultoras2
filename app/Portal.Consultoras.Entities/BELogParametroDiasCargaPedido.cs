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
            if (DataRecord.HasColumn(row, "Fecha") && row["Fecha"] != DBNull.Value)
                Fecha = Convert.ToString(row["Fecha"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigosRegionZona") && row["CodigosRegionZona"] != DBNull.Value)
                CodigosRegionZona = Convert.ToString(row["CodigosRegionZona"]);
            if (DataRecord.HasColumn(row, "DiasParametroCargaAnterior") && row["DiasParametroCargaAnterior"] != DBNull.Value)
                DiasParametroCargaAnterior = Convert.ToInt16(row["DiasParametroCargaAnterior"]);
            if (DataRecord.HasColumn(row, "DiasParametroCargaActual") && row["DiasParametroCargaActual"] != DBNull.Value)
                DiasParametroCargaActual = Convert.ToInt16(row["DiasParametroCargaActual"]);
        }
    }
}
