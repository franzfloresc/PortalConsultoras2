
using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.Estrategia
{
    [DataContract]
    public class UpSellingRegalo
    {
        [DataMember]
        public int CampaniaId { get; set; }

        [DataMember]
        public int ConsultoraId { get; set; }

        [DataMember]
        public decimal MontoPedido { get; set; }

        [DataMember]
        public decimal GapMinimo { get; set; }

        [DataMember]
        public decimal GapMaximo { get; set; }

        [DataMember]
        public decimal GapAgregar { get; set; }

        [DataMember]
        public decimal MontoMeta { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string TipoRango { get; set; }

        [DataMember]
        public decimal MontoPedidoFinal { get; set; }

        [DataMember]
        public int UpSellingDetalleId { get; set; }

        public UpSellingRegalo(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CampaniaId"))
                CampaniaId = Convert.ToInt32(datarec["CampaniaId"]);

            if (DataRecord.HasColumn(datarec, "ConsultoraId"))
                ConsultoraId = Convert.ToInt32(datarec["ConsultoraId"]);

            if (DataRecord.HasColumn(datarec, "MontoPedido"))
                MontoPedido = Convert.ToDecimal(datarec["MontoPedido"]);

            if (DataRecord.HasColumn(datarec, "GapMinimo"))
                GapMinimo = Convert.ToDecimal(datarec["GapMinimo"]);

            if (DataRecord.HasColumn(datarec, "GapMaximo"))
                GapMaximo = Convert.ToDecimal(datarec["GapMaximo"]);

            if (DataRecord.HasColumn(datarec, "GapAgregar"))
                GapAgregar = Convert.ToDecimal(datarec["GapAgregar"]);

            if (DataRecord.HasColumn(datarec, "MontoMeta"))
                MontoMeta = Convert.ToDecimal(datarec["MontoMeta"]);

            if (DataRecord.HasColumn(datarec, "CUV"))
                CUV = Convert.ToString(datarec["CUV"]);

            if (DataRecord.HasColumn(datarec, "TipoRango"))
                TipoRango = Convert.ToString(datarec["TipoRango"]);

        }
    }
}
