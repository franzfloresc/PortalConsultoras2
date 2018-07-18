using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEResumenCampania
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public decimal SaldoPendiente { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int Cantidad { get; set; }


        public BEResumenCampania(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            ConsultoraID = row.ToInt32("ConsultoraID");
            MarcaID = row.ToInt32("MarcaID");
            Marca = row.ToString("Marca");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            SaldoPendiente = row.ToDecimal("SaldoPendiente");
            Cantidad = row.ToInt32("Cantidad");
        }

    }
}
