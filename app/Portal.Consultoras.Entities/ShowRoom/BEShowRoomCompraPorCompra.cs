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
        [ViewProperty]
        public int CompraxCompraID { get; set; }

        [DataMember]
        [ViewProperty]
        public int EventoID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string SAP { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public decimal PrecioValorizado { get; set; }
        
        [DataMember]
        [ViewProperty]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [ViewProperty]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [ViewProperty]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [ViewProperty]
        public string UsuarioModificacion { get; set; }

        public BEShowRoomCompraPorCompra(IDataRecord datarec)
        {
            if (datarec.HasColumn("CompraxCompraID") && datarec["CompraxCompraID"] != DBNull.Value)
                CompraxCompraID = DbConvert.ToInt32(datarec["CompraxCompraID"]);
            if (datarec.HasColumn("EventoID") && datarec["EventoID"] != DBNull.Value)
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (datarec.HasColumn("CUV") && datarec["CUV"] != DBNull.Value)
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (datarec.HasColumn("SAP") && datarec["SAP"] != DBNull.Value)
                SAP = DbConvert.ToString(datarec["SAP"]);            
            if (datarec.HasColumn("Orden") && datarec["Orden"] != DBNull.Value)
                Orden = DbConvert.ToInt32(datarec["Orden"]);
            if (datarec.HasColumn("PrecioValorizado") && datarec["PrecioValorizado"] != DBNull.Value)
                PrecioValorizado = DbConvert.ToDecimal(datarec["PrecioValorizado"]);
            if (datarec.HasColumn("UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (datarec.HasColumn("FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (datarec.HasColumn("UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (datarec.HasColumn("FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
        }
    }
}
