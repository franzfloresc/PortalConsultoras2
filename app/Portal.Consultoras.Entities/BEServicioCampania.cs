using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicioCampania
    {
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Url { get; set; }
        //RQ_PBS - R2161
        [DataMember]
        public string Segmento { get; set; }
        //RQ_PBS - R2161
        [DataMember]
        public string ConfiguracionZona { get; set; }

        public BEServicioCampania() { }
        public BEServicioCampania(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ServicioId") && row["ServicioId"] != DBNull.Value)
                ServicioId = Convert.ToInt32(row["ServicioId"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Url") && row["Url"] != DBNull.Value)
                Url = Convert.ToString(row["Url"]);
            //RQ_PBS - R2161
            if (DataRecord.HasColumn(row, "Segmento") && row["Segmento"] != DBNull.Value)
                Segmento = Convert.ToString(row["Segmento"]);
            //RQ_PBS - R2161
            if (DataRecord.HasColumn(row, "ConfiguracionZona") && row["ConfiguracionZona"] != DBNull.Value)
                ConfiguracionZona = Convert.ToString(row["ConfiguracionZona"]);
        }
    }
}
