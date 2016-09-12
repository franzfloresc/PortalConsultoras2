using Portal.Consultoras.Common;
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
    public class BESuenioNavidad
    {
        [DataMember]
        public int PaisID {get;set;}
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Canal { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }

        public BESuenioNavidad(IDataRecord datarec)
        {            
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = Convert.ToInt32(datarec["CampaniaID"]);

            if (DataRecord.HasColumn(datarec, "Region"))
                Region = Convert.ToString(datarec["Region"]);

            if (DataRecord.HasColumn(datarec, "Zona"))
                Zona = Convert.ToString(datarec["Zona"]);
            
            if (DataRecord.HasColumn(datarec, "Seccion"))
                Seccion = Convert.ToString(datarec["Seccion"]);

            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(datarec["CodigoConsultora"]);

            if (DataRecord.HasColumn(datarec, "NombreCompleto"))
                NombreCompleto = Convert.ToString(datarec["NombreCompleto"]);

            if (DataRecord.HasColumn(datarec, "Descripcion"))
                Descripcion = Convert.ToString(datarec["Descripcion"]);

            if (DataRecord.HasColumn(datarec, "Canal"))
                Canal = Convert.ToString(datarec["Canal"]);

        }

    }
}
