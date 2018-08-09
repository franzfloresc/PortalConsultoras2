﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionValidacionZona
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
        public Int16 DiasDuracionCronograma { get; set; }

        public BEConfiguracionValidacionZona()
        { }

        public BEConfiguracionValidacionZona(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            RegionID = row.ToInt32("RegionID");
            RegionNombre = row.ToString("RegionNombre");
            ZonaID = row.ToInt32("ZonaID");
            ZonaNombre = row.ToString("ZonaNombre");
            ValidacionActiva = row.ToInt16("ValidacionActiva");
            DiasDuracionCronograma = row.ToInt16("DiasDuracionCronograma", 1);
        }
    }
}
