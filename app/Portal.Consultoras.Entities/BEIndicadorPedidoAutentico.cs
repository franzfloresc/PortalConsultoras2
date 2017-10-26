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
            PedidoID = Convert.ToInt32(row["PedidoID"]);
            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            PedidoDetalleID = Convert.ToInt32(row["PedidoDetalleID"]);

            if (row.HasColumn("IndicadorIPUsuario"))
                IndicadorIPUsuario = Convert.ToString(row["IndicadorIPUsuario"]);

            if (row.HasColumn("IndicadorFingerprint"))
                IndicadorFingerprint = Convert.ToString(row["IndicadorFingerprint"]);

            if (row.HasColumn("IndicadorToken"))
                IndicadorToken = Convert.ToString(row["IndicadorToken"]);

            if (row.HasColumn("FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);

            if (row.HasColumn("FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
        }
    }
}
