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
            this.CodigoPrograma = default(string);
            this.AnioCampana = default(int);
            this.CodigoNivel = default(string);
            this.CUV = default(string);
            this.DescripcionProducto = default(string);
            this.IndicadorActivo = default(bool);
            this.IndicadorKitNuevas = default(bool);
            this.PrecioUnitario = default(decimal);
        }

        public BEPremiosProgramaNuevas(IDataRecord dr)
        {
            if (DataRecord.HasColumn(dr, "CodigoPrograma") && dr["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = Convert.ToString(dr["CodigoPrograma"]);

            if (DataRecord.HasColumn(dr, "AnoCampana") && dr["AnoCampana"] != DBNull.Value)
                AnioCampana = Convert.ToInt32(dr["AnoCampana"]);

            if (DataRecord.HasColumn(dr, "CodigoNivel") && dr["CodigoNivel"] != DBNull.Value)
                CodigoNivel = Convert.ToString(dr["CodigoNivel"]);

            if (DataRecord.HasColumn(dr, "CUV") && dr["CUV"] != DBNull.Value)
                CUV = Convert.ToString(dr["CUV"]);

            if (DataRecord.HasColumn(dr, "DescripcionProducto") && dr["DescripcionProducto"] != DBNull.Value)
                DescripcionProducto = Convert.ToString(dr["DescripcionProducto"]);

            if (DataRecord.HasColumn(dr, "IndicadorActivo") && dr["IndicadorActivo"] != DBNull.Value)
                IndicadorActivo = Convert.ToBoolean(dr["IndicadorActivo"]);

            if (DataRecord.HasColumn(dr, "IndicadorKitNuevas") && dr["IndicadorKitNuevas"] != DBNull.Value)
                IndicadorKitNuevas = Convert.ToBoolean(dr["IndicadorKitNuevas"]);

            if (DataRecord.HasColumn(dr, "PrecioUnitario") && dr["PrecioUnitario"] != DBNull.Value)
                PrecioUnitario = Convert.ToDecimal(dr["PrecioUnitario"]);
        }

    }
}
