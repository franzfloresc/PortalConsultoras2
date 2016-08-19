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
    public class BEServicioParametro
    {
        [DataMember]
        public int ParametroId { get; set; }
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Abreviatura { get; set; }
        [DataMember]
        public string Correlativo { get; set; }

        public BEServicioParametro()
        {
        }

        public BEServicioParametro(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ParametroId") && row["ParametroId"] != DBNull.Value)
                ParametroId = Convert.ToInt32(row["ParametroId"]);
            if (DataRecord.HasColumn(row, "ServicioId") && row["ServicioId"] != DBNull.Value)
                ServicioId = Convert.ToInt32(row["ServicioId"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Abreviatura") && row["Abreviatura"] != DBNull.Value)
                Abreviatura = Convert.ToString(row["Abreviatura"]);
            if (DataRecord.HasColumn(row, "Correlativo") && row["Correlativo"] != DBNull.Value)
                Correlativo = Convert.ToString(row["Correlativo"]);
        }
    }
}
