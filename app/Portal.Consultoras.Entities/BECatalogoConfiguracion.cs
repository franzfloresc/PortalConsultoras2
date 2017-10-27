﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoConfiguracion
    {
        [DataMember]
        public int CatalogoID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public int CampaniaInicio { get; set; }
        [DataMember]
        public int CampaniaFin { get; set; }

        public BECatalogoConfiguracion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CatalogoID"))
                CatalogoID = Convert.ToInt32(row["CatalogoID"]);
            if (DataRecord.HasColumn(row, "MarcaID"))
                MarcaID = Convert.ToInt16(row["MarcaID"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToInt16(row["Estado"]);
            if (DataRecord.HasColumn(row, "CampaniaInicio"))
                CampaniaInicio = Convert.ToInt32(row["CampaniaInicio"]);
            if (DataRecord.HasColumn(row, "CampaniaFin"))
                CampaniaFin = Convert.ToInt32(row["CampaniaFin"]);
        }
    }
}
