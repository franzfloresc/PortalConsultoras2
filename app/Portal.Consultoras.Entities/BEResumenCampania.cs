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
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt32(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "Marca"))
                Marca = Convert.ToString(row["Marca"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            
            if (DataRecord.HasColumn(row, "SaldoPendiente"))
                SaldoPendiente = Convert.ToDecimal(row["SaldoPendiente"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
        }

    }
}
