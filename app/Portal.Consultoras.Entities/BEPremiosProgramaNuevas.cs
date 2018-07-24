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

        public BEPremiosProgramaNuevas(IDataRecord row)
        {
            CodigoPrograma = row.ToString("CodigoPrograma");
            AnioCampana = row.ToInt32("AnoCampana");
            CodigoNivel = row.ToString("CodigoNivel");
            CUV = row.ToString("CUV");
            DescripcionProducto = row.ToString("DescripcionProducto");
            IndicadorActivo = row.ToBoolean("IndicadorActivo");
            IndicadorKitNuevas = row.ToBoolean("IndicadorKitNuevas");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
        }

    }
}
