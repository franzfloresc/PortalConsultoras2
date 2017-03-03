using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomCompraPorCompra
    {
        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string SAP { get; set; }

        [DataMember]
        public bool MostrarPopup { get; set; }

        public BEShowRoomCompraPorCompra(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CUV") && datarec["CUV"] != DBNull.Value)
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "SAP") && datarec["SAP"] != DBNull.Value)
                SAP = DbConvert.ToString(datarec["SAP"]);
        }
    }
}
