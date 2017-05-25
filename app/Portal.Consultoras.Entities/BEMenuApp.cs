using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMenuApp
    {
        [DataMember]
        public int MenuAppId { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string CodigoMenuPadre { get; set; }
        [DataMember]
        public int Posicion { get; set; }
        [DataMember]
        public List<BEMenuApp> SubMenus { get; set; }

        public BEMenuApp(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "MenuAppId") && row["MenuAppId"] != DBNull.Value)
                MenuAppId = Convert.ToInt32(row["MenuAppId"]);
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
            if (DataRecord.HasColumn(row, "CodigoMenuPadre") && row["CodigoMenuPadre"] != DBNull.Value)
                CodigoMenuPadre = Convert.ToString(row["CodigoMenuPadre"]);
            if (DataRecord.HasColumn(row, "Posicion") && row["Posicion"] != DBNull.Value)
                Posicion = Convert.ToInt32(row["Posicion"]);
        }
    }
}