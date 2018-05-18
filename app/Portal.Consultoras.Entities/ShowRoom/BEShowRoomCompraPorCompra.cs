using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (datarec.HasColumn("CompraxCompraID"))
                CompraxCompraID = DbConvert.ToInt32(datarec["CompraxCompraID"]);
            if (datarec.HasColumn("EventoID"))
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (datarec.HasColumn("CUV"))
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (datarec.HasColumn("SAP"))
                SAP = DbConvert.ToString(datarec["SAP"]);
            if (datarec.HasColumn("Orden"))
                Orden = DbConvert.ToInt32(datarec["Orden"]);
            if (datarec.HasColumn("PrecioValorizado"))
                PrecioValorizado = DbConvert.ToDecimal(datarec["PrecioValorizado"]);
            if (datarec.HasColumn("UsuarioCreacion"))
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (datarec.HasColumn("FechaCreacion"))
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (datarec.HasColumn("UsuarioModificacion"))
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (datarec.HasColumn("FechaModificacion"))
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
        }
    }
}
