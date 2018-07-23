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
            PcID = Convert.ToInt32(row["ProductoCompID"]);
            PcCampaniaID = Convert.ToInt32(row["CampaniaID"]);
            PcCuv = Convert.ToString(row["CUV"]);
            PcPalanca = Convert.ToString(row["Palanca"]);
            PcDetalle = Convert.ToString(row["Detalle"]);
            PcApp = Convert.ToString(row["Applicacion"]);
        }
    }
}
