using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIndicadorPedidoAutentico
    {
        [DataMember]
        public int PedidoID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int PedidoDetalleID { get; set; }

        [DataMember]
        public string IndicadorIPUsuario { get; set; }

        [DataMember]
        public string IndicadorFingerprint { get; set; }

        [DataMember]
        public string IndicadorToken { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEIndicadorPedidoAutentico()
        {

        }

        public BEIndicadorPedidoAutentico(IDataRecord row)
        {
            PedidoID = row.ToInt32("PedidoID");
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoDetalleID = row.ToInt32("PedidoDetalleID");
            IndicadorIPUsuario = row.ToString("IndicadorIPUsuario");
            IndicadorFingerprint = row.ToString("IndicadorFingerprint");
            IndicadorToken = row.ToString("IndicadorToken");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
        }
    }
}
