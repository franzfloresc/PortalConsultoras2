using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETerminosCondiciones
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public bool Aceptado { get; set; }
        [DataMember]
        public short Tipo { get; set; }

        public BETerminosCondiciones(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "Aceptado"))
                Aceptado = Convert.ToBoolean(row["Aceptado"]);

            if (DataRecord.HasColumn(row, "Tipo"))
                Tipo = Convert.ToInt16(row["Tipo"]);
        }

        public BETerminosCondiciones()
        {

        }
    }
}
