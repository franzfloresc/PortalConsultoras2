﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEDatosBelcorp
    {
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string NombreComercial { get; set; }
        [DataMember]
        public string RUC { get; set; }
        [DataMember]
        public string Direccion { get; set; }

        public BEDatosBelcorp()
        { }

        public BEDatosBelcorp(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "RazonSocial"))
                RazonSocial = Convert.ToString(row["RazonSocial"]);
            if (DataRecord.HasColumn(row, "NombreComercial"))
                NombreComercial = Convert.ToString(row["NombreComercial"]);
            if (DataRecord.HasColumn(row, "RUC"))
                RUC = Convert.ToString(row["RUC"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
        }
    }
}
