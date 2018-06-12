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

        public BEProductoProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "CampanaID"))
                CampanaID = Convert.ToInt32(datarec["CampanaID"]);
            if (DataRecord.HasColumn(datarec, "CodigoNivel"))
                CodigoNivel = Convert.ToString(datarec["CodigoNivel"]);
            if (DataRecord.HasColumn(datarec, "CodigoCupon"))
                CodigoCupon = Convert.ToString(datarec["CodigoCupon"]);
            if (DataRecord.HasColumn(datarec, "CodigoVenta"))
                CodigoVenta = Convert.ToString(datarec["CodigoVenta"]);
            if (DataRecord.HasColumn(datarec, "DescripcionProducto"))
                DescripcionProducto = Convert.ToString(datarec["DescripcionProducto"]);
            if (DataRecord.HasColumn(datarec, "UnidadesMaximas"))
                UnidadesMaximas = Convert.ToInt32(datarec["UnidadesMaximas"]);
            if (DataRecord.HasColumn(datarec, "IndicadorKit"))
                IndicadorKit = Convert.ToBoolean(datarec["IndicadorKit"]);
            if (DataRecord.HasColumn(datarec, "IndicadorCuponIndependiente"))
                IndicadorCuponIndependiente = Convert.ToBoolean(datarec["IndicadorCuponIndependiente"]);
            if (DataRecord.HasColumn(datarec, "PrecioUnitario"))
                PrecioUnitario = Convert.ToDecimal(datarec["PrecioUnitario"]);
            if (DataRecord.HasColumn(datarec, "NumeroCampanasVigentes"))
                NumeroCampanasVigentes = Convert.ToInt32(datarec["NumeroCampanasVigentes"]);
        }
    }
}
