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
    public class BEEscalaDescuentoZona
    {
        [DataMember]
        public string CampaniaId { get; set; }
        [DataMember]
        public string CodRegion { get; set; }
        [DataMember]
        public string CodZona { get; set; }
        [DataMember]
        public decimal MontoHasta { get; set; }
        [DataMember]
        public int PorDescuento { get; set; }
        [DataMember]
        public DateTime? FechaCarga { get; set; }

        public BEEscalaDescuentoZona()
        {
            CampaniaId = default(string);
            CodRegion = default(string);
            CodZona = default(string);
            MontoHasta = default(decimal);
            PorDescuento = default(Int32);
            FechaCarga = default(DateTime);
        }

        public BEEscalaDescuentoZona(IDataRecord row)
        {
            CampaniaId = DataRecord.GetColumn<string>(row, "CampaniaId");
            CodRegion = DataRecord.GetColumn<string>(row, "CodRegion");
            CodZona = DataRecord.GetColumn<string>(row, "CodZona");
            MontoHasta = DataRecord.GetColumn<decimal>(row, "MontoHasta");
            PorDescuento = DataRecord.GetColumn<int>(row, "PorDescuento");
            FechaCarga = DataRecord.GetColumn<DateTime>(row, "FechaCarga");
        }
    }
}
