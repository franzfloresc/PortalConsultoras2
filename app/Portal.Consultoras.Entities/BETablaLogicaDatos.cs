using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETablaLogicaDatos
    {
        [DataMember]
        public short TablaLogicaDatosID { get; set; }
        [DataMember]
        public short TablaLogicaID { get; set; }
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
