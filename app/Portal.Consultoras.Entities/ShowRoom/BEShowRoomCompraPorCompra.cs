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
        public int OfertaShowRoomID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        public int MarcaID { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string CodigoProducto { get; set; }

        public BEShowRoomCompraPorCompra(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "OfertaShowRoomID") && datarec["OfertaShowRoomID"] != DBNull.Value)
                OfertaShowRoomID = DbConvert.ToInt32(datarec["OfertaShowRoomID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV") && datarec["CUV"] != DBNull.Value)
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "PrecioCatalogo") && datarec["PrecioCatalogo"] != DBNull.Value)
                PrecioCatalogo = DbConvert.ToDecimal(datarec["PrecioCatalogo"]);
            if (DataRecord.HasColumn(datarec, "MarcaID") && datarec["MarcaID"] != DBNull.Value)
                MarcaID = DbConvert.ToInt32(datarec["MarcaID"]);
            if (DataRecord.HasColumn(datarec, "Orden") && datarec["Orden"] != DBNull.Value)
                Orden = DbConvert.ToInt32(datarec["Orden"]);
            if (DataRecord.HasColumn(datarec, "CodigoProducto") && datarec["CodigoProducto"] != DBNull.Value)
                CodigoProducto = DbConvert.ToString(datarec["CodigoProducto"]);
        }
    }
}
