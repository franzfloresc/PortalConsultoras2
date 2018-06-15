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
                CompraxCompraID = Convert.ToInt32(datarec["CompraxCompraID"]);
            if (datarec.HasColumn("EventoID"))
                EventoID = Convert.ToInt32(datarec["EventoID"]);
            if (datarec.HasColumn("CUV"))
                CUV = Convert.ToString(datarec["CUV"]);
            if (datarec.HasColumn("SAP"))
                SAP = Convert.ToString(datarec["SAP"]);
            if (datarec.HasColumn("Orden"))
                Orden = Convert.ToInt32(datarec["Orden"]);
            if (datarec.HasColumn("PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(datarec["PrecioValorizado"]);
            if (datarec.HasColumn("UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(datarec["UsuarioCreacion"]);
            if (datarec.HasColumn("FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(datarec["FechaCreacion"]);
            if (datarec.HasColumn("UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(datarec["UsuarioModificacion"]);
            if (datarec.HasColumn("FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(datarec["FechaModificacion"]);
        }
    }
}
