using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEVisaConfiguracion
    {
        [DataMember]
        public string Parametro { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEVisaConfiguracion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Parametro"))
                Parametro = Convert.ToString(row["Parametro"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "Valor"))
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}