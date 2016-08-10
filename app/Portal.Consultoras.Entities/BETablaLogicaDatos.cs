using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETablaLogicaDatos
    {
        [DataMember]
        public Int16 TablaLogicaDatosID { get; set; }
        [DataMember]
        public Int16 TablaLogicaID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BETablaLogicaDatos(IDataRecord row)
        {
            TablaLogicaDatosID = Convert.ToInt16(row["TablaLogicaDatosID"]);
            TablaLogicaID = Convert.ToInt16(row["TablaLogicaID"]);
            Codigo = Convert.ToString(row["Codigo"]);
            Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
