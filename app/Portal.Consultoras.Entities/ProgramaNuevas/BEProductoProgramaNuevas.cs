using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEProductoProgramaNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int CampanaID { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string CodigoCupon { get; set; }
        [DataMember]
        public string CodigoVenta { get; set; }
        [DataMember]
        public string DescripcionProducto { get; set; }
        [DataMember]
        public int UnidadesMaximas { get; set; }
        [DataMember]
        public bool IndicadorKit { get; set; }
        [DataMember]
        public bool IndicadorCuponIndependiente { get; set; }
        [DataMember]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        public int NumeroCampanasVigentes { get; set; }

        public BEProductoProgramaNuevas(IDataRecord row)
        {
            CodigoPrograma = row.ToString("CodigoPrograma");
            CampanaID = row.ToInt32("CampanaID");
            CodigoNivel = row.ToString("CodigoNivel");
            CodigoCupon = row.ToString("CodigoCupon");
            CodigoVenta = row.ToString("CodigoVenta");
            DescripcionProducto = row.ToString("DescripcionProducto");
            UnidadesMaximas = row.ToInt32("UnidadesMaximas");
            IndicadorKit = row.ToBoolean("IndicadorKit");
            IndicadorCuponIndependiente = row.ToBoolean("IndicadorCuponIndependiente");
            PrecioUnitario = row.ToDecimal("PrecioUnitario");
            NumeroCampanasVigentes = row.ToInt32("NumeroCampanasVigentes");
        }
    }
}
