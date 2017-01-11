using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoCompartido
    {
        //private int miPcCampaniaID;
        //private string miPcCuv;
        //private string miPcPalanca;
        //private int miPcDetalle;
        //private int miPcApp;
        //private int miPcID;
        //private int miPaisID;

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
            this.PcID = Convert.ToInt32(row["ProductoCompID"]);
            this.PcCampaniaID = Convert.ToInt32(row["CampaniaID"]);
            this.PcCuv = Convert.ToString(row["CUV"]);
            this.PcPalanca = Convert.ToString(row["Palanca"]);
            this.PcDetalle = Convert.ToString(row["Detalle"]);
            this.PcApp = Convert.ToString(row["Applicacion"]);
        }
    }
}
