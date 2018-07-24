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

        public BEShowRoomCompraPorCompra(IDataRecord row)
        {
            CompraxCompraID = row.ToInt32("CompraxCompraID");
            EventoID = row.ToInt32("EventoID");
            CUV = row.ToString("CUV");
            SAP = row.ToString("SAP");
            Orden = row.ToInt32("Orden");
            PrecioValorizado = row.ToDecimal("PrecioValorizado");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
        }
    }
}
