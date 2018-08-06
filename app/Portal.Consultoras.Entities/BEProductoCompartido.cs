using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoCompartido
    {
        [DataMember]
        public int PcCampaniaID { get; set; }

        [DataMember]
        public string PcCuv { get; set; }

        [DataMember]
        public string PcPalanca { get; set; }

        [DataMember]
        public string PcDetalle { get; set; }

        [DataMember]
        public string PcApp { get; set; }

        [DataMember]
        public int PcID { get; set; }

        [DataMember]
        public int PaisID { get; set; }


        public BEProductoCompartido(IDataRecord row)
        {
            PcID = row.ToInt32("ProductoCompID");
            PcCampaniaID = row.ToInt32("CampaniaID");
            PcCuv = row.ToString("CUV");
            PcPalanca = row.ToString("Palanca");
            PcDetalle = row.ToString("Detalle");
            PcApp = row.ToString("Applicacion");
        }
    }
}
