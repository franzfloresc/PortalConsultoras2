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
    public class BEPremiosProgramaNuevas : BaseEntidad
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int AnioCampana { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public bool IndicadorActivo { get; set; }
        [DataMember]
        public bool IndicadorKitNuevas { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }

        public BEPremiosProgramaNuevas()
        {
            CodigoPrograma = default(string);
            AnioCampana = default(int);
            CodigoNivel = default(string);
            CUV = default(string);
            DescripcionProducto = default(string);
            IndicadorActivo = default(bool);
            IndicadorKitNuevas = default(bool);
            PrecioUnitario = default(decimal);
        }

        public BEPremiosProgramaNuevas(IDataRecord dr)
        {
            if (DataRecord.HasColumn(dr, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(dr["CodigoPrograma"]);

            if (DataRecord.HasColumn(dr, "AnoCampana"))
                AnioCampana = Convert.ToInt32(dr["AnoCampana"]);

            if (DataRecord.HasColumn(dr, "CodigoNivel"))
                CodigoNivel = Convert.ToString(dr["CodigoNivel"]);

            if (DataRecord.HasColumn(dr, "CUV"))
                CUV = Convert.ToString(dr["CUV"]);

            if (DataRecord.HasColumn(dr, "DescripcionProducto"))
                DescripcionProducto = Convert.ToString(dr["DescripcionProducto"]);

            if (DataRecord.HasColumn(dr, "IndicadorActivo"))
                IndicadorActivo = Convert.ToBoolean(dr["IndicadorActivo"]);

            if (DataRecord.HasColumn(dr, "IndicadorKitNuevas"))
                IndicadorKitNuevas = Convert.ToBoolean(dr["IndicadorKitNuevas"]);

            if (DataRecord.HasColumn(dr, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(dr["PrecioUnitario"]);
        }

    }
}
