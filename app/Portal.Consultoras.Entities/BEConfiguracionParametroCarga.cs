using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionParametroCarga
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public int RegionID { set; get; }
        [DataMember]
        public string RegionNombre { set; get; }
        [DataMember]
        public int ZonaID { set; get; }
        [DataMember]
        public string ZonaNombre { set; get; }
        [DataMember]
        public Int16 ValidacionActiva { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public Int16 DiasParametroCarga { get; set; }
        [DataMember]
        public Int16 DiasDuracionCronograma { get; set; }

        public BEConfiguracionParametroCarga()
        { }

        public BEConfiguracionParametroCarga(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            RegionID = row.ToInt32("RegionID");
            RegionNombre = row.ToString("RegionNombre");
            ZonaID = row.ToInt32("ZonaID");
            ZonaNombre = row.ToString("ZonaNombre");
            ValidacionActiva = row.ToInt16("ValidacionActiva");
            if (DataRecord.HasColumn(row, "DiasParametroCarga"))
                DiasParametroCarga = Convert.ToInt16(Convert.IsDBNull(row["DiasParametroCarga"]) ? 1 : row["DiasParametroCarga"]);
            if (DataRecord.HasColumn(row, "DiasDuracionCronograma"))
                DiasDuracionCronograma = Convert.ToInt16(Convert.IsDBNull(row["DiasDuracionCronograma"]) ? 1 : row["DiasDuracionCronograma"]);
        }
    }
}
