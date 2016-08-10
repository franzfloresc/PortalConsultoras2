using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.ServiceOFAppCatalogo.Entities
{
    [DataContract]
    public class Producto
    {
        [DataMember]
        public string Cuv { get; set; }
        public string CodigoSap { get; set; }


        public Producto(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "Cuv") && datarec["Cuv"] != DBNull.Value)
                Cuv = Convert.ToString(datarec["Cuv"]);
            if (DataRecord.HasColumn(datarec, "CodigoSap") && datarec["CodigoSap"] != DBNull.Value)
                CodigoSap = Convert.ToString(datarec["CodigoSap"]); 
        }
    }
}